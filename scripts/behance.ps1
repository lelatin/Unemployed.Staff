# Met à jour les aperçus Behance de l'annuaire à partir des flux RSS publics.
# - lit profiles.json, repère chaque lien Behance (behance.net/<pseudo>)
# - récupère les 4 derniers projets (titre, lien, image de couverture)
# - télécharge les couvertures dans img/behance/ (aucun appel à Behance depuis le navigateur des visiteurs)
# - écrit behance.json, lu par index.html
# Lancé chaque semaine par .github/workflows/behance.yml, ou à la main : pwsh scripts/behance.ps1

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$root     = Split-Path -Parent $PSScriptRoot
$jsonPath = Join-Path $root "behance.json"
$imgDir   = Join-Path (Join-Path $root "img") "behance"
$max      = 4
New-Item -ItemType Directory -Force $imgDir | Out-Null

$utf8 = New-Object Text.UTF8Encoding($false)
$profiles = [IO.File]::ReadAllText((Join-Path $root "profiles.json"), $utf8) | ConvertFrom-Json
$prev = $null
if (Test-Path $jsonPath) { try { $prev = [IO.File]::ReadAllText($jsonPath, $utf8) | ConvertFrom-Json } catch { } }

$out  = [ordered]@{}
$keep = @{}

foreach ($p in $profiles) {
  if (-not $p.behance) { continue }
  $m = [regex]::Match([string]$p.behance, 'behance\.net/([A-Za-z0-9_.-]+)', 'IgnoreCase')
  if (-not $m.Success) { continue }
  $user = $m.Groups[1].Value
  if ($out.Contains($user)) { continue }

  try {
    $r = Invoke-WebRequest -UseBasicParsing -TimeoutSec 30 -Uri ("https://www.behance.net/feeds/user?username=" + [Uri]::EscapeDataString($user))
    [xml]$xml = $utf8.GetString($r.RawContentStream.ToArray())
    $items = @($xml.SelectNodes("//channel/item"))
  } catch {
    Write-Warning "Behance $user : flux illisible ($($_.Exception.Message)). On garde les aperçus précédents."
    if ($prev -and $prev.$user) {
      $out[$user] = @($prev.$user)
      foreach ($e in @($prev.$user)) { $keep[(Split-Path -Leaf $e.img)] = $true }
    }
    continue
  }

  $list = @()
  foreach ($it in $items) {
    if ($list.Count -ge $max) { break }
    $title = $it.SelectSingleNode("title").InnerText.Trim()
    $link  = $it.SelectSingleNode("link").InnerText.Trim()
    $src   = [regex]::Match($it.SelectSingleNode("description").InnerText, "src=['""]([^'""]+)['""]").Groups[1].Value
    if (-not $src -or $link -notmatch '^https://www\.behance\.net/') { continue }

    $ext  = [IO.Path]::GetExtension(([Uri]$src).AbsolutePath).ToLower()
    if ($ext -notin ".jpg", ".jpeg", ".png", ".gif", ".webp") { $ext = ".jpg" }
    $name = ($user.ToLower() -replace '[^a-z0-9_-]', '-') + "-" + ($list.Count + 1) + $ext
    $file = Join-Path $imgDir $name
    $big  = $src -replace '/projects/404/', '/projects/808/'   # version plus nette si elle existe
    try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 30 -Uri $big -OutFile $file }
    catch { try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 30 -Uri $src -OutFile $file } catch { Write-Warning "Image ignorée : $src"; continue } }

    $keep[$name] = $true
    $list += [ordered]@{ title = $title; link = $link; img = "img/behance/$name" }
  }
  $out[$user] = $list
  Write-Host "Behance $user : $($list.Count) projet(s)"
}

# Supprime les anciennes images qui ne servent plus
Get-ChildItem $imgDir -File | Where-Object { -not $keep.ContainsKey($_.Name) } | Remove-Item -Force

[IO.File]::WriteAllText($jsonPath, ($out | ConvertTo-Json -Depth 5), $utf8)
Write-Host "behance.json mis à jour."

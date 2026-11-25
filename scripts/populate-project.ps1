#requires -Version 5.1
<#
.SYNOPSIS
    Mengisi field Priority, Area, Size, Sprint, Start date, dan Target date
    pada GitHub Project FT Food.

.DESCRIPTION
    Data diambil dari metadata docs/03-backlog.md dan pembagian minggu di
    docs/05-execution-plan-2-months.md. Skrip aman dijalankan berulang karena
    hanya menimpa nilai field dengan nilai yang sama.

.PARAMETER Owner
    Pemilik project. Default: akun gh yang sedang login.

.PARAMETER ProjectNumber
    Nomor project, misalnya 4. Wajib diisi.

.PARAMETER BacklogPath
    Lokasi docs/03-backlog.md. Default: relatif terhadap folder skrip.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/populate-project.ps1 -ProjectNumber 4
#>
[CmdletBinding()]
param(
    [string]$Owner,
    [int]$ProjectNumber = 0,
    [string]$BacklogPath
)

$ErrorActionPreference = "Stop"

function Invoke-Gh {
    param([Parameter(Mandatory = $true)][string[]]$Arguments)

    $output = & gh @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    $text = ($output | Out-String).Trim()

    if ($exitCode -ne 0) {
        throw "gh $($Arguments -join ' ') gagal (exit $exitCode):`n$text"
    }
    return $text
}

if ([string]::IsNullOrWhiteSpace($Owner)) {
    $Owner = Invoke-Gh -Arguments @("api", "user", "--jq", ".login")
}
if ($ProjectNumber -le 0) {
    throw "Isi -ProjectNumber dengan nomor project, misalnya -ProjectNumber 4."
}

if ([string]::IsNullOrWhiteSpace($BacklogPath)) {
    $BacklogPath = Join-Path (Split-Path -Parent $PSScriptRoot) "docs/03-backlog.md"
}
if (-not (Test-Path -LiteralPath $BacklogPath)) {
    throw "Backlog tidak ditemukan: $BacklogPath"
}

Write-Host "==> Membaca backlog" -ForegroundColor Cyan
$raw = Get-Content -LiteralPath $BacklogPath -Raw -Encoding UTF8
$pattern = '<!--\s*issue\s*(\{.*?\})\s*-->\s*(.*?)<!--\s*/issue\s*-->'
$issueMatches = [regex]::Matches($raw, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
if ($issueMatches.Count -eq 0) {
    throw "Tidak ada metadata issue di $BacklogPath"
}

$metaByKey = @{}
foreach ($match in $issueMatches) {
    $meta = $match.Groups[1].Value | ConvertFrom-Json
    if ($metaByKey.ContainsKey($meta.key)) {
        throw "Key duplikat: $($meta.key)"
    }
    $metaByKey[$meta.key] = $meta
}
Write-Host "    OK  $($metaByKey.Count) issue" -ForegroundColor Green

# Pembagian minggu mengikuti docs/05-execution-plan-2-months.md bagian 5.
$weeks = @(
    [pscustomobject]@{ Week = 1; Sprint = "Sprint 0"; Start = "2026-12-01"; Target = "2026-12-06"; Keys = @("DISC-01", "DISC-02") },
    [pscustomobject]@{ Week = 2; Sprint = "Sprint 1"; Start = "2026-12-07"; Target = "2026-12-13"; Keys = @("DISC-03", "DISC-04", "DISC-05", "DEV-01") },
    [pscustomobject]@{ Week = 3; Sprint = "Sprint 1"; Start = "2026-12-14"; Target = "2026-12-20"; Keys = @("DES-01", "DES-02", "DES-03", "DES-04", "DES-05", "DES-06") },
    [pscustomobject]@{ Week = 4; Sprint = "Sprint 2"; Start = "2026-12-21"; Target = "2026-12-27"; Keys = @("DEV-02", "DEV-03", "DEV-04", "DEV-05", "DEV-06", "OPS-02") },
    [pscustomobject]@{ Week = 5; Sprint = "Sprint 2"; Start = "2026-12-28"; Target = "2027-01-03"; Keys = @("DEV-07", "DEV-08", "DEV-09", "DEV-10", "QA-01") },
    [pscustomobject]@{ Week = 6; Sprint = "Sprint 3"; Start = "2027-01-04"; Target = "2027-01-10"; Keys = @("DEV-11", "DEV-12", "DEV-13", "QA-02") },
    [pscustomobject]@{ Week = 7; Sprint = "Sprint 3"; Start = "2027-01-11"; Target = "2027-01-17"; Keys = @("DEV-14", "QA-03", "QA-04", "OPS-01") },
    [pscustomobject]@{ Week = 8; Sprint = "Sprint 4"; Start = "2027-01-18"; Target = "2027-01-24"; Keys = @("QA-05", "OPS-03") },
    [pscustomobject]@{ Week = 9; Sprint = "Sprint 4"; Start = "2027-01-25"; Target = "2027-01-31"; Keys = @("OPS-04", "OPS-05") }
)

$weekByKey = @{}
$weekKeys = @()
foreach ($week in $weeks) {
    foreach ($key in $week.Keys) {
        if ($weekByKey.ContainsKey($key)) {
            throw "Issue $key muncul di lebih dari satu minggu."
        }
        $weekByKey[$key] = $week
        $weekKeys += $key
    }
}

$missingWeeks = @($metaByKey.Keys | Where-Object { -not $weekByKey.ContainsKey($_) })
$unknownKeys = @($weekKeys | Where-Object { -not $metaByKey.ContainsKey($_) })
if ($missingWeeks.Count -gt 0) { throw "Issue belum punya jadwal: $($missingWeeks -join ', ')" }
if ($unknownKeys.Count -gt 0) { throw "Issue di jadwal tidak ada di backlog: $($unknownKeys -join ', ')" }
if ($weekKeys.Count -ne $metaByKey.Count) { throw "Jumlah issue di jadwal tidak sama dengan backlog." }

$priorityOptions = @{
    "priority/p0" = "P0 - Critical"
    "priority/p1" = "P1 - High"
    "priority/p2" = "P2 - Medium"
    "priority/p3" = "P3 - Low"
}
$areaOptions = @{
    "area/discovery" = "Discovery"
    "area/design" = "Design"
    "area/cust" = "Cust"
    "area/tenant" = "Tenant"
    "area/payment" = "Payment"
    "area/platform" = "Platform"
    "area/qa" = "QA"
    "area/ops" = "Ops"
}
$sizeOptions = @{
    "1" = "1 - XS"
    "2" = "2 - S"
    "3" = "3 - M"
    "5" = "5 - L"
    "6" = "8 - XL"
    "7" = "8 - XL"
    "8" = "8 - XL"
}

Write-Host "==> Membaca project #$ProjectNumber" -ForegroundColor Cyan
$projectRaw = Invoke-Gh -Arguments @("project", "view", "$ProjectNumber", "--owner", $Owner, "--format", "json")
$projectData = $projectRaw | ConvertFrom-Json
$projectId = $projectData.id
if ([string]::IsNullOrWhiteSpace($projectId)) {
    throw "ID project tidak ditemukan."
}

$fieldRaw = Invoke-Gh -Arguments @("project", "field-list", "$ProjectNumber", "--owner", $Owner, "--format", "json")
$fieldData = $fieldRaw | ConvertFrom-Json
$fields = @($fieldData.fields)

$fieldIds = @{}
$optionIds = @{}
foreach ($field in $fields) {
    $fieldIds[$field.name] = $field.id
    if ($null -ne $field.options) {
        $optionIds[$field.name] = @{}
        foreach ($option in $field.options) {
            $optionIds[$field.name][$option.name] = $option.id
        }
    }
}

$requiredFields = @("Priority", "Area", "Size", "Sprint", "Start date", "Target date")
foreach ($name in $requiredFields) {
    if (-not $fieldIds.ContainsKey($name)) {
        throw "Field '$name' tidak ditemukan di project #$ProjectNumber."
    }
}

$itemRaw = Invoke-Gh -Arguments @("project", "item-list", "$ProjectNumber", "--owner", $Owner, "--limit", "100", "--format", "json")
$itemData = $itemRaw | ConvertFrom-Json
$items = @($itemData.items)

function Set-SelectValue {
    param([string]$ItemId, [string]$FieldName, [string]$OptionName)

    $fieldId = $fieldIds[$FieldName]
    $options = $optionIds[$FieldName]
    if ($null -eq $options -or -not $options.ContainsKey($OptionName)) {
        throw "Opsi '$OptionName' tidak ada pada field '$FieldName'."
    }
    [void](Invoke-Gh -Arguments @(
        "project", "item-edit",
        "--id", $ItemId,
        "--field-id", $fieldId,
        "--project-id", $projectId,
        "--single-select-option-id", $options[$OptionName]
    ))
}

function Set-DateValue {
    param([string]$ItemId, [string]$FieldName, [string]$Value)

    [void](Invoke-Gh -Arguments @(
        "project", "item-edit",
        "--id", $ItemId,
        "--field-id", $fieldIds[$FieldName],
        "--project-id", $projectId,
        "--date", $Value
    ))
}

Write-Host "==> Mengisi field untuk $($items.Count) item" -ForegroundColor Cyan
$updated = 0
$failedItems = 0

foreach ($item in $items) {
    $title = $null
    if ($null -ne $item.content) { $title = $item.content.title }
    if ([string]::IsNullOrWhiteSpace($title)) { continue }

    $titleMatch = [regex]::Match($title, '^\[([A-Z]+-\d+)\]')
    if (-not $titleMatch.Success) {
        Write-Host "    !!  Lewati item tanpa key: $title" -ForegroundColor Yellow
        continue
    }

    $key = $titleMatch.Groups[1].Value
    if (-not $metaByKey.ContainsKey($key)) {
        Write-Host "    !!  $key tidak ada di backlog, dilewati" -ForegroundColor Yellow
        continue
    }

    $meta = $metaByKey[$key]
    $week = $weekByKey[$key]

    $priorityLabel = @($meta.labels | Where-Object { $_ -like "priority/*" }) | Select-Object -First 1
    $areaLabel = @($meta.labels | Where-Object { $_ -like "area/*" }) | Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($priorityLabel) -or [string]::IsNullOrWhiteSpace($areaLabel)) {
        Write-Host "    !!  $key tidak punya label priority/area, dilewati" -ForegroundColor Yellow
        continue
    }

    try {
        Set-SelectValue -ItemId $item.id -FieldName "Priority" -OptionName $priorityOptions[$priorityLabel]
        Set-SelectValue -ItemId $item.id -FieldName "Area" -OptionName $areaOptions[$areaLabel]
        Set-SelectValue -ItemId $item.id -FieldName "Size" -OptionName $sizeOptions[[string]$meta.estimate]
        Set-SelectValue -ItemId $item.id -FieldName "Sprint" -OptionName $week.Sprint
        Set-DateValue -ItemId $item.id -FieldName "Start date" -Value $week.Start
        Set-DateValue -ItemId $item.id -FieldName "Target date" -Value $week.Target

        $updated++
        Write-Host "    ++  $key" -ForegroundColor Green
    }
    catch {
        $failedItems++
        Write-Host "    !!  $key gagal: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Selesai: $updated item diperbarui, $failedItems gagal." -ForegroundColor Cyan
if ($failedItems -gt 0) { exit 1 }

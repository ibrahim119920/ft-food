#requires -Version 5.1
<#
.SYNOPSIS
    Menambahkan Checkpoint dan Risks ke GitHub Project FT Food.

.DESCRIPTION
    Checkpoint dan Risks dibuat sebagai draft item di project, bukan issue
    repository. Keduanya dibedakan lewat field Item type, field khusus, dan
    judul [CP] / [RISK-xx]. Skrip aman dijalankan berulang.

.PARAMETER Owner
    Pemilik project. Default: akun gh yang sedang login.

.PARAMETER ProjectNumber
    Nomor project, misalnya 4. Wajib diisi.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/add-checkpoints-risks.ps1 -ProjectNumber 4
#>
[CmdletBinding()]
param(
    [string]$Owner,
    [int]$ProjectNumber = 0
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

Write-Host "==> Memeriksa field project #$ProjectNumber" -ForegroundColor Cyan
$fieldDefs = @(
    [pscustomobject]@{ Name = "Item type";   Options = @("Delivery", "Checkpoint", "Risk") },
    [pscustomobject]@{ Name = "Checkpoint";  Options = @("G0", "G1", "G2", "G3", "G4", "G5", "G6", "G7", "G8") },
    [pscustomobject]@{ Name = "Gate result"; Options = @("Pending", "Passed", "Failed", "Deferred") },
    [pscustomobject]@{ Name = "Risk level";  Options = @("Critical", "High", "Medium", "Low") },
    [pscustomobject]@{ Name = "Risk status"; Options = @("Open", "Monitoring", "Mitigated", "Accepted") }
)

function Get-FieldState {
    $raw = Invoke-Gh -Arguments @("project", "field-list", "$ProjectNumber", "--owner", $Owner, "--format", "json")
    $data = $raw | ConvertFrom-Json
    $list = @($data.fields)

    $ids = @{}
    $options = @{}
    foreach ($field in $list) {
        $ids[$field.name] = $field.id
        if ($null -ne $field.options) {
            $options[$field.name] = @{}
            foreach ($option in $field.options) {
                $options[$field.name][$option.name] = $option.id
            }
        }
    }
    return [pscustomobject]@{ Ids = $ids; Options = $options }
}

$state = Get-FieldState
$createdFields = 0
foreach ($def in $fieldDefs) {
    if ($state.Ids.ContainsKey($def.Name)) { continue }

    [void](Invoke-Gh -Arguments @(
        "project", "field-create", "$ProjectNumber",
        "--owner", $Owner,
        "--name", $def.Name,
        "--data-type", "SINGLE_SELECT",
        "--single-select-options", ($def.Options -join ",")
    ))
    $createdFields++
    Write-Host "    ++  field $($def.Name)" -ForegroundColor Green
}
if ($createdFields -gt 0) {
    $state = Get-FieldState
}
Write-Host "    OK  $createdFields field baru, $($fieldDefs.Count) field wajib tersedia" -ForegroundColor Green

$projectRaw = Invoke-Gh -Arguments @("project", "view", "$ProjectNumber", "--owner", $Owner, "--format", "json")
$projectData = $projectRaw | ConvertFrom-Json
$projectId = $projectData.id

function Set-SelectValue {
    param([string]$ItemId, [string]$FieldName, [string]$OptionName)

    $fieldId = $state.Ids[$FieldName]
    $options = $state.Options[$FieldName]
    if ([string]::IsNullOrWhiteSpace($fieldId)) { throw "Field '$FieldName' tidak ditemukan." }
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

    $fieldId = $state.Ids[$FieldName]
    if ([string]::IsNullOrWhiteSpace($fieldId)) { throw "Field '$FieldName' tidak ditemukan." }
    [void](Invoke-Gh -Arguments @(
        "project", "item-edit",
        "--id", $ItemId,
        "--field-id", $fieldId,
        "--project-id", $projectId,
        "--date", $Value
    ))
}

$checkpoints = @(
    [pscustomobject]@{
        Title = "[CP] G0 - PRD v1 disetujui"
        Target = "2026-12-13"
        Body = @'
Syarat lulus:
- PRD v1 disetujui.
- 15 Cust, 5 Tenant, dan 1 pengelola sudah diwawancarai.
- Pertanyaan terbuka sudah diputuskan.

Jika gagal:
- Perpanjang riset maksimal 3 hari.
- Jangan mulai membuat fitur.

Bukti: PRD bertanda tangan dan ringkasan riset.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G1 - Desain dan spesifikasi teknis siap"
        Target = "2026-12-20"
        Body = @'
Syarat lulus:
- ERD, OpenAPI, ADR, dan desain final siap.
- Status pesanan dan hak akses sudah disepakati.
- QRIS sandbox berhasil diuji.

Jika gagal:
- Tunda pembuatan UI.
- Selesaikan dokumen dan QRIS sandbox lebih dulu.

Bukti: tautan ERD, OpenAPI, ADR, Figma, dan hasil uji sandbox.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G2 - Katalog dan keranjang berjalan di staging"
        Target = "2026-12-27"
        Body = @'
Syarat lulus:
- Login dan hak akses berjalan.
- Daftar tenant, detail tenant, dan keranjang berjalan di staging.
- Staging dapat diakses tim dan QA.

Jika gagal:
- Pindahkan pekerjaan katalog ke W5.
- Kurangi fitur opsional, jangan kurangi hak akses.

Bukti: demo alur Cust sampai keranjang dan URL staging.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G3 - Pembayaran sandbox sampai invoice"
        Target = "2027-01-03"
        Body = @'
Syarat lulus:
- Pesanan dibuat dan harga dihitung ulang di server.
- QRIS sandbox dibayar sampai invoice tampil.
- Webhook terverifikasi dan kejadian ganda tidak diproses dua kali.

Jika gagal:
- Fokus ke pembayaran dan kurangi fitur opsional.
- Ini titik paling penting; jangan lanjut ke fitur tenant sebelum lulus.

Bukti: rekaman transaksi sandbox, invoice, dan log webhook.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G4 - Riwayat dan antrean tenant berjalan"
        Target = "2027-01-10"
        Body = @'
Syarat lulus:
- Riwayat Cust menampilkan pesanan dan invoice.
- Tenant dapat melihat antrean dan mengubah status.
- Produk dapat dikelola dan ketersediaannya memengaruhi halaman Cust.

Jika gagal:
- Tunda foto produk.
- Jangan tunda antrean tenant.

Bukti: demo alur pesanan masuk, diproses, dan selesai.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G5 - Kandidat rilis lulus QA"
        Target = "2027-01-17"
        Body = @'
Syarat lulus:
- Laporan omzet dan pencairan tampil.
- E2E, keamanan, dan performa lulus.
- Tidak ada temuan Critical atau High yang terbuka.

Jika gagal:
- Tunda pilot.
- Jangan kurangi pengujian keamanan.

Bukti: laporan QA, hasil E2E, dan tag kandidat rilis.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G6 - UAT disetujui"
        Target = "2027-01-22"
        Body = @'
Syarat lulus:
- Minimal 5 Cust dan 3 Tenant mengikuti UAT.
- Semua bug P0 dan P1 sudah diperbaiki dan diuji ulang.
- Persetujuan tertulis dari pengelola atau PO.

Jika gagal:
- Perbaiki bug lebih dulu.
- Peluncuran dimundurkan, bukan menambah fitur.

Bukti: laporan UAT dan persetujuan tertulis.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G7 - Produksi dan QRIS live terverifikasi"
        Target = "2027-01-24"
        Body = @'
Syarat lulus:
- Rilis dari tag yang lulus UAT.
- Migrasi produksi berjalan dengan backup.
- Transaksi QRIS live nominal kecil berhasil.
- Webhook produksi terverifikasi.

Jika gagal:
- Tunda pilot.
- Jangan memakai QRIS manual di luar ruang lingkup.

Bukti: transaksi live, invoice, dan log webhook produksi.
'@
    },
    [pscustomobject]@{
        Title = "[CP] G8 - Pilot dan serah terima selesai"
        Target = "2027-01-31"
        Body = @'
Syarat lulus:
- Pilot selesai dan metrik harian tercatat.
- Bug P0 dan P1 selama pilot sudah ditangani.
- Retrospektif, daftar versi 1.1, dan serah terima selesai.

Jika gagal:
- Catat utang teknis.
- Jangan menyatakan proyek selesai jika serah terima belum ada.

Bukti: laporan pilot, retrospektif, dan dokumen serah terima.
'@
    }
)

$risks = @(
    [pscustomobject]@{
        Title = "[RISK-01] Persetujuan QRIS live terlambat"
        Level = "High"; Target = "2026-12-14"
        Body = @'
Dampak: Tinggi
Kemungkinan: Tinggi
Pencegahan: Ajukan akun sejak 14 Desember; gunakan sandbox; jangan menunggu live untuk UAT; tunda pilot, bukan menambah fitur.
Pemilik: PM
'@
    },
    [pscustomobject]@{
        Title = "[RISK-02] Aturan pencairan belum jelas"
        Level = "High"; Target = "2026-12-13"
        Body = @'
Dampak: Tinggi
Kemungkinan: Sedang
Pencegahan: Selesaikan aturan di DISC-05 dan PRD; buat buku besar; gunakan transfer manual; cocokkan setiap hari.
Pemilik: PM dan Keuangan
'@
    },
    [pscustomobject]@{
        Title = "[RISK-03] Permintaan fitur baru di tengah jalan"
        Level = "High"; Target = "2026-12-13"
        Body = @'
Dampak: Tinggi
Kemungkinan: Tinggi
Pencegahan: Gunakan PRD dan perubahan resmi; simpan permintaan di luar ruang lingkup; evaluasi setelah pilot.
Pemilik: PM
'@
    },
    [pscustomobject]@{
        Title = "[RISK-04] Waktu tim terbatas karena kuliah"
        Level = "High"; Target = "2026-12-07"
        Body = @'
Dampak: Sedang
Kemungkinan: Tinggi
Pencegahan: Target 50 sampai 60 poin per sprint 2 minggu; cadangan 12,5 persen; utamakan P0 dan P1; gunakan pengurangan ruang lingkup docs/05 bagian 7.
Pemilik: Seluruh tim
'@
    },
    [pscustomobject]@{
        Title = "[RISK-05] Webhook hilang atau diproses ganda"
        Level = "High"; Target = "2027-01-03"
        Body = @'
Dampak: Tinggi
Kemungkinan: Sedang
Pencegahan: Verifikasi tanda tangan; cegah proses ganda; catat audit; jalankan pencocokan data dengan penyedia pembayaran.
Pemilik: Backend
'@
    },
    [pscustomobject]@{
        Title = "[RISK-06] Internet atau perangkat tenant buruk"
        Level = "Medium"; Target = "2027-01-17"
        Body = @'
Dampak: Sedang
Kemungkinan: Sedang
Pencegahan: Uji di HP kelas bawah; gunakan pemeriksaan status berkala dan coba ulang; buat tampilan ringan.
Pemilik: Frontend dan QA
'@
    },
    [pscustomobject]@{
        Title = "[RISK-07] Data antar-tenant bocor"
        Level = "High"; Target = "2027-01-17"
        Body = @'
Dampak: Tinggi
Kemungkinan: Sedang
Pencegahan: Uji hak akses per peran; review keamanan QA-04; selalu batasi query berdasarkan tenant.
Pemilik: Backend dan QA
'@
    },
    [pscustomobject]@{
        Title = "[RISK-08] Harga atau ketersediaan tidak konsisten"
        Level = "High"; Target = "2027-01-03"
        Body = @'
Dampak: Tinggi
Kemungkinan: Sedang
Pencegahan: Hitung ulang harga di server; simpan salinan harga; gunakan transaksi database; periksa ketersediaan.
Pemilik: Backend
'@
    },
    [pscustomobject]@{
        Title = "[RISK-09] Libur akademik menggeser jadwal"
        Level = "Medium"; Target = "2026-12-21"
        Body = @'
Dampak: Sedang
Kemungkinan: Tinggi
Pencegahan: Selesaikan pekerjaan penting di W1 sampai W3; pertahankan checkpoint; kurangi P2; gunakan cadangan W8 dan W9.
Pemilik: PM
'@
    },
    [pscustomobject]@{
        Title = "[RISK-10] Pengetahuan hanya di satu orang"
        Level = "Medium"; Target = "2027-01-17"
        Body = @'
Dampak: Sedang
Kemungkinan: Sedang
Pencegahan: Tulis ADR dan OpenAPI; lakukan pairing; review silang; dokumentasikan operasi dan deployment.
Pemilik: Tech lead
'@
    }
)

Write-Host "==> Membaca item project" -ForegroundColor Cyan
$itemRaw = Invoke-Gh -Arguments @("project", "item-list", "$ProjectNumber", "--owner", $Owner, "--limit", "200", "--format", "json")
$itemData = $itemRaw | ConvertFrom-Json
$items = @($itemData.items)
$existingByTitle = @{}
foreach ($item in $items) {
    if ($null -ne $item.content -and -not [string]::IsNullOrWhiteSpace($item.content.title)) {
        $existingByTitle[$item.content.title] = $item.id
    }
}
Write-Host "    OK  $($items.Count) item sudah ada" -ForegroundColor Green

function Ensure-Item {
    param([string]$Title, [string]$Body)

    if ($existingByTitle.ContainsKey($Title)) {
        return [pscustomobject]@{ Id = $existingByTitle[$Title]; Created = $false }
    }

    $raw = Invoke-Gh -Arguments @(
        "project", "item-create", "$ProjectNumber",
        "--owner", $Owner,
        "--title", $Title,
        "--body", $Body,
        "--format", "json"
    )
    $created = $raw | ConvertFrom-Json
    if ([string]::IsNullOrWhiteSpace($created.id)) {
        throw "ID item baru tidak ditemukan untuk $Title"
    }
    return [pscustomobject]@{ Id = $created.id; Created = $true }
}

Write-Host "==> Menandai item pekerjaan sebagai Delivery" -ForegroundColor Cyan
$deliveryCount = 0
foreach ($item in $items) {
    if ($null -eq $item.content -or [string]::IsNullOrWhiteSpace($item.content.title)) { continue }
    if ($item.content.title.StartsWith("[CP] ") -or $item.content.title.StartsWith("[RISK-")) { continue }
    Set-SelectValue -ItemId $item.id -FieldName "Item type" -OptionName "Delivery"
    $deliveryCount++
}
Write-Host "    OK  $deliveryCount item pekerjaan" -ForegroundColor Green

Write-Host "==> Membuat Checkpoint" -ForegroundColor Cyan
$checkpointCreated = 0
$checkpointUpdated = 0
foreach ($checkpoint in $checkpoints) {
    $result = Ensure-Item -Title $checkpoint.Title -Body $checkpoint.Body
    Set-SelectValue -ItemId $result.Id -FieldName "Item type" -OptionName "Checkpoint"
    $code = [regex]::Match($checkpoint.Title, 'G\d').Value
    Set-SelectValue -ItemId $result.Id -FieldName "Checkpoint" -OptionName $code
    Set-SelectValue -ItemId $result.Id -FieldName "Gate result" -OptionName "Pending"
    Set-DateValue -ItemId $result.Id -FieldName "Target date" -Value $checkpoint.Target
    if ($result.Created) { $checkpointCreated++ } else { $checkpointUpdated++ }
    Write-Host "    ++  $($checkpoint.Title)" -ForegroundColor Green
}
Write-Host "    OK  $checkpointCreated dibuat, $checkpointUpdated diperbarui" -ForegroundColor Green

Write-Host "==> Membuat Risks" -ForegroundColor Cyan
$riskCreated = 0
$riskUpdated = 0
foreach ($risk in $risks) {
    $result = Ensure-Item -Title $risk.Title -Body $risk.Body
    Set-SelectValue -ItemId $result.Id -FieldName "Item type" -OptionName "Risk"
    Set-SelectValue -ItemId $result.Id -FieldName "Risk level" -OptionName $risk.Level
    Set-SelectValue -ItemId $result.Id -FieldName "Risk status" -OptionName "Open"
    Set-DateValue -ItemId $result.Id -FieldName "Target date" -Value $risk.Target
    if ($result.Created) { $riskCreated++ } else { $riskUpdated++ }
    Write-Host "    ++  $($risk.Title)" -ForegroundColor Green
}
Write-Host "    OK  $riskCreated dibuat, $riskUpdated diperbarui" -ForegroundColor Green

Write-Host "==> Menyiapkan tampilan Checkpoints dan Risks" -ForegroundColor Cyan

function Invoke-GraphQl {
    param([string]$Query, [hashtable]$Variables)

    $body = @{ query = $Query; variables = $Variables } | ConvertTo-Json -Depth 10
    $temp = Join-Path ([System.IO.Path]::GetTempPath()) ("ftfood-gql-" + [guid]::NewGuid().ToString("N") + ".json")
    [System.IO.File]::WriteAllText($temp, $body, (New-Object System.Text.UTF8Encoding($false)))
    try {
        $raw = & gh api graphql --input $temp 2>&1
        if ($LASTEXITCODE -ne 0) { throw "GraphQL gagal: $($raw | Out-String)" }
        $result = $raw | ConvertFrom-Json
        if ($result.errors) { throw "GraphQL error: $($result.errors | ConvertTo-Json -Depth 5)" }
        return $result
    }
    finally {
        Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
    }
}

$viewsQuery = @'
query($projectId: ID!) {
  node(id: $projectId) {
    ... on ProjectV2 {
      views(first: 30) { nodes { id name filter layout } }
    }
  }
}
'@

$viewData = Invoke-GraphQl -Query $viewsQuery -Variables @{ projectId = $projectId }
$viewMap = @{}
foreach ($view in $viewData.data.node.views.nodes) { $viewMap[$view.name] = $view }

$createViewMutation = @'
mutation($projectId: ID!, $name: String!, $layout: ProjectV2ViewLayout!) {
  createProjectV2View(input: {projectId: $projectId, name: $name, layout: $layout}) {
    projectV2View { id name filter layout }
  }
}
'@

$updateViewMutation = @'
mutation($viewId: ID!, $filter: String!) {
  updateProjectV2View(input: {viewId: $viewId, filter: $filter}) {
    projectV2View { id name filter }
  }
}
'@

$viewDefs = @(
    [pscustomobject]@{ Name = "Issues"; Layout = "TABLE_LAYOUT"; Filter = "item-type:Delivery" },
    [pscustomobject]@{ Name = "Milestones"; Layout = "ROADMAP_LAYOUT"; Filter = $null },
    [pscustomobject]@{ Name = "Sprints"; Layout = "ROADMAP_LAYOUT"; Filter = $null },
    [pscustomobject]@{ Name = "Checkpoints"; Layout = "TABLE_LAYOUT"; Filter = "item-type:Checkpoint" },
    [pscustomobject]@{ Name = "Risks"; Layout = "TABLE_LAYOUT"; Filter = "item-type:Risk" }
)

foreach ($def in $viewDefs) {
    if ($viewMap.ContainsKey($def.Name)) {
        $viewId = $viewMap[$def.Name].id
    }
    else {
        $createdView = Invoke-GraphQl -Query $createViewMutation -Variables @{
            projectId = $projectId
            name = $def.Name
            layout = $def.Layout
        }
        $viewId = $createdView.data.createProjectV2View.projectV2View.id
    }

    if (-not [string]::IsNullOrWhiteSpace($def.Filter)) {
        [void](Invoke-GraphQl -Query $updateViewMutation -Variables @{
            viewId = $viewId
            filter = $def.Filter
        })
        Write-Host "    OK  tampilan $($def.Name) dengan filter $($def.Filter)" -ForegroundColor Green
    }
    else {
        Write-Host "    OK  tampilan $($def.Name) tersedia (filter tidak diubah)" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Selesai: $checkpointCreated checkpoint dan $riskCreated risk baru ditambahkan." -ForegroundColor Cyan

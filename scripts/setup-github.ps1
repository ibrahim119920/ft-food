#requires -Version 5.1
<#
.SYNOPSIS
    Bootstrap GitHub Project FT Food dari docs/03-backlog.md.

.DESCRIPTION
    Membuat/memperbarui label, milestone, issue, dan (opsional) GitHub Project
    beserta field-nya. Skrip aman dijalankan berulang: issue dengan judul yang sama dilewati.

.PARAMETER Repo
    owner/nama-repo. Default: repo dari direktori aktif.

.PARAMETER ProjectTitle
    Nama project baru. Default: "FT Food — Development".

.PARAMETER StartDate
    Tanggal mulai (yyyy-MM-dd). Default: 2026-12-01 (rencana 2 bulan).
    Due date milestone dihitung untuk W2, W3, W4, W5, W6, W7, dan W9.

.PARAMETER CreateProject
    Buat project baru dan link ke repo. Butuh scope `project`.

.PARAMETER ProjectNumber
    Nomor project yang sudah ada, untuk menambahkan issue ke board.

.PARAMETER SkipProjectItems
    Jangan masukkan issue ke project.

.EXAMPLE
    gh auth refresh -s project
    pwsh -File ./scripts/setup-github.ps1 -CreateProject

.EXAMPLE
    pwsh -File ./scripts/setup-github.ps1 -Repo owner/ft-food -ProjectNumber 3
#>
[CmdletBinding()]
param(
    [string]$Repo,
    [string]$ProjectTitle = "FT Food — Development",
    [string]$StartDate = "2026-12-01",
    [switch]$CreateProject,
    [int]$ProjectNumber = 0,
    [switch]$SkipProjectItems
)

$ErrorActionPreference = "Stop"

function Write-Step([string]$Message) {
    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Write-Ok([string]$Message) {
    Write-Host "    OK  $Message" -ForegroundColor Green
}

function Write-Warn([string]$Message) {
    Write-Host "    !!  $Message" -ForegroundColor Yellow
}

function Invoke-Gh {
    param(
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [switch]$AllowEmpty
    )

    $output = & gh @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    $text = ($output | Out-String).Trim()

    if ($exitCode -ne 0) {
        throw "gh $($Arguments -join ' ') gagal (exit $exitCode):`n$text"
    }

    if (-not $AllowEmpty -and [string]::IsNullOrWhiteSpace($text)) {
        return ""
    }

    return $text
}

# ---------------------------------------------------------------------------
# 0. Validasi prasyarat
# ---------------------------------------------------------------------------

Write-Step "Memeriksa prasyarat"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI (gh) tidak ditemukan di PATH."
}

$ghVersion = (& gh --version | Select-Object -First 1)
Write-Ok $ghVersion

$backlogPath = Join-Path (Split-Path -Parent $PSScriptRoot) "docs/03-backlog.md"
if (-not (Test-Path -LiteralPath $backlogPath)) {
    throw "File backlog tidak ditemukan: $backlogPath"
}

if ([string]::IsNullOrWhiteSpace($Repo)) {
    try {
        $repoInfo = (Invoke-Gh -Arguments @("repo", "view", "--json", "owner,name")) | ConvertFrom-Json
    }
    catch {
        throw "Tidak berada di direktori repo Git/GitHub. Jalankan dari repo atau isi -Repo owner/nama-repo.`n$($_.Exception.Message)"
    }
}
else {
    try {
        $repoInfo = (Invoke-Gh -Arguments @("repo", "view", $Repo, "--json", "owner,name")) | ConvertFrom-Json
    }
    catch {
        throw "Repo '$Repo' tidak dapat diakses oleh akun gh saat ini.`n$($_.Exception.Message)"
    }
}

$owner = $repoInfo.owner.login
$repoName = $repoInfo.name
$Repo = "$owner/$repoName"
Write-Ok "Repo: $Repo"

# Tanggal mulai: default 2026-12-01 (dapat dioverride via -StartDate).
if ([string]::IsNullOrWhiteSpace($StartDate)) {
    $today = Get-Date
    $delta = ((1 - [int]($today.DayOfWeek)) + 7) % 7
    $start = $today.Date.AddDays($delta)
    $StartDate = $start.ToString("yyyy-MM-dd")
}
else {
    try {
        $start = [datetime]::ParseExact($StartDate, "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
    }
    catch {
        throw "Format -StartDate harus yyyy-MM-dd, mis. 2026-12-01."
    }
}
Write-Ok "Tanggal mulai: $StartDate"

# ---------------------------------------------------------------------------
# 1. Baca backlog
# ---------------------------------------------------------------------------

Write-Step "Membaca backlog"

$raw = Get-Content -LiteralPath $backlogPath -Raw -Encoding UTF8
$pattern = '<!--\s*issue\s*(\{.*?\})\s*-->\s*(.*?)<!--\s*/issue\s*-->'
$regexOptions = [System.Text.RegularExpressions.RegexOptions]::Singleline
$issueMatches = [regex]::Matches($raw, $pattern, $regexOptions)

if ($issueMatches.Count -eq 0) {
    throw "Tidak ada blok issue yang ditemukan di $backlogPath."
}

$issues = @()
$seenKeys = @{}

foreach ($match in $issueMatches) {
    $json = $match.Groups[1].Value
    try {
        $meta = $json | ConvertFrom-Json
    }
    catch {
        throw "Metadata JSON tidak valid: $json"
    }

    if ([string]::IsNullOrWhiteSpace($meta.key)) {
        throw "Issue tanpa key: $json"
    }
    if ($seenKeys.ContainsKey($meta.key)) {
        throw "Key duplikat: $($meta.key)"
    }
    $seenKeys[$meta.key] = $true

    $body = $match.Groups[2].Value.Trim()
    $body = [regex]::Replace($body, '^###[^\r\n]*\r?\n+', '')

    $issues += [pscustomobject]@{
        Key       = $meta.key
        Title     = "[$($meta.key)] $($meta.title)"
        Milestone = $meta.milestone
        Labels    = @($meta.labels)
        Estimate  = [int]$meta.estimate
        Body      = $body.Trim()
    }
}

$totalPoints = ($issues | Measure-Object -Property Estimate -Sum).Sum
Write-Ok "$($issues.Count) issue, $totalPoints poin"

# ---------------------------------------------------------------------------
# 2. Label
# ---------------------------------------------------------------------------

Write-Step "Membuat/memperbarui label"

$labelDefs = @(
    [pscustomobject]@{ Name = "type/research"; Color = "5319E7"; Description = "Riset, wawancara, observasi" },
    [pscustomobject]@{ Name = "type/design";   Color = "D876E3"; Description = "Wireframe, UI, usability" },
    [pscustomobject]@{ Name = "type/feature";  Color = "1D76DB"; Description = "Fitur produk" },
    [pscustomobject]@{ Name = "type/tech";     Color = "0E8A16"; Description = "Pekerjaan teknis/fondasi" },
    [pscustomobject]@{ Name = "type/bug";      Color = "B60205"; Description = "Defect" },
    [pscustomobject]@{ Name = "type/test";     Color = "FBCA04"; Description = "Test, QA, UAT" },
    [pscustomobject]@{ Name = "type/docs";     Color = "0075CA"; Description = "Dokumentasi" },
    [pscustomobject]@{ Name = "type/ops";      Color = "006B75"; Description = "Deployment, monitoring, operasional" },
    [pscustomobject]@{ Name = "area/discovery"; Color = "7057FF"; Description = "Discovery" },
    [pscustomobject]@{ Name = "area/design";   Color = "E99695"; Description = "Desain" },
    [pscustomobject]@{ Name = "area/cust";     Color = "1D76DB"; Description = "Role Cust" },
    [pscustomobject]@{ Name = "area/tenant";   Color = "0E8A16"; Description = "Role Tenant" },
    [pscustomobject]@{ Name = "area/payment";  Color = "B60205"; Description = "QRIS dan pembayaran" },
    [pscustomobject]@{ Name = "area/platform"; Color = "6E7781"; Description = "Fondasi, auth, database, CI" },
    [pscustomobject]@{ Name = "area/qa";       Color = "FBCA04"; Description = "Testing" },
    [pscustomobject]@{ Name = "area/ops";      Color = "006B75"; Description = "Deployment dan operasi" },
    [pscustomobject]@{ Name = "priority/p0";   Color = "B60205"; Description = "Blocker, hentikan sprint" },
    [pscustomobject]@{ Name = "priority/p1";   Color = "D93F0B"; Description = "Wajib untuk milestone" },
    [pscustomobject]@{ Name = "priority/p2";   Color = "FBCA04"; Description = "Sebaiknya" },
    [pscustomobject]@{ Name = "priority/p3";   Color = "C2E0C6"; Description = "Nanti" },
    [pscustomobject]@{ Name = "status/blocked"; Color = "000000"; Description = "Terblokir; sertakan alasan di komentar" }
)

$labelMap = @{}
foreach ($label in $labelDefs) { $labelMap[$label.Name] = $label }

foreach ($issue in $issues) {
    foreach ($labelName in $issue.Labels) {
        if ([string]::IsNullOrWhiteSpace($labelName)) { continue }
        if (-not $labelMap.ContainsKey($labelName)) {
            $labelMap[$labelName] = [pscustomobject]@{
                Name        = $labelName
                Color       = "6E7781"
                Description = "Label tambahan dari backlog"
            }
        }
    }
}

$labelCreated = 0
foreach ($label in $labelMap.Values) {
    $ghArgs = @(
        "label", "create", $label.Name,
        "--repo", $Repo,
        "--color", $label.Color,
        "--description", $label.Description,
        "--force"
    )
    [void](Invoke-Gh -Arguments $ghArgs -AllowEmpty)
    $labelCreated++
}
Write-Ok "$labelCreated label siap"

# ---------------------------------------------------------------------------
# 3. Milestone
# ---------------------------------------------------------------------------

Write-Step "Membuat milestone"

$milestoneDefs = @(
    [pscustomobject]@{ Title = "M0 — Discovery & PRD"; Week = 2; Description = "Wawancara, observasi, sintesis, PRD v1 dan persetujuan (13 Des)." },
    [pscustomobject]@{ Title = "M1 — Design & Technical Spec"; Week = 3; Description = "IA/flow, wireframe, UI, usability test, ERD, OpenAPI, ADR, QRIS sandbox (20 Des)." },
    [pscustomobject]@{ Title = "M2 — Foundation, Katalog & Keranjang"; Week = 4; Description = "Repo, CI, DB, auth, design system; tenant list, detail, keranjang, staging (27 Des)." },
    [pscustomobject]@{ Title = "M3 — Checkout, QRIS & Invoice"; Week = 5; Description = "Order, QRIS sandbox, webhook, invoice, unit test domain (3 Jan)." },
    [pscustomobject]@{ Title = "M4 — Riwayat & Dashboard Tenant"; Week = 6; Description = "Riwayat Cust, antrian Tenant, produk, integration test (10 Jan)." },
    [pscustomobject]@{ Title = "M5 — Laporan, Hardening & Staging"; Week = 7; Description = "Omzet, pencairan, E2E, security, performance, release candidate (17 Jan)." },
    [pscustomobject]@{ Title = "M6 — UAT, Deployment & Pilot"; Week = 9; Description = "UAT, production, pelatihan, pilot, retro dan handover (31 Jan)." }
)

$existingMilestones = @{}
try {
    $msRaw = Invoke-Gh -Arguments @("api", "repos/$Repo/milestones?state=all&per_page=100")
    if (-not [string]::IsNullOrWhiteSpace($msRaw)) {
        # Windows PowerShell 5.1 mengembalikan array JSON sebagai satu objek.
        # Pisahkan lewat variabel agar isinya benar-benar dienumerasi.
        $msData = $msRaw | ConvertFrom-Json
        $msList = @($msData)
        foreach ($ms in $msList) {
            if ($null -ne $ms -and -not [string]::IsNullOrWhiteSpace($ms.title)) {
                $existingMilestones[$ms.title] = $ms.number
            }
        }
    }
}
catch {
    Write-Warn "Tidak dapat membaca milestone yang ada: $($_.Exception.Message)"
}

# W1 dimulai Selasa 1 Des, jadi minggu pertama hanya 6 hari.
# Milestone jatuh pada hari Minggu di akhir minggu yang direncanakan.
$firstSunday = $start.AddDays((7 - [int]$start.DayOfWeek) % 7)

$milestoneCreated = 0
foreach ($ms in $milestoneDefs) {
    if ($existingMilestones.ContainsKey($ms.Title)) {
        continue
    }

    $dueDate = $firstSunday.AddDays(($ms.Week - 1) * 7).ToString("yyyy-MM-ddT23:59:59Z")
    $ghArgs = @(
        "api", "repos/$Repo/milestones",
        "--method", "POST",
        "-f", "title=$($ms.Title)",
        "-f", "description=$($ms.Description)",
        "-f", "due_on=$dueDate"
    )
    [void](Invoke-Gh -Arguments $ghArgs -AllowEmpty)
    $milestoneCreated++
}
Write-Ok "$milestoneCreated milestone baru dibuat ($($milestoneDefs.Count - $milestoneCreated) sudah ada)"

# ---------------------------------------------------------------------------
# 4. Project (opsional)
# ---------------------------------------------------------------------------

if ($CreateProject) {
    Write-Step "Membuat GitHub Project"

    try {
        $projectRaw = Invoke-Gh -Arguments @(
            "project", "create",
            "--owner", $owner,
            "--title", $ProjectTitle,
            "--format", "json"
        )
        $project = $projectRaw | ConvertFrom-Json
        $ProjectNumber = [int]$project.number
        Write-Ok "Project #$ProjectNumber dibuat"

        [void](Invoke-Gh -Arguments @(
            "project", "link", "$ProjectNumber",
            "--owner", $owner,
            "--repo", $Repo
        ) -AllowEmpty)
        Write-Ok "Project ter-link ke $Repo"
    }
    catch {
        Write-Warn "Gagal membuat project: $($_.Exception.Message)"
        Write-Warn "Jalankan 'gh auth refresh -s project' lalu ulangi, atau buat project manual."
        $ProjectNumber = 0
    }
}

if ($ProjectNumber -gt 0) {
    Write-Step "Menyiapkan field project #$ProjectNumber"

    $existingFieldNames = @()
    try {
        $fieldRaw = Invoke-Gh -Arguments @(
            "project", "field-list", "$ProjectNumber",
            "--owner", $owner,
            "--format", "json"
        )
        $fieldObj = $fieldRaw | ConvertFrom-Json
        if ($fieldObj.PSObject.Properties.Name -contains "fields") {
            $existingFieldNames = @($fieldObj.fields | ForEach-Object { $_.name })
        }
        else {
            $existingFieldNames = @($fieldObj | ForEach-Object { $_.name })
        }
    }
    catch {
        Write-Warn "Tidak dapat membaca field project: $($_.Exception.Message)"
    }

    $fieldDefs = @(
        [pscustomobject]@{ Name = "Priority";    Type = "SINGLE_SELECT"; Options = "P0 - Critical,P1 - High,P2 - Medium,P3 - Low" },
        [pscustomobject]@{ Name = "Area";        Type = "SINGLE_SELECT"; Options = "Discovery,Design,Cust,Tenant,Payment,Platform,QA,Ops" },
        [pscustomobject]@{ Name = "Size";        Type = "SINGLE_SELECT"; Options = "1 - XS,2 - S,3 - M,5 - L,8 - XL" },
        [pscustomobject]@{ Name = "Sprint";      Type = "SINGLE_SELECT"; Options = "Sprint 0,Sprint 1,Sprint 2,Sprint 3,Sprint 4" },
        [pscustomobject]@{ Name = "Start date";  Type = "DATE";          Options = $null },
        [pscustomobject]@{ Name = "Target date"; Type = "DATE";          Options = $null }
    )

    $fieldCreated = 0
    foreach ($field in $fieldDefs) {
        if ($existingFieldNames -contains $field.Name) {
            continue
        }

        $ghArgs = @(
            "project", "field-create", "$ProjectNumber",
            "--owner", $owner,
            "--name", $field.Name,
            "--data-type", $field.Type
        )
        if (-not [string]::IsNullOrWhiteSpace($field.Options)) {
            $ghArgs += @("--single-select-options", $field.Options)
        }

        try {
            [void](Invoke-Gh -Arguments $ghArgs -AllowEmpty)
            $fieldCreated++
        }
        catch {
            Write-Warn "Field '$($field.Name)' gagal dibuat: $($_.Exception.Message)"
        }
    }
    Write-Ok "$fieldCreated field baru dibuat"

    Write-Warn "Status default (Todo/In Progress/Done) perlu diubah manual menjadi Backlog/Ready/In Progress/In Review/QA/Done."
}

# ---------------------------------------------------------------------------
# 5. Issue
# ---------------------------------------------------------------------------

Write-Step "Membuat issue"

$existingIssues = @{}
try {
    $issueListRaw = Invoke-Gh -Arguments @(
        "issue", "list",
        "--repo", $Repo,
        "--state", "all",
        "--limit", "1000",
        "--json", "number,title,url"
    )
    if (-not [string]::IsNullOrWhiteSpace($issueListRaw)) {
        $issueData = $issueListRaw | ConvertFrom-Json
        $issueList = @($issueData)
        foreach ($item in $issueList) {
            if ($null -ne $item -and -not [string]::IsNullOrWhiteSpace($item.title)) {
                $existingIssues[$item.title] = $item
            }
        }
    }
}
catch {
    Write-Warn "Tidak dapat membaca issue yang ada: $($_.Exception.Message)"
}

$created = 0
$skipped = 0
$failed = 0
$issueUrls = @()
$tempFile = Join-Path ([System.IO.Path]::GetTempPath()) ("ftfood-issue-" + [guid]::NewGuid().ToString("N") + ".md")

try {
    foreach ($issue in $issues) {
        try {
            if ($existingIssues.ContainsKey($issue.Title)) {
                $skipped++
                $issueUrls += $existingIssues[$issue.Title].url
                Write-Host "    --  $($issue.Title) (sudah ada)"
                continue
            }

            $utf8 = New-Object System.Text.UTF8Encoding($false)
            [System.IO.File]::WriteAllText($tempFile, $issue.Body, $utf8)

            $ghArgs = @(
                "issue", "create",
                "--repo", $Repo,
                "--title", $issue.Title,
                "--body-file", $tempFile,
                "--milestone", $issue.Milestone
            )
            if ($issue.Labels.Count -gt 0) {
                $ghArgs += @("--label", ($issue.Labels -join ","))
            }

            $url = Invoke-Gh -Arguments $ghArgs
            $url = ($url -split "`r?`n" | Where-Object { $_ -match '^https?://' } | Select-Object -Last 1)
            if ([string]::IsNullOrWhiteSpace($url)) {
                throw "URL issue tidak ditemukan pada output gh."
            }

            $created++
            $issueUrls += $url.Trim()
            Write-Host "    ++  $($issue.Title)" -ForegroundColor Green
        }
        catch {
            $failed++
            Write-Warn "Gagal membuat '$($issue.Title)': $($_.Exception.Message)"
        }
    }
}
finally {
    if (Test-Path -LiteralPath $tempFile) {
        Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue
    }
}

Write-Ok "$created dibuat, $skipped dilewati, $failed gagal"

# ---------------------------------------------------------------------------
# 6. Masukkan issue ke project
# ---------------------------------------------------------------------------

if ($ProjectNumber -gt 0 -and -not $SkipProjectItems) {
    Write-Step "Menambahkan issue ke project #$ProjectNumber"

    $added = 0
    $addFailed = 0
    foreach ($url in $issueUrls) {
        try {
            [void](Invoke-Gh -Arguments @(
                "project", "item-add", "$ProjectNumber",
                "--owner", $owner,
                "--url", $url
            ) -AllowEmpty)
            $added++
        }
        catch {
            $addFailed++
            Write-Warn "Gagal menambahkan $url ke project: $($_.Exception.Message)"
        }
    }
    Write-Ok "$added issue ditambahkan ke project, $addFailed gagal"
}

# ---------------------------------------------------------------------------
# 7. Ringkasan
# ---------------------------------------------------------------------------

Write-Step "Selesai"

Write-Host "    Repo       : $Repo"
Write-Host "    Issue      : $($issues.Count) total, $created baru, $skipped dilewati, $failed gagal"
Write-Host "    Milestone  : $($milestoneDefs.Count) (due date dihitung dari $StartDate)"
Write-Host "    Label      : $($labelMap.Count)"
if ($ProjectNumber -gt 0) {
    Write-Host "    Project    : #$ProjectNumber"
}
Write-Host ""
Write-Host "Langkah manual berikutnya:" -ForegroundColor Yellow
Write-Host "  1. Ubah opsi Status menjadi Backlog/Ready/In Progress/In Review/QA/Done."
Write-Host "  2. Buat 7 view sesuai docs/04-github-projects-setup.md section 5."
Write-Host "  3. Aktifkan automation; gunakan Refs (bukan Closes) di PR fitur."
Write-Host "  4. Isi field Priority/Area/Size/Sprint lewat bulk edit di Table view."
Write-Host ""

if ($failed -gt 0) {
    exit 1
}

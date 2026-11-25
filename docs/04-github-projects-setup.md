# 04 — Panduan Membuat GitHub Projects

Panduan ini menjelaskan cara membuat papan **FT Food — Development**. Ada dua cara: memakai skrip (label, milestone, issue, dan project) atau membuat sendiri lewat tampilan GitHub. Tampilan papan (views) tetap dibuat manual karena GitHub belum menyediakan API yang stabil untuk itu.

## 0. Yang perlu disiapkan

- Repository GitHub sudah ada dan sudah di-push.
- `gh` CLI versi 2.40 atau lebih baru. Cek dengan `gh --version`.
- Sudah login: `gh auth status`.
- Izin `project` untuk membuat dan mengubah project:
  ```powershell
  gh auth refresh -s project
  ```
  Izin `read:project` saja tidak cukup.
- PowerShell 7 disarankan (`pwsh`). Skrip juga dapat berjalan di Windows PowerShell 5.1.

## 1. Membuat project dan menghubungkannya ke repository

Lewat tampilan GitHub:

1. Buka profil atau organisasi → **Projects** → **New project**.
2. Pilih **Board** atau **Table**, lalu beri nama `FT Food — Development`.
3. Pilih **Private** jika repository juga privat.
4. Buka **⋯** → **Settings** → **Manage access** jika perlu mengatur akses.
5. Buka **⋯** → **Settings** → **Linked repositories**, lalu pilih repository FT Food.

Lewat CLI:

```powershell
gh project create --owner "@me" --title "FT Food — Development"
gh project link <NOMOR_PROJECT> --owner "@me" --repo <owner>/<repo>
```

> Nomor project berbeda dari nomor issue. Nomor terlihat di URL project, misalnya `.../projects/3` berarti nomor `3`.

## 2. Kolom tambahan (field)

Buat di **Settings → Custom fields**. Urutan pilihan menentukan urutan saat diurutkan.

| Nama kolom | Tipe | Pilihan |
| :--- | :--- | :--- |
| **Status** | Single select (bawaan) | `Backlog`, `Ready`, `In Progress`, `In Review`, `QA`, `Done` |
| **Priority** | Single select | `P0 - Critical`, `P1 - High`, `P2 - Medium`, `P3 - Low` |
| **Area** | Single select | `Discovery`, `Design`, `Cust`, `Tenant`, `Payment`, `Platform`, `QA`, `Ops` |
| **Size** | Single select | `1 - XS`, `2 - S`, `3 - M`, `5 - L`, `8 - XL` |
| **Sprint** | Single select | `Sprint 0` sampai `Sprint 4` |
| **Start date** | Date | Diisi saat item masuk sprint |
| **Target date** | Date | Samakan dengan tanggal milestone |

**Warna Status yang disarankan:** Backlog abu-abu, Ready biru, In Progress kuning, In Review ungu, QA oranye, Done hijau.

**Mengapa Sprint berupa pilihan, bukan Iteration?** Iteration lebih fleksibel, tetapi pembuatannya lewat tampilan atau GraphQL dan tidak selalu tersedia di `gh`. Pilihan biasa cukup untuk menyaring papan.

## 3. Label

| Label | Warna | Keterangan |
| :--- | :--- | :--- |
| `type/research` | `5319E7` | Riset, wawancara, observasi |
| `type/design` | `D876E3` | Wireframe, desain, uji kegunaan |
| `type/feature` | `1D76DB` | Fitur produk |
| `type/tech` | `0E8A16` | Pekerjaan teknis dan fondasi |
| `type/bug` | `B60205` | Kesalahan atau cacat |
| `type/test` | `FBCA04` | Pengujian dan UAT |
| `type/docs` | `0075CA` | Dokumentasi |
| `type/ops` | `006B75` | Peluncuran, pemantauan, operasional |
| `area/discovery` | `7057FF` | Riset awal |
| `area/design` | `E99695` | Desain |
| `area/cust` | `1D76DB` | Peran Cust |
| `area/tenant` | `0E8A16` | Peran Tenant |
| `area/payment` | `B60205` | QRIS dan pembayaran |
| `area/platform` | `6E7781` | Fondasi, login, database, CI |
| `area/qa` | `FBCA04` | Pengujian |
| `area/ops` | `006B75` | Peluncuran dan operasional |
| `priority/p0` | `B60205` | Penghambat, hentikan sprint |
| `priority/p1` | `D93F0B` | Wajib untuk milestone |
| `priority/p2` | `FBCA04` | Sebaiknya dikerjakan |
| `priority/p3` | `C2E0C6` | Dikerjakan nanti |
| `status/blocked` | `000000` | Terhambat; wajib ada alasan di komentar |

Contoh membuat satu label:

```powershell
gh label create "type/bug" --color B60205 --description "Kesalahan atau cacat" --repo <owner>/<repo>
```

Skrip `setup-github.ps1` membuat semua label di atas.

## 4. Milestone

| Milestone | Minggu | Tanggal | Fokus |
| :--- | :---: | :--- | :--- |
| `M0 — Discovery & PRD` | 2 | Min 13 Des 2026 | Wawancara, PRD, persetujuan |
| `M1 — Design & Technical Spec` | 3 | Min 20 Des 2026 | Desain, ERD, API, ADR, QRIS sandbox |
| `M2 — Foundation, Katalog & Keranjang` | 4 | Min 27 Des 2026 | Fondasi, login, katalog, keranjang, staging |
| `M3 — Checkout, QRIS & Invoice` | 5 | Min 3 Jan 2027 | Checkout, pembayaran sandbox, invoice |
| `M4 — Riwayat & Dashboard Tenant` | 6 | Min 10 Jan 2027 | Riwayat, antrean, produk tenant |
| `M5 — Laporan, Hardening & Staging` | 7 | Min 17 Jan 2027 | Laporan, pencairan, E2E, keamanan |
| `M6 — UAT, Deployment & Pilot` | 9 | Min 31 Jan 2027 | UAT, produksi, pilot, serah terima |

Skrip menghitung tanggal dari `-StartDate` (default `2026-12-01`). Jika jadwal kampus berubah, isi `-StartDate` dengan tanggal baru.

## 5. Tampilan papan (views)

Buat lewat **+ New view** di project. Langkah ini manual dan memerlukan sekitar 5 menit.

| Nama tampilan | Jenis | Filter | Pengelompokan / urutan | Kegunaan |
| :--- | :--- | :--- | :--- | :--- |
| **🗺 Roadmap** | Roadmap | `is:open` | Kelompok: Milestone; tanggal: Target date | Melihat urutan tahap |
| **🏃 Sprint Board** | Board | `sprint:"Sprint 3"` (ganti setiap sprint) | Kolom: Status; urut Priority | Pekerjaan harian sprint |
| **📋 Backlog** | Table | `status:Backlog,Ready` | Kelompok: Area; urut Priority lalu Size | Perencanaan |
| **🛒 Cust Flow** | Board | `area:Cust,Payment` | Kolom: Status; urut Milestone | Memantau alur Cust |
| **🏪 Tenant Ops** | Table | `area:Tenant` | Kelompok: Status; urut Priority | Pekerjaan Tenant |
| **🐞 Bugs & Blocked** | Table | `label:type/bug,status/blocked` | Urut Priority | Menangani bug dan hambatan |
| **🚦 QA & Release** | Table | `area:QA,Ops` | Kelompok: Milestone; urut Status | Persiapan rilis |

**Tips filter:**

- Beberapa nilai dipisahkan koma berarti **atau**, misalnya `area:Cust,Payment`.
- Nilai yang mengandung spasi harus diberi tanda kutip: `status:"In Progress"`.
- Untuk sprint aktif, ubah filter di awal sprint. Bisa juga membuat satu tampilan untuk setiap sprint.

## 6. Otomatisasi

Buka **Project → ⋯ → Workflows**, lalu aktifkan yang sesuai:

| Workflow | Efek yang diinginkan |
| :--- | :--- |
| **Auto-add to project** | Issue atau PR baru otomatis masuk project |
| **Item closed** | Status menjadi `Done` saat issue ditutup |
| **Pull request linked** | Status menjadi `In Review` jika tersedia |
| **Pull request merged** | Status menjadi `QA`, bukan langsung `Done` |
| **Review approved / changes requested** | Opsional, untuk menandai review |

> **Penting:** untuk issue fitur, gunakan `Refs #12` di PR, bukan `Closes #12`. Setelah PR digabung dan QA lulus, tutup issue secara manual. Dengan begitu, issue tidak berstatus `Done` sebelum diuji. `Closes` boleh dipakai untuk perubahan dokumentasi atau pekerjaan kecil yang tidak memerlukan QA terpisah.

Jika workflow “PR merged → QA” tidak tersedia, ubah status secara manual setelah deploy staging. Jangan biarkan issue menumpuk di `In Review`.

## 7. Aturan status dan batas pekerjaan

| Perpindahan | Syarat |
| :--- | :--- |
| `Backlog → Ready` | Syarat siap sudah terpenuhi, sudah diperkirakan, dan masuk sprint |
| `Ready → In Progress` | Branch dibuat dan penanggung jawab jelas |
| `In Progress → In Review` | PR dibuka, CI lulus, deskripsi PR lengkap |
| `In Review → QA` | PR digabung dan sudah dijalankan di staging |
| `QA → Done` | Semua kriteria penerimaan terbukti dan tidak ada bug P0/P1 |
| `Any → Blocked` | Tambahkan label `status/blocked`, tulis alasan, penanggung jawab, dan tanggal peninjauan |

**Batas pekerjaan:** maksimal 2 item `In Progress` per orang dan 5 item `In Review` untuk seluruh tim. Jika batas tercapai, selesaikan review dulu.

## 8. Menjalankan skrip

Dari folder utama repository:

```powershell
# 1) Tambahkan izin project (sekali saja)
gh auth refresh -s project

# 2) Buat project, field, label, milestone, issue, lalu masukkan issue ke project
pwsh -File ./scripts/setup-github.ps1 -CreateProject

# Contoh dengan repository dan tanggal yang jelas
pwsh -File ./scripts/setup-github.ps1 `
  -Repo ibrahim119920/ft-food `
  -StartDate 2026-12-01 `
  -CreateProject
```

| Parameter | Default | Fungsi |
| :--- | :--- | :--- |
| `-Repo` | repository di folder aktif | `owner/nama-repo` |
| `-ProjectTitle` | `FT Food — Development` | Nama project baru |
| `-StartDate` | `2026-12-01` | Tanggal mulai; tanggal milestone dihitung untuk W2, W3, W4, W5, W6, W7, dan W9 |
| `-CreateProject` | nonaktif | Membuat project baru dan menghubungkannya ke repository |
| `-ProjectNumber` | `0` | Memakai project yang sudah ada, misalnya `-ProjectNumber 3` |
| `-SkipProjectItems` | nonaktif | Membuat issue tanpa memasukkannya ke project |

> Jika `pwsh` belum terpasang, gunakan `powershell -File ./scripts/setup-github.ps1 -CreateProject`. Skrip kompatibel dengan Windows PowerShell 5.1.

**Yang dilakukan skrip:**

1. Memeriksa repository dan login `gh`.
2. Membuat atau memperbarui semua label.
3. Membuat milestone beserta tanggalnya.
4. Membuat project dan kolom tambahan jika `-CreateProject` dipakai.
5. Membaca data dari `docs/03-backlog.md`, lalu membuat 35 issue dengan label dan milestone.
6. Memasukkan issue ke project, kecuali `-SkipProjectItems` dipakai.

**Mengisi field otomatis (disarankan):**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/populate-project.ps1 -ProjectNumber 4
```

Skrip ini membaca `docs/03-backlog.md` dan pembagian minggu di `docs/05-execution-plan-2-months.md` §5, lalu mengisi `Priority`, `Area`, `Size`, `Sprint`, `Start date`, dan `Target date` untuk semua issue. Skrip aman dijalankan ulang.

**Yang masih manual:**

- Membuat tampilan papan (§5).
- Mengubah pilihan **Status** bawaan (`Todo/In Progress/Done`) menjadi `Backlog/Ready/In Progress/In Review/QA/Done`.
- Mengaktifkan otomatisasi (§6).

**Menjalankan ulang:** skrip melewati issue dengan judul yang sama dan melewati label, milestone, atau field yang sudah ada. Skrip aman dijalankan kembali setelah gagal di tengah jalan. Skrip tidak memperbarui isi issue lama; ubah issue di GitHub setelah impor.

## 9. Mengisi kolom setelah impor

**Cara otomatis (disarankan):**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./scripts/populate-project.ps1 -ProjectNumber 4
```

Skrip mengisi semua kolom untuk 35 issue dan menampilkan jumlah item yang berhasil diperbarui.

**Cara manual:**

1. Buka tampilan **📋 Backlog** (Table).
2. Tampilkan kolom `Priority`, `Area`, `Size`, dan `Sprint`.
3. Saring per milestone, misalnya `milestone:"M0 — Discovery & PRD"`.
4. Pilih semua baris, lalu ubah kolom sekaligus lewat menu **Edit**.
5. Cocokkan `Size` dengan estimasi di `docs/03-backlog.md`:
   - 1 → `1 - XS`
   - 2 → `2 - S`
   - 3 → `3 - M`
   - 5 → `5 - L`
   - 6 dan 7 → `8 - XL` (dibulatkan)
   - 8 → `8 - XL`
6. Isi `Sprint` (`Sprint 0` sampai `Sprint 4`) sesuai pembagian issue per minggu di `docs/05-execution-plan-2-months.md` §5.
7. Isi `Start date` dengan hari Senin minggu tersebut dan `Target date` dengan hari Minggu di akhir minggu.

## 10. Daftar periksa

- [ ] Project sudah terhubung ke repository.
- [ ] 7 milestone muncul dengan tanggal yang benar.
- [ ] 21 label proyek dibuat (8 type, 8 area, 4 priority, 1 status), di luar label bawaan GitHub.
- [ ] 35 issue dibuat dengan judul `[KEY] …` dan milestone yang tepat.
- [ ] Semua issue masuk project.
- [ ] Priority, Area, Size, Sprint, Start date, dan Target date terisi untuk semua issue.
- [ ] Status memiliki 6 pilihan.
- [ ] 7 tampilan dibuat dengan filter yang benar.
- [ ] Otomatisasi aktif dan tim memahami `Closes` vs `Refs`.
- [ ] Issue `DISC-01` sudah ditugaskan dan berstatus `Ready` untuk memulai Sprint 0.

## 11. Jika ada masalah

| Gejala | Penyebab dan solusi |
| :--- | :--- |
| `missing required scopes [project]` | Jalankan `gh auth refresh -s project`, lalu ulangi. |
| `unknown owner type` | Gunakan `--owner "@me"` atau login pemilik yang benar. |
| `project not found` | Nomor project salah. Lihat nomor di URL project. |
| `label already exists` | Skrip memakai `--force`. Jika manual, tambahkan `--force` atau edit label. |
| `milestone already exists` | Dilewati. Skrip tidak membuat milestone ganda. |
| Issue dibuat tetapi tidak masuk project | Izin project belum aktif atau `-SkipProjectItems` dipakai. Jalankan ulang dengan `-ProjectNumber`. |
| Isi issue berantakan atau emoji hilang | Pastikan file backlog dibaca sebagai UTF-8. Gunakan PowerShell 7. |
| `gh project item-add` lambat | Normal untuk 35 item karena satu panggilan per issue. |
| Judul issue dobel | Periksa judul yang sama persis. Skrip melewati judul yang sudah ada. |
| Status masih Todo/In Progress/Done | Ubah pilihan Status di pengaturan project. API tidak selalu dapat mengubahnya. |

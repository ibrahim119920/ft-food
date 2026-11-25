# FT Food — Rencana Proyek dan GitHub Projects

Dokumen ini berisi rencana pembuatan aplikasi kantin **FT Food**, mulai dari wawancara sampai peluncuran. Rencana disusun agar dapat langsung dijalankan sebagai GitHub Projects.

**Ringkasan:**

- 2 peran: **Cust** (pembeli) dan **Tenant** (penjual)
- 35 pekerjaan (issue)
- 7 target antara (milestone)
- 5 sprint selama 9 minggu
- Periode: **1 Desember 2026 – 31 Januari 2027**

## Gambaran aplikasi

| Peran | Alur utama |
| :--- | :--- |
| **Cust** | Melihat daftar tenant → membuka detail tenant → memasukkan menu ke keranjang → checkout → membayar dengan QRIS → menerima invoice → melihat riwayat pesanan |
| **Tenant** | Melihat antrean pesanan → mengelola produk → melihat laporan omzet dan pencairan |

## Daftar dokumen

| Dokumen | Isi |
| :--- | :--- |
| [`docs/01-discovery-plan.md`](docs/01-discovery-plan.md) | Panduan wawancara, observasi, dan cara menyusun hasil riset |
| [`docs/02-roadmap.md`](docs/02-roadmap.md) | Aturan kerja tim, peran, jadwal sprint, dan daftar risiko |
| [`docs/03-backlog.md`](docs/03-backlog.md) | 35 pekerjaan lengkap dengan target, batas waktu, dan kriteria selesai |
| [`docs/04-github-projects-setup.md`](docs/04-github-projects-setup.md) | Cara membuat papan GitHub, kolom, label, dan otomatisasi |
| [`docs/05-execution-plan-2-months.md`](docs/05-execution-plan-2-months.md) | **Jadwal rinci 2 bulan**: rencana harian, target antara, dan batas pengurangan fitur |
| [`docs/prd-template.md`](docs/prd-template.md) | Kerangka dokumen kebutuhan produk (PRD) |
| [`research/README.md`](research/README.md) | Aturan penyimpanan data wawancara dan menjaga privasi responden |
| [`scripts/setup-github.ps1`](scripts/setup-github.ps1) | Skrip untuk membuat label, milestone, issue, dan project |
| [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE) | Format standar untuk issue riset, fitur, dan bug |
| [`.github/pull_request_template.md`](.github/pull_request_template.md) | Daftar periksa sebelum mengirim PR |

## Jadwal singkat

| Sprint | Tanggal | Fokus | Poin |
| :--- | :--- | :--- | ---: |
| Sprint 0 | 1–6 Desember 2026 | Rapat pembuka, menyiapkan wawancara, mulai observasi | 5 |
| Sprint 1 | 7–20 Desember 2026 | Menyelesaikan wawancara, PRD, desain, dan fondasi teknis | 61 |
| Sprint 2 | 21 Desember 2026–3 Januari 2027 | Login, katalog, keranjang, checkout, QRIS | 58 |
| Sprint 3 | 4–17 Januari 2027 | Riwayat, fitur tenant, laporan, pengujian, staging | 50 |
| Sprint 4 | 18–31 Januari 2027 | UAT, peluncuran, pelatihan, dan pilot | 23 |
| | | **Total** | **197** |

> Rencana ini membutuhkan sekitar **20 jam per orang per minggu** untuk 5 orang. Rincian harian dan cara mengurangi ruang lingkup ada di [`docs/05-execution-plan-2-months.md`](docs/05-execution-plan-2-months.md).

## Cara memulai

1. **Baca rencana wawancara** di `docs/01-discovery-plan.md`. Jangan mulai membuat fitur sebelum PRD disetujui.
2. **Siapkan repository GitHub** jika belum ada:
   ```powershell
   git init
   git add .
   git commit -m "chore: initial project plan"
   gh repo create ft-food --private --source=. --push
   ```
3. **Buat GitHub Project** mengikuti `docs/04-github-projects-setup.md`.
4. **Jalankan skrip penyiapan**:
   ```powershell
   gh auth refresh -s project
   pwsh -File scripts/setup-github.ps1 -CreateProject -StartDate 2026-12-01
   ```
5. **Mulai Sprint 0 pada 1 Desember 2026**: kerjakan DISC-01 dan DISC-02, lanjutkan wawancara pada DISC-03, lalu tutup target M0 pada 13 Desember.

## Keputusan yang perlu disepakati

Keputusan berikut masih berupa asumsi. Tim perlu memastikannya saat wawancara:

- Satu pesanan hanya berasal dari **satu tenant**.
- Pembeli perlu **membuat akun** agar riwayat pesanan tersimpan.
- Tenant mengelola produknya sendiri karena tidak ada peran admin.
- Status pesanan: `MENUNGGU_PEMBAYARAN → DIBAYAR → DIPROSES → SELESAI`, ditambah `KEDALUWARSA` dan `GAGAL`.
- Pencairan dana dicatat secara manual di buku besar internal, belum otomatis.
- Biaya QRIS tidak ditambahkan sebagai biaya baru ke pembeli, kecuali disepakati lain.
- Satu akun hanya memiliki satu peran pada versi pertama.

Penjelasan dan cara memvalidasinya ada di [`docs/01-discovery-plan.md` §11](docs/01-discovery-plan.md#11-pertanyaan-yang-wajib-diputuskan).

## Di luar ruang lingkup

Fitur berikut tidak dikerjakan pada versi pertama, kecuali disetujui melalui perubahan resmi:

- Keranjang dan checkout lintas tenant
- Pengantaran, reservasi meja, dan pesan-antar
- Promo, voucher, poin, dan ulasan
- Chat, notifikasi push, dan WhatsApp gateway
- Refund otomatis dan pembatalan sepihak
- Akun dengan dua peran dan halaman admin
- Aplikasi mobile native
- Pencairan otomatis melalui API disbursement
- Dasbor analitik lanjutan dan mode offline

## Teknologi awal

Pilihan akhir ditetapkan pada **DES-05 (ADR)**. Tabel ini hanya menjadi titik awal agar tim tidak tertahan:

| Bagian | Pilihan awal | Alternatif |
| :--- | :--- | :--- |
| Web | Next.js + TypeScript + Tailwind + shadcn/ui | Laravel + Blade/Livewire, Vue/Nuxt |
| Database | PostgreSQL + Prisma | MySQL + Prisma, Supabase |
| Login | Auth.js (email/HP + kata sandi) | Supabase Auth, Laravel Breeze |
| QRIS | Midtrans | Xendit |
| Penyimpanan file | S3-compatible (Supabase Storage/R2) | Penyimpanan lokal saat pengembangan |
| Peluncuran | Vercel + Neon/Supabase | VPS + Docker + Caddy |
| Pengujian | Vitest + Playwright | Jest + Cypress |

## Istilah yang dipakai

| Istilah | Arti dalam dokumen ini |
| :--- | :--- |
| **Issue** | Satu pekerjaan yang dicatat di GitHub |
| **Milestone** | Target antara, misalnya desain selesai atau pembayaran berfungsi |
| **Sprint** | Blok kerja selama 1–2 minggu |
| **PRD** | Dokumen kebutuhan produk |
| **MVP** | Versi pertama yang layak dipakai dan diuji |
| **Staging** | Lingkungan uji sebelum aplikasi dipakai pengguna |
| **UAT** | Pengujian oleh pengguna sebelum rilis |
| **QRIS** | Pembayaran menggunakan kode QR standar Indonesia |
| **Webhook** | Pemberitahuan otomatis dari penyedia pembayaran ke aplikasi |

## Status

- Versi rencana: **1.1**
- Tanggal: 25 November 2026
- Periode pelaksanaan: **1 Desember 2026 – 31 Januari 2027**
- Sudah dibuat: dokumen, daftar pekerjaan, jadwal 2 bulan, template, dan skrip penyiapan
- Belum dibuat di GitHub: repository, GitHub Project, label, milestone, dan issue

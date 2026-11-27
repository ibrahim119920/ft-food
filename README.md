Untuk melihat daftar milestone, sprint, issue, dan lain-lain, buka [GitHub Projects FT Food](https://github.com/users/ibrahim119920/projects/4).

# FT Food

FT Food adalah aplikasi pemesanan kantin untuk **Cust** (pemesan) dan **Tenant** (penjual). Periode pengerjaan **1 Desember 2026 – 31 Januari 2027** (9 minggu, 5 sprint) dengan **35 issue dan 197 poin**.

## Navigasi project

| Bagian | Tautan | Isi |
| :--- | :--- | :--- |
| **Milestones** | [Lihat milestone](https://github.com/users/ibrahim119920/projects/4/views/2) | 7 target antara dan tanggalnya |
| **Sprints** | [Lihat sprint](https://github.com/users/ibrahim119920/projects/4/views/3) | Sprint 0–4 |
| **Checkpoints** | [Lihat checkpoint](https://github.com/users/ibrahim119920/projects/4/views/4) | 9 titik pemeriksaan G0–G8 |
| **Issues** | [Lihat issue](https://github.com/users/ibrahim119920/projects/4/views/1) | 35 pekerjaan |
| **Risks** | [Lihat risiko](https://github.com/users/ibrahim119920/projects/4/views/5) | 10 risiko proyek |

## Checkpoint G0–G8

| Checkpoint | Tanggal | Syarat lulus |
| :---: | :--- | :--- |
| **G0** | 2026-12-13 | PRD awal disetujui; 15 Cust, 5 Tenant, dan 1 pengelola sudah diwawancarai. |
| **G1** | 2026-12-20 | ERD, OpenAPI, ADR, desain final, dan QRIS sandbox siap. |
| **G2** | 2026-12-27 | Login, daftar tenant, detail tenant, dan keranjang berjalan di staging. |
| **G3** | 2027-01-03 | Pembayaran sandbox berhasil sampai invoice tampil dan webhook terverifikasi. |
| **G4** | 2027-01-10 | Riwayat Cust, antrean Tenant, dan produk berjalan. |
| **G5** | 2027-01-17 | Laporan, E2E, keamanan, dan staging lulus; build kandidat rilis siap. |
| **G6** | 2027-01-22 | UAT selesai dan disetujui; tidak ada bug P0/P1. |
| **G7** | 2027-01-24 | Produksi berjalan; QRIS live berhasil. |
| **G8** | 2027-01-31 | Pilot selesai; serah terima dan retrospektif selesai. |

## Cara kerja

### Alur status

`Backlog → Ready → In Progress → In Review (PR) → QA → Done`

Issue fitur memakai `Refs #` di PR, bukan `Closes #`. Bug yang ditemukan saat QA dibuat sebagai issue baru dengan label `type/bug`.

### Definition of Ready

- Tujuan dan manfaatnya jelas bagi Cust atau Tenant.
- Kriteria penerimaan dapat diuji, minimal 3 butir.
- Desain atau kontrak API sudah ditautkan.
- Kebutuhan data, akses, dan lingkungan diketahui.
- Sudah diperkirakan (1/2/3/5/8) dan masuk milestone.
- Tidak ada pertanyaan yang menghambat.
- Pekerjaan cukup kecil untuk satu sprint.

### Definition of Done

- Semua kriteria penerimaan terbukti.
- Review kode selesai dan CI lulus.
- Pengujian ditambahkan dan E2E diperbarui.
- Sudah dijalankan di staging dan diperiksa QA.
- Tidak ada bug P0/P1 terbuka.
- Dokumentasi, OpenAPI, dan `.env.example` diperbarui bila berubah.
- Product owner atau QA menyetujui.
- Issue ditutup setelah QA lulus.

### Prioritas dan bug P0–P3

| Prioritas | Arti | Tindakan |
| :---: | :--- | :--- |
| **P0** | Pembayaran/pesanan rusak, data bocor, semua pengguna terhambat | Hentikan sprint, perbaiki dalam 24 jam |
| **P1** | Alur utama gagal, hanya ada solusi sementara | Perbaiki sebelum rilis |
| **P2** | Mengganggu tetapi tidak menghambat | Sprint berikutnya |
| **P3** | Kosmetik atau ide | Masukkan daftar berikutnya |

### Finalisasi fitur

Tidak ada fitur baru setelah **16 Januari 2027**. Hanya bug P0/P1 yang diperbaiki. PR harus kecil dan direview dalam 24 jam. Setiap gate yang gagal dicatat sebagai risiko dan keputusan, bukan dibiarkan.

## Dokumen pendukung

| Dokumen | Isi |
| :--- | :--- |
| [`docs/01-discovery-plan.md`](docs/01-discovery-plan.md) | Panduan wawancara, observasi, dan sintesis riset |
| [`docs/03-backlog.md`](docs/03-backlog.md) | 35 issue, 197 poin, dan kriteria selesai |
| [`docs/04-github-projects-setup.md`](docs/04-github-projects-setup.md) | Cara membuat papan, field, label, dan otomatisasi |
| [`docs/05-execution-plan-2-months.md`](docs/05-execution-plan-2-months.md) | Jadwal harian, checkpoint, dan pengurangan ruang lingkup |

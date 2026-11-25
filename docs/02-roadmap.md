# 02 — Roadmap dan Cara Kerja Tim

> Rencana aktif: **1 Desember 2026 – 31 Januari 2027** (9 minggu, 5 sprint). Jadwal harian ada di [`docs/05-execution-plan-2-months.md`](05-execution-plan-2-months.md). Istilah teknis yang sering muncul dijelaskan di [`README.md`](../README.md#istilah-yang-dipakai). Dokumen ini menjelaskan cara tim bekerja dan menjaga kualitas.

## 1. Prinsip kerja

- **Pastikan kebutuhan sebelum membuat fitur.** Fitur harus berdasarkan hasil wawancara atau keputusan di PRD.
- **Selesaikan satu alur sampai bisa dipakai.** Utamakan alur Cust: daftar tenant → detail → keranjang → checkout → QRIS → invoice.
- **Pekerjaan kecil dan sering.** Issue kecil, PR kecil, dan demo di akhir sprint.
- **Pembayaran adalah bagian paling berisiko.** Uji QRIS di sandbox lebih awal dan siapkan pencocokan data pembayaran.
- **Tidak ada fitur tambahan tanpa persetujuan.** Permintaan baru harus masuk melalui perubahan resmi, bukan lewat chat.

## 2. Tim dan peran

Contoh untuk 5 orang. Jika tim lebih kecil, beberapa peran dapat digabung dan kapasitas harus dikurangi.

| Peran | Tanggung jawab | Hasil utama |
| :--- | :--- | :--- |
| Product Manager / BA | Menentukan prioritas, menulis PRD, memimpin wawancara, berkomunikasi dengan pihak terkait | PRD, daftar pekerjaan, kriteria penerimaan |
| UI/UX Designer | Membuat alur, wireframe, desain visual, panduan komponen (design system), dan uji kegunaan | Desain Figma, prototipe, catatan uji |
| Frontend Engineer | Membuat tampilan Cust dan Tenant, mengatur status tampilan, menghubungkan API | Halaman, komponen, uji E2E |
| Backend Engineer | Membuat API, database, login, QRIS, webhook, dan laporan | Endpoint, perubahan database, pengujian |
| QA Engineer | Menyusun rencana uji, E2E, keamanan, UAT, dan memutuskan kesiapan rilis | Laporan uji, bug, persetujuan |

**Aturan GitHub:** setiap orang memiliki issue yang ditugaskan, branch sendiri, dan minimal satu reviewer. Tidak ada push langsung ke `main`.

## 3. Jadwal sprint

| Sprint | Tanggal | Fokus | Issue | Milestone | Poin | Hasil yang harus ada |
| :--- | :--- | :--- | :--- | :--- | ---: | :--- |
| **Sprint 0** | 1–6 Des | Rapat pembuka, menyiapkan wawancara, mulai observasi | DISC-01…DISC-02 | M0 (berjalan) | 5 | 8+ Cust, 2+ Tenant, 1 observasi, repo dan papan siap |
| **Sprint 1** | 7–20 Des | Menyelesaikan riset, PRD, desain, ERD/API/ADR, fondasi awal | DISC-03…DISC-05, DES-01…DES-06, DEV-01 | M0 dan M1 | 61 | PRD disetujui; desain/ERD/OpenAPI/ADR; QRIS sandbox; database |
| **Sprint 2** | 21 Des–3 Jan | Login, katalog, keranjang, checkout, QRIS, invoice | DEV-02…DEV-10, OPS-02, QA-01 | M2 dan M3 | 58 | Staging aktif; pembayaran sandbox sampai invoice |
| **Sprint 3** | 4–17 Jan | Riwayat, antrean/produk tenant, laporan, E2E, keamanan, staging | DEV-11…DEV-14, QA-02…QA-04, OPS-01 | M4 dan M5 | 50 | Antrean/produk/laporan tenant; kandidat rilis |
| **Sprint 4** | 18–31 Jan | UAT, perbaikan bug, produksi, pelatihan, pilot, retrospektif | QA-05, OPS-03…OPS-05 | M6 | 23 | UAT disetujui; produksi aktif; pilot selesai |

**Total:** 197 poin • 35 issue.

**Kemampuan tim:** target **50–60 poin per sprint 2 minggu** (Sprint 0 hanya 6 hari). Rencana ini mengasumsikan 5 orang × ±20 jam per minggu dan 1 poin ≈ 4 jam. Jika waktu kurang dari 15 jam per orang per minggu, gunakan pengurangan ruang lingkup di `docs/05` §7 atau tambah 2 minggu. Sisakan cadangan ±12,5%.

## 4. Milestone dan arti selesai

| Milestone | Minggu | Tanggal | Arti selesai |
| :--- | :---: | :--- | :--- |
| **M0 — Discovery & PRD** | 2 | Min 13 Des 2026 | PRD disetujui, persona dan alur selesai, pertanyaan terbuka sudah diputuskan |
| **M1 — Design & Technical Spec** | 3 | Min 20 Des 2026 | Prototipe diuji, ERD + OpenAPI + ADR disetujui, QRIS sandbox aktif |
| **M2 — Foundation, Katalog & Keranjang** | 4 | Min 27 Des 2026 | Login, fondasi, dan staging berjalan; Cust dapat memilih tenant, mengisi keranjang, dan membuka checkout |
| **M3 — Checkout, QRIS & Invoice** | 5 | Min 3 Jan 2027 | Pesanan dibuat, QRIS sandbox dibayar, webhook diproses, invoice tampil |
| **M4 — Riwayat & Dashboard Tenant** | 6 | Min 10 Jan 2027 | Riwayat Cust selesai; Tenant dapat melihat antrean, mengubah status, dan mengelola produk |
| **M5 — Laporan, Hardening & Staging** | 7 | Min 17 Jan 2027 | Laporan dan pencairan tampil; E2E dan keamanan lulus; kandidat rilis siap |
| **M6 — UAT, Deployment & Pilot** | 9 | Min 31 Jan 2027 | UAT disetujui, produksi aktif, pilot selesai, panduan dan retrospektif tersedia |

## 5. Alur kerja di GitHub

```
Backlog → Ready → In Progress → In Review (PR) → QA → Done
                     ↑                │            │
                     └──── perbaikan ─┘            └── bug → issue baru (P0/P1)
```

1. Issue dibuat dari template (riset, fitur, atau bug), lalu diberi label, milestone, dan estimasi.
2. Saat mulai, pindahkan issue ke **In Progress** dan buat branch.
3. Setelah PR dibuka, pindahkan issue ke **In Review**. Reviewer menguji, bukan hanya melihat kode.
4. Setelah PR digabung dan dijalankan di staging, QA memeriksa kriteria penerimaan. Jika lulus, pindahkan ke **QA**.
5. Setelah QA lulus, pindahkan ke **Done** dan tutup issue. Untuk issue fitur, gunakan `Refs #<nomor>` di PR. Gunakan `Closes #<nomor>` hanya untuk perubahan dokumentasi atau pekerjaan kecil yang tidak memerlukan QA terpisah.
6. Bug yang ditemukan saat QA dibuat sebagai issue baru dengan label `type/bug` dan prioritas. Jangan memperbaikinya diam-diam di PR yang sama.

**Nama branch:**

```
feat/FT-12-tenant-list
fix/FT-34-status-order
chore/FT-01-ci-setup
docs/FT-11-prd
test/FT-53-e2e-cust
```

**Pesan commit (format yang lazim):**

```
feat(cust): tampilkan daftar tenant aktif
fix(payment): tangani webhook duplikat
test(tenant): tambah e2e antrean pesanan
docs(prd): putuskan pencairan manual
```

**PR:** usahakan kurang dari ±400 baris perubahan. Isi template PR, sertakan screenshot untuk perubahan tampilan, tautkan issue, pastikan CI lulus, dan minta minimal satu persetujuan.

## 6. Syarat issue siap dikerjakan (Definition of Ready)

Issue boleh masuk **Ready** jika:

- [ ] Tujuan dan manfaatnya jelas bagi Cust atau Tenant.
- [ ] Kriteria penerimaan dapat diuji, minimal 3 butir.
- [ ] Desain atau kontrak API sudah ditautkan.
- [ ] Kebutuhan data, akses, dan lingkungan kerja sudah diketahui.
- [ ] Sudah diperkirakan (1/2/3/5/8) dan masuk milestone.
- [ ] Tidak ada pertanyaan yang menghambat. Jika ada, tulis asumsi dan pemiliknya.
- [ ] Pekerjaan cukup kecil untuk selesai dalam satu sprint.

## 7. Syarat issue selesai (Definition of Done)

- [ ] Semua kriteria penerimaan terbukti, bukan hanya kode sudah ditulis.
- [ ] Review kode selesai dan CI lulus (lint, typecheck, unit/integration, build).
- [ ] Pengujian yang relevan ditambahkan; E2E diperbarui untuk alur utama.
- [ ] Sudah dijalankan di staging dan diperiksa QA.
- [ ] Tidak ada bug P0/P1 yang terbuka.
- [ ] Dokumentasi, OpenAPI, dan `.env.example` diperbarui jika berubah.
- [ ] Product owner atau QA memberi persetujuan untuk fitur.
- [ ] Issue ditutup setelah QA lulus.

## 8. Prioritas dan tingkat bug

| Tingkat | Arti | Tindakan |
| :--- | :--- | :--- |
| **P0** | Pembayaran/pesanan rusak, data bocor, semua pengguna terhambat | Hentikan sprint, perbaiki dalam 24 jam |
| **P1** | Alur utama gagal, hanya ada solusi sementara | Perbaiki sebelum rilis |
| **P2** | Mengganggu, tetapi tidak menghambat | Sprint berikutnya |
| **P3** | Kosmetik atau ide | Masukkan daftar berikutnya |

**Aturan:** bug P0/P1 tidak boleh ditunda demi fitur baru. Jika muncul pada Sprint 4 atau setelah pembekuan fitur, rilis atau pilot ditunda sampai lulus.

## 9. Kegiatan rutin dan komunikasi

| Kegiatan | Waktu | Durasi | Hasil |
| :--- | :--- | :---: | :--- |
| Sprint planning | Awal sprint | 90 menit | Tujuan sprint, issue siap, kapasitas |
| Daily sync | Setiap hari (boleh tertulis) | 15 menit | Hambatan, kemajuan, rencana hari ini |
| Mid-sprint check | Pertengahan sprint | 30 menit | Risiko dan penyesuaian ruang lingkup |
| Demo/review | Akhir sprint | 60 menit | Demo ke pihak terkait dan masukan |
| Retrospektif | Setelah review | 45 menit | 1–2 perbaikan proses |

**Tujuan sprint** ditulis di deskripsi milestone atau papan, bukan hanya daftar issue. Contoh Sprint 2: “Cust dapat membayar pesanan sandbox melalui QRIS dan melihat invoice tanpa bantuan manual.”

## 10. Risiko dan cara mengurangi

| # | Risiko | Dampak | Kemungkinan | Cara mengurangi | Pemilik |
| :---: | :--- | :---: | :---: | :--- | :--- |
| 1 | Persetujuan QRIS live terlambat | Tinggi | Tinggi | Ajukan akun sejak 14 Des (DES-06); gunakan sandbox; jangan menunggu live untuk UAT; tunda pilot, bukan menambah fitur | PM |
| 2 | Aturan pencairan belum jelas | Tinggi | Sedang | Selesaikan di DISC-05/PRD; buat buku besar; gunakan transfer manual; cocokkan setiap hari | PM + Keuangan |
| 3 | Permintaan fitur baru | Tinggi | Tinggi | Gunakan PRD dan perubahan resmi; simpan permintaan di luar ruang lingkup; evaluasi setelah pilot | PM |
| 4 | Waktu tim terbatas karena kuliah | Sedang | Tinggi | Target 50–60 poin per sprint 2 minggu; cadangan ±12,5%; utamakan P0/P1; gunakan pengurangan ruang lingkup `docs/05` §7 | Seluruh tim |
| 5 | Webhook hilang atau ganda | Tinggi | Sedang | Verifikasi tanda tangan, cegah proses ganda, catat audit, dan jalankan pencocokan data | Backend |
| 6 | Internet atau perangkat tenant buruk | Sedang | Sedang | Uji di HP kelas bawah; gunakan pemeriksaan status berkala dan coba ulang; buat UI ringan | Frontend + QA |
| 7 | Data antar-tenant bocor | Tinggi | Sedang | Uji hak akses per peran, review keamanan QA-04, dan selalu batasi query berdasarkan tenant | Backend + QA |
| 8 | Harga atau ketersediaan tidak konsisten | Tinggi | Sedang | Hitung ulang harga di server, simpan salinan harga, gunakan transaksi database, dan periksa ketersediaan | Backend |
| 9 | Libur akademik menggeser jadwal | Sedang | Tinggi | Selesaikan pekerjaan penting di W1–W3; pertahankan titik pemeriksaan; kurangi P2; gunakan cadangan W8–W9 | PM |
| 10 | Pengetahuan hanya di satu orang | Sedang | Sedang | Tulis ADR/OpenAPI, lakukan pairing, dan review silang | Tech lead |

## 11. Ukuran keberhasilan

**Proses kerja**

- Tujuan sprint tercapai ≥ 80%.
- PR direview dalam < 24 jam; tidak ada issue di In Review lebih dari 3 hari.
- Tidak ada bug P0/P1 saat rilis.

**Produk**

- Pembayaran berhasil ≥ 95% (sandbox, lalu live).
- Pesanan berhasil dibuat ≥ 99% tanpa error server.
- Waktu dari checkout sampai status terbayar < 2 menit (median).
- Pesanan masuk ke antrean tenant < 1 menit setelah pembayaran.
- Keberhasilan tugas UAT ≥ 90%; tidak ada masalah kegunaan yang menghambat.

**Pilot**

- ≥ 80% tenant aktif menggunakan antrean.
- Minimal 50 transaksi selama 1 minggu pilot (sesuaikan dengan jumlah tenant).
- ≥ 70% Cust yang mencoba menyatakan akan memakai lagi.
- Tidak ada masalah dana atau pesanan yang tidak selesai.

## 12. Perubahan ruang lingkup

1. Permintaan baru ditulis sebagai issue baru dengan label `type/feature`.
2. PM menilai dampaknya terhadap waktu, biaya, dan risiko.
3. Jika disetujui, masukkan ke sprint/milestone dan perbarui PRD. Jika tidak, tutup dengan alasan.
4. Perubahan pada pembayaran, struktur pesanan, atau data pribadi harus direview teknis dan QA.
5. Tidak ada perubahan yang hanya disepakati di chat tanpa issue.

## 13. Di luar ruang lingkup versi pertama

- Keranjang dan checkout lintas tenant
- Pengantaran, reservasi, dan pesan-antar
- Promo, voucher, poin, dan ulasan
- Chat, notifikasi push, dan WhatsApp gateway
- Refund otomatis atau pembatalan sepihak
- Akun dua peran dan halaman admin
- Aplikasi khusus Android/iOS (native)
- Pencairan otomatis melalui API pencairan
- Dasbor analitik lanjutan dan mode offline

Semua hal di atas dapat menjadi daftar pekerjaan versi berikutnya setelah pilot dievaluasi.

# 03 — Daftar Pekerjaan (Backlog) Siap Impor

Dokumen ini adalah daftar utama pekerjaan FT Food. Setiap pekerjaan memiliki tujuan, perkiraan waktu, prioritas, dan kriteria selesai. Data di dokumen ini juga dipakai oleh `scripts/setup-github.ps1` untuk membuat issue di GitHub. Jangan mengubah format penanda metadata tanpa menyesuaikan skrip.

**Cara membaca**

- **Perkiraan (estimate):** 1 = XS, 2 = S, 3 = M, 5 = L, 8 = XL. Untuk jadwal 2 bulan, 1 poin ≈ 4 jam (0,5 hari kerja).
- **Prioritas:** P0 = menghambat seluruh pekerjaan, P1 = wajib untuk milestone, P2 = sebaiknya, P3 = dikerjakan nanti.
- **Bergantung pada:** pekerjaan yang harus selesai atau berjalan lebih dulu.
- **Kriteria selesai:** semua butir harus terbukti sebelum issue dipindahkan ke Done.

Beberapa istilah teknis seperti API, webhook, staging, dan E2E tetap dipakai agar sesuai dengan nama menu GitHub dan dokumentasi teknis.

**Total: 35 issue • 197 poin • 7 milestone.**

| Milestone | Jumlah issue | Poin |
| :--- | ---: | ---: |
| M0 — Discovery & PRD | 5 | 23 |
| M1 — Design & Technical Spec | 6 | 35 |
| M2 — Foundation, Katalog & Keranjang | 7 | 38 |
| M3 — Checkout, QRIS & Invoice | 5 | 28 |
| M4 — Riwayat & Dashboard Tenant | 4 | 25 |
| M5 — Laporan, Hardening & Staging | 4 | 25 |
| M6 — UAT, Deployment & Pilot | 4 | 23 |

> Jadwal 2 bulan dan pembagian issue per minggu ada di [`docs/05-execution-plan-2-months.md`](05-execution-plan-2-months.md). Field `Sprint` di GitHub memakai `Sprint 0` sampai `Sprint 4`.

---

## M0 — Discovery & PRD

<!-- issue {"key":"DISC-01","title":"Rapat pembuka, peta pihak terkait, dan ruang lingkup","milestone":"M0 — Discovery & PRD","labels":["type/research","area/discovery","priority/p1"],"estimate":2} -->
### DISC-01 — Rapat pembuka, peta pihak terkait, dan ruang lingkup

**Tujuan:** Menyamakan tujuan, batas, peran, dan jadwal sebelum riset dimulai.
**Hasil:** Dokumen 1 halaman + peta pihak terkait.
**Kriteria selesai:**
- [ ] Dokumen berisi tujuan, ruang lingkup, hal di luar ruang lingkup, dan ukuran keberhasilan.
- [ ] Peta pihak terkait mencakup Cust, Tenant, pengelola kantin, keuangan/fakultas, dan tim.
- [ ] Pembagian peran dan saluran komunikasi disepakati.
- [ ] Asumsi dan risiko awal dicatat, termasuk pemiliknya.
**Bergantung pada:** —

<!-- /issue -->

<!-- issue {"key":"DISC-02","title":"Panduan wawancara, persetujuan, dan rekrutmen peserta","milestone":"M0 — Discovery & PRD","labels":["type/research","area/discovery","priority/p1"],"estimate":3} -->
### DISC-02 — Panduan wawancara, persetujuan, dan rekrutmen peserta

**Tujuan:** Menyiapkan panduan wawancara dan peserta yang tidak bias.
**Hasil:** `research/instruments/`, daftar peserta, lembar persetujuan.
**Kriteria selesai:**
- [ ] Panduan wawancara untuk Cust, Tenant, dan pengelola tersedia.
- [ ] Lembar persetujuan dan panduan pembuka/penutup siap dipakai.
- [ ] Daftar target peserta (kriteria, jumlah, jadwal) disusun.
- [ ] Uji coba 1 wawancara per kelompok dilakukan dan pertanyaan diperbaiki.
- [ ] Pertanyaan tidak mengarahkan jawaban ke fitur yang diinginkan tim.
**Bergantung pada:** DISC-01

<!-- /issue -->

<!-- issue {"key":"DISC-03","title":"Wawancara Cust, Tenant, dan pengelola + observasi lapangan","milestone":"M0 — Discovery & PRD","labels":["type/research","area/discovery","priority/p1"],"estimate":8} -->
### DISC-03 — Wawancara Cust, Tenant, dan pengelola + observasi lapangan

**Tujuan:** Memahami cara pembeli dan penjual kantin bekerja saat ini.
**Hasil:** Catatan wawancara tanpa nama, hasil observasi, dan daftar masalah.
**Kriteria selesai:**
- [ ] Minimal 15 Cust, 5 Tenant, dan 1 pengelola/keuangan diwawancarai.
- [ ] Observasi dilakukan pada 2 jam sibuk dan 1 jam sepi.
- [ ] Setiap sesi memiliki persetujuan peserta dan kode responden, tanpa nama asli.
- [ ] Catatan memuat kejadian nyata, kutipan penting, waktu tunggu, dan cara bayar.
- [ ] Minimal 5 masalah utama yang berulang ditemukan dengan bukti.
**Bergantung pada:** DISC-02

<!-- /issue -->

<!-- issue {"key":"DISC-04","title":"Merangkum riset, persona, dan peta perjalanan","milestone":"M0 — Discovery & PRD","labels":["type/research","area/discovery","priority/p1"],"estimate":5} -->
### DISC-04 — Merangkum riset, persona, dan peta perjalanan

**Tujuan:** Mengubah catatan mentah menjadi temuan yang dapat diprioritaskan.
**Hasil:** Kelompok temuan, tabel dampak dan frekuensi, persona, dan peta perjalanan.
**Kriteria selesai:**
- [ ] Semua catatan wawancara dan observasi dikelompokkan berdasarkan tema.
- [ ] Masalah dinilai berdasarkan frekuensi dan dampak.
- [ ] Setiap masalah memiliki bukti kutipan atau observasi, bukan opini tim.
- [ ] Persona Cust dan Tenant serta peta perjalanannya selesai.
- [ ] Setiap fitur dipetakan ke masalah atau ditandai sebagai asumsi.
**Bergantung pada:** DISC-03

<!-- /issue -->

<!-- issue {"key":"DISC-05","title":"Perbandingan aplikasi, ruang lingkup MVP, dan PRD","milestone":"M0 — Discovery & PRD","labels":["type/research","area/discovery","priority/p1"],"estimate":5} -->
### DISC-05 — Perbandingan aplikasi, ruang lingkup MVP, dan PRD

**Tujuan:** Menetapkan batas versi pertama dan menulis acuan produk.
**Hasil:** Ringkasan perbandingan, prioritas fitur, PRD v1 yang disetujui.
**Kriteria selesai:**
- [ ] 3–5 aplikasi sejenis dibandingkan pada alur, pembayaran, status, biaya, dan pencairan.
- [ ] Fitur wajib, sebaiknya, bisa nanti, dan tidak dikerjakan disepakati.
- [ ] 12 pertanyaan terbuka memiliki keputusan atau pemilik dan tenggat.
- [ ] PRD memuat alur, status pesanan, kebutuhan fungsional/non-fungsional, dan hal di luar ruang lingkup.
- [ ] PRD direview pengelola/dosen pembimbing dan mendapat persetujuan tertulis.
**Bergantung pada:** DISC-04

<!-- /issue -->

---

## M1 — Design & Technical Spec

<!-- issue {"key":"DES-01","title":"Peta halaman dan alur pengguna","milestone":"M1 — Design & Technical Spec","labels":["type/design","area/design","priority/p1"],"estimate":3} -->
### DES-01 — Peta halaman dan alur pengguna

**Tujuan:** Memetakan halaman dan perpindahan sebelum membuat wireframe.
**Hasil:** Peta halaman + diagram alur Cust dan Tenant.
**Kriteria selesai:**
- [ ] Peta halaman Cust dan Tenant disusun sesuai spesifikasi.
- [ ] Alur Cust: daftar tenant → detail → keranjang → checkout → QRIS → invoice → riwayat.
- [ ] Alur Tenant: antrean → produk → laporan dan pencairan.
- [ ] Tampilan kosong, memuat, error, dan tombol kembali digambarkan.
- [ ] Direview bersama PM dan developer untuk kelayakan.
**Bergantung pada:** DISC-05

<!-- /issue -->

<!-- issue {"key":"DES-02","title":"Wireframe Cust/Tenant dan uji kegunaan","milestone":"M1 — Design & Technical Spec","labels":["type/design","area/design","priority/p1"],"estimate":8} -->
### DES-02 — Wireframe Cust/Tenant dan uji kegunaan

**Tujuan:** Menguji alur sebelum membuat desain visual dan kode.
**Hasil:** Wireframe 7 layar Cust, wireframe Tenant, dan laporan uji kegunaan.
**Kriteria selesai:**
- [ ] Wireframe Cust mencakup tenant list, detail, keranjang, checkout, QRIS, invoice, dan riwayat.
- [ ] Wireframe Tenant mencakup dashboard, antrean, produk, dan laporan.
- [ ] Tombol `+`, jumlah, subtotal, dan tombol checkout jelas.
- [ ] 5 responden (3 Cust, 2 Tenant) menguji prototipe; keberhasilan tugas dan masalah dicatat.
- [ ] Perbaikan kritis diterapkan dan diuji ulang.
**Bergantung pada:** DES-01

<!-- /issue -->

<!-- issue {"key":"DES-03","title":"Desain visual dan panduan komponen","milestone":"M1 — Design & Technical Spec","labels":["type/design","area/design","priority/p1"],"estimate":8} -->
### DES-03 — Desain visual dan panduan komponen

**Tujuan:** Menyediakan desain final yang konsisten dan siap dibuat.
**Hasil:** Figma final + komponen dasar.
**Kriteria selesai:**
- [ ] Semua layar Cust dan Tenant berstatus final dengan teks nyata.
- [ ] Warna, tipografi, jarak, sudut, dan bayangan terdokumentasi.
- [ ] Komponen tombol, input, kartu, badge, modal, notifikasi, dan tampilan kosong/memuat/error tersedia.
- [ ] Kontras teks memenuhi WCAG AA dan ukuran tombol minimal 44px.
- [ ] Catatan untuk developer (perilaku, error, status) tersedia.
**Bergantung pada:** DES-02

<!-- /issue -->

<!-- issue {"key":"DES-04","title":"ERD, kontrak API, dan alur status pesanan","milestone":"M1 — Design & Technical Spec","labels":["type/tech","area/platform","priority/p1"],"estimate":8} -->
### DES-04 — ERD, kontrak API, dan alur status pesanan

**Tujuan:** Menetapkan struktur data, kontrak API, dan status pesanan.
**Hasil:** ERD, kamus data, OpenAPI, dan diagram status.
**Kriteria selesai:**
- [ ] Entitas minimal: User, Tenant, Product, Order, OrderItem, Payment, Payout.
- [ ] Relasi, batasan, dan indeks utama terdokumentasi.
- [ ] Harga disimpan sebagai bilangan bulat; nama dan harga produk disalin ke item pesanan.
- [ ] OpenAPI memuat endpoint, hak akses, format error, dan contoh request/response.
- [ ] Status pesanan dan perpindahan yang sah disepakati.
**Bergantung pada:** DISC-05

<!-- /issue -->

<!-- issue {"key":"DES-05","title":"Catatan keputusan teknologi dan kebutuhan non-fungsional","milestone":"M1 — Design & Technical Spec","labels":["type/tech","area/platform","priority/p1"],"estimate":5} -->
### DES-05 — Catatan keputusan teknologi dan kebutuhan non-fungsional

**Tujuan:** Mengambil keputusan teknis dan menetapkan standar kualitas.
**Hasil:** ADR + kebutuhan non-fungsional + strategi pengujian.
**Kriteria selesai:**
- [ ] Pilihan hosting, database, login, pembayaran, penyimpanan file, dan cara peluncuran dicatat.
- [ ] Alasan, risiko, dan konsekuensi setiap pilihan dijelaskan.
- [ ] Target kecepatan, keamanan, aksesibilitas, dan perangkat ditetapkan.
- [ ] Strategi pengujian, lingkungan, dan data uji dijelaskan.
- [ ] Syarat rilis dan UAT disepakati.
**Bergantung pada:** DISC-05, DES-04

<!-- /issue -->

<!-- issue {"key":"DES-06","title":"Pilih dan siapkan penyedia pembayaran QRIS","milestone":"M1 — Design & Technical Spec","labels":["type/tech","area/payment","priority/p0"],"estimate":3} -->
### DES-06 — Pilih dan siapkan penyedia pembayaran QRIS

**Tujuan:** Memastikan pembayaran dapat diuji seawal mungkin.
**Hasil:** Keputusan penyedia, akun sandbox, dan kredensial aman.
**Kriteria selesai:**
- [ ] Minimal 2 penyedia dibandingkan: biaya, sandbox, webhook, pencairan, dan dokumentasi.
- [ ] Akun sandbox dibuat dan kunci disimpan di tempat aman.
- [ ] Pembuatan QRIS dan webhook berhasil diuji di sandbox.
- [ ] Persyaratan akun live diidentifikasi dan diajukan.
- [ ] Keputusan dicatat di ADR.
**Bergantung pada:** DES-05

<!-- /issue -->

---

## M2 — Foundation, Katalog & Keranjang

<!-- issue {"key":"DEV-01","title":"Siapkan repository, CI, environment, dan database","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/tech","area/platform","priority/p0"],"estimate":8} -->
### DEV-01 — Siapkan repository, CI, environment, dan database

**Tujuan:** Menyediakan fondasi kerja dan data sebelum fitur dibuat.
**Hasil:** Repository siap, CI berjalan, environment terpisah, database dan data awal tersedia.
**Kriteria selesai:**
- [ ] Repository memiliki README, `.gitignore`, `.env.example`, dan struktur folder yang disepakati.
- [ ] `main` dilindungi: wajib PR, minimal 1 review, dan CI lulus.
- [ ] CI menjalankan lint, typecheck, test, dan build.
- [ ] Environment lokal/staging/produksi terpisah; tidak ada rahasia di repository.
- [ ] Migration dan data awal (3 tenant, produk, akun) dapat dijalankan dari nol.
**Bergantung pada:** DISC-05 (ERD/API final dari DES-04 diperlukan sebelum migration)

<!-- /issue -->

<!-- issue {"key":"DEV-02","title":"Login, hak akses, dan penanganan error dasar","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/feature","area/platform","priority/p0"],"estimate":8} -->
### DEV-02 — Login, hak akses, dan penanganan error dasar

**Tujuan:** Memastikan setiap pengguna hanya mengakses data sesuai perannya.
**Hasil:** Register/login/logout, pembatasan akses, dan format error yang konsisten.
**Kriteria selesai:**
- [ ] Cust dan Tenant dapat register/login/logout; kata sandi disimpan dengan aman.
- [ ] Peran disimpan di server dan tidak dapat diubah dari sisi pengguna.
- [ ] Halaman dan API Cust/Tenant terlindungi sesuai peran.
- [ ] Tenant hanya dapat mengakses datanya; Cust hanya dapat mengakses pesanannya.
- [ ] Uji akses tanpa izin (401/403/404) lulus dan error tidak membocorkan data.
**Bergantung pada:** DEV-01, DES-04

<!-- /issue -->

<!-- issue {"key":"DEV-03","title":"Layout dan komponen dasar tampilan","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/feature","area/platform","priority/p1"],"estimate":5} -->
### DEV-03 — Layout dan komponen dasar tampilan

**Tujuan:** Menyediakan komponen konsisten agar fitur Cust/Tenant cepat dibuat.
**Hasil:** Kerangka aplikasi + komponen dasar + halaman contoh.
**Kriteria selesai:**
- [ ] Warna, tipografi, jarak, dan sudut sesuai Figma.
- [ ] Tombol, input, kartu, badge, modal, notifikasi, dan tampilan kosong/memuat/error tersedia.
- [ ] Kerangka aplikasi responsif untuk HP dan desktop.
- [ ] Komponen memiliki status hover/fokus/nonaktif/error dan mudah diakses.
- [ ] Halaman contoh (panduan tampilan) tersedia untuk QA.
**Bergantung pada:** DES-03

<!-- /issue -->

<!-- issue {"key":"DEV-04","title":"API dan halaman daftar tenant","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/feature","area/cust","priority/p1"],"estimate":5} -->
### DEV-04 — API dan halaman daftar tenant

**Tujuan:** Cust dapat melihat tenant yang sedang berjualan.
**Hasil:** Endpoint daftar tenant + halaman responsif.
**Kriteria selesai:**
- [ ] Hanya tenant yang sedang buka yang ditampilkan.
- [ ] Data berisi id, nama, foto, dan status yang dibutuhkan tampilan.
- [ ] Halaman memiliki status memuat, kosong, error, dan tombol coba lagi.
- [ ] Klik tenant membuka halaman detail yang dipilih.
- [ ] Tampilan baik pada 360px, 390px, dan desktop.
**Bergantung pada:** DEV-02, DEV-03

<!-- /issue -->

<!-- issue {"key":"DEV-05","title":"API dan halaman detail tenant + tambah ke keranjang","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/feature","area/cust","priority/p1"],"estimate":5} -->
### DEV-05 — API dan halaman detail tenant + tambah ke keranjang

**Tujuan:** Cust dapat memilih makanan dan memasukkannya ke keranjang.
**Hasil:** Endpoint detail tenant + halaman detail + tombol tambah.
**Kriteria selesai:**
- [ ] Profil tenant dan daftar produk aktif tampil dengan harga.
- [ ] Produk tidak tersedia tidak dapat ditambahkan dan diberi label jelas.
- [ ] Tombol `+` menambah jumlah dan menampilkan ringkasan keranjang.
- [ ] Status memuat, error, dan tenant tidak ditemukan ditangani.
- [ ] Tampilan nyaman pada layar kecil.
**Bergantung pada:** DEV-04

<!-- /issue -->

<!-- issue {"key":"DEV-06","title":"Keranjang dan halaman checkout","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/feature","area/cust","priority/p1"],"estimate":5} -->
### DEV-06 — Keranjang dan halaman checkout

**Tujuan:** Cust dapat memeriksa pesanan sebelum membayar.
**Hasil:** Halaman keranjang + ringkasan checkout.
**Kriteria selesai:**
- [ ] Cust dapat menambah, mengurangi, dan menghapus item; jumlah tidak boleh ≤ 0.
- [ ] Subtotal dan total dihitung benar.
- [ ] Keranjang hanya memuat produk dari satu tenant; berpindah tenant meminta konfirmasi.
- [ ] Keranjang bertahan saat refresh dan dibersihkan setelah checkout sukses/logout.
- [ ] Checkout menampilkan ringkasan, tombol QRIS, dan mencegah klik ganda.
- [ ] Tampilan kosong mengarahkan pengguna kembali ke daftar tenant.
**Bergantung pada:** DEV-05

<!-- /issue -->

<!-- issue {"key":"OPS-02","title":"Deploy staging dan uji singkat","milestone":"M2 — Foundation, Katalog & Keranjang","labels":["type/ops","area/ops","priority/p1"],"estimate":2} -->
### OPS-02 — Deploy staging dan uji singkat

**Tujuan:** Menyediakan lingkungan uji yang mirip produksi.
**Hasil:** Staging aktif + daftar periksa uji singkat.
**Kriteria selesai:**
- [ ] Peluncuran otomatis dari branch/tag yang disepakati.
- [ ] Migrasi database berjalan di staging.
- [ ] Uji singkat: login, daftar tenant, checkout, QRIS sandbox, antrean, laporan.
- [ ] Data staging terpisah dan aman.
- [ ] URL staging dibagikan ke tim/QA.
**Bergantung pada:** DEV-01, DEV-02

<!-- /issue -->

---

## M3 — Checkout, QRIS & Invoice

<!-- issue {"key":"DEV-07","title":"API checkout dan pembuatan pesanan","milestone":"M3 — Checkout, QRIS & Invoice","labels":["type/feature","area/cust","priority/p1"],"estimate":5} -->
### DEV-07 — API checkout dan pembuatan pesanan

**Tujuan:** Mengubah keranjang menjadi pesanan yang konsisten dan aman.
**Hasil:** Endpoint pembuatan pesanan + pengujian.
**Kriteria selesai:**
- [ ] Server menghitung ulang harga dari database, bukan dari sisi pengguna.
- [ ] Ketersediaan tenant, produk, dan jumlah divalidasi.
- [ ] Nama dan harga produk disalin ke item pesanan.
- [ ] Pesanan baru berstatus `MENUNGGU_PEMBAYARAN` dengan kode unik.
- [ ] Kunci idempotensi mencegah pesanan ganda saat request diulang.
- [ ] Uji harga berubah, produk habis, dan tenant tutup.
**Bergantung pada:** DEV-06, DES-04

<!-- /issue -->

<!-- issue {"key":"DEV-08","title":"Integrasi QRIS dan tampilan pembayaran","milestone":"M3 — Checkout, QRIS & Invoice","labels":["type/feature","area/payment","priority/p0"],"estimate":8} -->
### DEV-08 — Integrasi QRIS dan tampilan pembayaran

**Tujuan:** Cust dapat memindai QRIS dan melihat status pembayaran.
**Hasil:** Layanan pembuatan QRIS + halaman pembayaran.
**Kriteria selesai:**
- [ ] QRIS dibuat dengan id pesanan, nominal, dan waktu kedaluwarsa.
- [ ] Data pembayaran dan referensi penyedia disimpan dengan aman.
- [ ] Halaman menampilkan QR, nominal, kode pesanan, dan hitung mundur.
- [ ] Status diperbarui berkala; sukses menuju invoice, gagal/kedaluwarsa menampilkan langkah berikutnya.
- [ ] Diuji di sandbox dan nyaman dipakai pada layar 360px.
**Bergantung pada:** DEV-07, DES-06

<!-- /issue -->

<!-- issue {"key":"DEV-09","title":"Webhook pembayaran, pencegahan proses ganda, dan audit","milestone":"M3 — Checkout, QRIS & Invoice","labels":["type/feature","area/payment","priority/p0"],"estimate":5} -->
### DEV-09 — Webhook pembayaran, pencegahan proses ganda, dan audit

**Tujuan:** Status pesanan berubah otomatis dan aman saat pembayaran selesai.
**Hasil:** Endpoint webhook + pengujian + catatan audit.
**Kriteria selesai:**
- [ ] Tanda tangan dan sumber webhook diverifikasi.
- [ ] Kejadian sukses/pending/gagal/kedaluwarsa mengubah status pesanan dengan benar.
- [ ] Kejadian ganda tidak mengubah status dua kali.
- [ ] Kejadian di luar urutan tidak merusak status; perpindahan tidak sah ditolak.
- [ ] Catatan audit memuat kejadian, pesanan, dan hasil pemrosesan.
- [ ] Tersedia perintah/proses pencocokan pesanan yang belum selesai dengan status penyedia pembayaran.
**Bergantung pada:** DEV-08, DES-04

<!-- /issue -->

<!-- issue {"key":"DEV-10","title":"Invoice, kegagalan, dan coba ulang pembayaran","milestone":"M3 — Checkout, QRIS & Invoice","labels":["type/feature","area/payment","priority/p1"],"estimate":5} -->
### DEV-10 — Invoice, kegagalan, dan coba ulang pembayaran

**Tujuan:** Cust mendapatkan bukti pembayaran dan tidak terjebak saat gagal.
**Hasil:** Halaman invoice + alur gagal/kedaluwarsa + coba ulang.
**Kriteria selesai:**
- [ ] Invoice hanya dapat diakses setelah pesanan dibayar.
- [ ] Invoice menampilkan kode, tenant, item, total, metode, dan waktu pembayaran.
- [ ] Waktu memakai zona Asia/Jakarta; Cust lain tidak dapat membuka invoice.
- [ ] Pesan membedakan kedaluwarsa, gagal, dan masih menunggu.
- [ ] Coba ulang tidak membuat pesanan ganda dan pembayaran terlambat tidak menjadi sukses.
**Bergantung pada:** DEV-09

<!-- /issue -->

<!-- issue {"key":"QA-01","title":"Unit test domain pesanan dan pembayaran","milestone":"M3 — Checkout, QRIS & Invoice","labels":["type/test","area/qa","priority/p1"],"estimate":5} -->
### QA-01 — Unit test domain pesanan dan pembayaran

**Tujuan:** Melindungi logika bisnis paling penting dari kesalahan.
**Hasil:** Unit test + laporan cakupan.
**Kriteria selesai:**
- [ ] Perhitungan subtotal/total, jumlah, dan salinan harga teruji.
- [ ] Semua perpindahan status yang sah dan tidak sah teruji.
- [ ] Validasi tenant, produk, dan jumlah teruji.
- [ ] Cakupan modul domain ≥ 70%.
- [ ] Pengujian berjalan di CI dan gagal jika terjadi kesalahan baru.
**Bergantung pada:** DEV-07, DEV-09

<!-- /issue -->

---

## M4 — Riwayat & Dashboard Tenant

<!-- issue {"key":"DEV-11","title":"Riwayat pemesanan Cust","milestone":"M4 — Riwayat & Dashboard Tenant","labels":["type/feature","area/cust","priority/p1"],"estimate":5} -->
### DEV-11 — Riwayat pemesanan Cust

**Tujuan:** Cust dapat melihat dan membuka kembali pesanan yang pernah dibuat.
**Hasil:** Halaman riwayat + detail pesanan.
**Kriteria selesai:**
- [ ] Riwayat hanya menampilkan pesanan milik Cust yang login, terbaru lebih dulu.
- [ ] Setiap item menampilkan tenant, tanggal, total, dan status.
- [ ] Detail menampilkan item, pembayaran, dan tautan invoice jika sudah dibayar.
- [ ] Status kosong, memuat, error, dan batas jumlah data ditangani.
- [ ] Cust tidak dapat membuka pesanan milik Cust lain.
**Bergantung pada:** DEV-10

<!-- /issue -->

<!-- issue {"key":"DEV-12","title":"Dashboard tenant, antrean, dan ubah status pesanan","milestone":"M4 — Riwayat & Dashboard Tenant","labels":["type/feature","area/tenant","priority/p1"],"estimate":8} -->
### DEV-12 — Dashboard tenant, antrean, dan ubah status pesanan

**Tujuan:** Tenant dapat memproses pesanan dengan cepat saat jam sibuk.
**Hasil:** Dashboard, antrean pesanan, dan aksi ubah status.
**Kriteria selesai:**
- [ ] Tenant diarahkan ke dashboard miliknya dan dapat membuka antrean, produk, serta laporan.
- [ ] Antrean hanya menampilkan pesanan tenant sendiri yang sudah dibayar/diproses, urut waktu.
- [ ] Detail pesanan menampilkan item, total, waktu bayar, dan kode pesanan.
- [ ] Aksi hanya mengizinkan perpindahan `DIBAYAR → DIPROSES → SELESAI`.
- [ ] Tampilan langsung berubah, tetapi kembali ke kondisi semula jika gagal.
- [ ] Status buka/tutup tenant memengaruhi daftar tenant di sisi Cust.
**Bergantung pada:** DEV-09, DEV-02

<!-- /issue -->

<!-- issue {"key":"DEV-13","title":"Kelola produk dan ketersediaan","milestone":"M4 — Riwayat & Dashboard Tenant","labels":["type/feature","area/tenant","priority/p1"],"estimate":7} -->
### DEV-13 — Kelola produk dan ketersediaan

**Tujuan:** Tenant dapat mengelola produk yang tampil di aplikasi.
**Hasil:** Halaman produk + API + unggah foto + tombol ketersediaan.
**Kriteria selesai:**
- [ ] Tenant dapat menambah, mengubah, dan mengarsipkan produk miliknya.
- [ ] Data minimal: nama, deskripsi, harga, foto, dan ketersediaan.
- [ ] Harga > 0, nama wajib, dan jenis/ukuran foto divalidasi.
- [ ] Produk diarsipkan tidak tampil ke Cust, tetapi tetap ada di pesanan lama.
- [ ] Tombol tersedia/habis langsung memengaruhi halaman Cust.
- [ ] Tenant tidak dapat mengubah produk tenant lain.
**Bergantung pada:** DEV-12

<!-- /issue -->

<!-- issue {"key":"QA-02","title":"Integration test API, login, pesanan, dan tenant","milestone":"M4 — Riwayat & Dashboard Tenant","labels":["type/test","area/qa","priority/p1"],"estimate":5} -->
### QA-02 — Integration test API, login, pesanan, dan tenant

**Tujuan:** Memastikan API, hak akses, dan database bekerja bersama.
**Hasil:** Integration test + data uji terpisah.
**Kriteria selesai:**
- [ ] Alur login, daftar/detail tenant, pembuatan pesanan, webhook, antrean, dan produk teruji.
- [ ] Setiap test memakai database terpisah yang dibersihkan setelah digunakan.
- [ ] Hak akses antar-peran dan antar-tenant diuji.
- [ ] Pengujian berjalan di CI dalam waktu wajar (< 5 menit).
- [ ] Kegagalan menampilkan informasi yang cukup untuk memperbaiki masalah.
**Bergantung pada:** DEV-12, DEV-13

<!-- /issue -->

---

## M5 — Laporan, Hardening & Staging

<!-- issue {"key":"DEV-14","title":"Laporan omzet harian dan pencairan","milestone":"M5 — Laporan, Hardening & Staging","labels":["type/feature","area/tenant","priority/p1"],"estimate":8} -->
### DEV-14 — Laporan omzet harian dan pencairan

**Tujuan:** Tenant dapat melihat omzet hari ini dan status pencairan.
**Hasil:** Halaman laporan + status/riwayat pencairan.
**Kriteria selesai:**
- [ ] Omzet dihitung dari pesanan dibayar/selesai pada hari berjalan (Asia/Jakarta).
- [ ] Menampilkan jumlah transaksi dan item terjual.
- [ ] Pesanan menunggu bayar, gagal, dan kedaluwarsa tidak dihitung.
- [ ] Angka dapat dicocokkan dengan data penyedia pembayaran.
- [ ] Status dan riwayat pencairan berasal dari buku besar internal; transfer manual terdokumentasi.
- [ ] Hanya tenant pemilik yang dapat mengakses; batas tengah malam diuji.
**Bergantung pada:** DEV-09, DEV-12

<!-- /issue -->

<!-- issue {"key":"QA-03","title":"E2E Cust dan Tenant","milestone":"M5 — Laporan, Hardening & Staging","labels":["type/test","area/qa","priority/p1"],"estimate":6} -->
### QA-03 — E2E Cust dan Tenant

**Tujuan:** Membuktikan alur utama berjalan dari awal sampai akhir.
**Hasil:** Skenario Playwright + artefak CI.
**Kriteria selesai:**
- [ ] Cust: login → daftar tenant → detail → tambah → checkout → QRIS (mock/sandbox) → invoice → riwayat.
- [ ] Tenant: login → antrean → proses → selesai; kelola produk; lihat laporan.
- [ ] Diuji pada tampilan HP 390px.
- [ ] Selector stabil dan screenshot/video tersimpan saat gagal.
- [ ] Pengujian berjalan di CI dan menjadi syarat rilis.
**Bergantung pada:** DEV-11, DEV-13, DEV-14

<!-- /issue -->

<!-- issue {"key":"QA-04","title":"Uji QRIS, webhook, keamanan, dan performa","milestone":"M5 — Laporan, Hardening & Staging","labels":["type/test","area/qa","priority/p0"],"estimate":8} -->
### QA-04 — Uji QRIS, webhook, keamanan, dan performa

**Tujuan:** Menutup risiko pembayaran dan akses sebelum peluncuran.
**Hasil:** Laporan uji + bukti + daftar perbaikan.
**Kriteria selesai:**
- [ ] QRIS diuji untuk sukses, pending, kedaluwarsa, gagal, dan nominal tidak cocok.
- [ ] Webhook duplikat, terlambat, dan tidak valid diuji.
- [ ] Akses data antar-pengguna, validasi input, pembatasan request, dan rahasia diperiksa.
- [ ] Tidak ada temuan Critical/High yang terbuka saat rilis.
- [ ] Target kecepatan terpenuhi; tidak ada query berulang berlebihan pada halaman utama.
**Bergantung pada:** DEV-09, DEV-10, DEV-14

<!-- /issue -->

<!-- issue {"key":"OPS-01","title":"Infrastruktur produksi, domain, dan backup","milestone":"M5 — Laporan, Hardening & Staging","labels":["type/ops","area/ops","priority/p0"],"estimate":3} -->
### OPS-01 — Infrastruktur produksi, domain, dan backup

**Tujuan:** Menyiapkan lingkungan produksi yang aman dan dapat dipulihkan.
**Hasil:** Environment produksi + domain + backup.
**Kriteria selesai:**
- [ ] Hosting, database, penyimpanan, dan domain produksi aktif.
- [ ] HTTPS dan konfigurasi DNS benar.
- [ ] Backup harian dan prosedur pemulihan diuji.
- [ ] Rahasia produksi terpisah dari staging.
- [ ] Perkiraan biaya bulanan dicatat.
**Bergantung pada:** DEV-01, OPS-02

<!-- /issue -->

---

## M6 — UAT, Deployment & Pilot

<!-- issue {"key":"QA-05","title":"UAT dan perbaikan bug bersama Cust dan Tenant","milestone":"M6 — UAT, Deployment & Pilot","labels":["type/test","area/qa","priority/p1"],"estimate":8} -->
### QA-05 — UAT dan perbaikan bug bersama Cust dan Tenant

**Tujuan:** Memastikan produk siap dipakai pengguna nyata sebelum rilis.
**Hasil:** Laporan UAT + daftar bug + persetujuan.
**Kriteria selesai:**
- [ ] Skenario UAT per peran disiapkan (alur normal dan kasus gagal).
- [ ] Minimal 5 Cust dan 3 Tenant mengikuti UAT.
- [ ] Keberhasilan tugas, waktu, dan kendala dicatat.
- [ ] Semua bug P0/P1 diperbaiki dan diperiksa ulang.
- [ ] Persetujuan tertulis dari pengelola/PO.
- [ ] Masukan yang tidak menghambat masuk daftar pekerjaan berikutnya.
**Bergantung pada:** QA-03, QA-04, OPS-01

<!-- /issue -->

<!-- issue {"key":"OPS-03","title":"Peluncuran produksi dan verifikasi QRIS live","milestone":"M6 — UAT, Deployment & Pilot","labels":["type/ops","area/ops","priority/p0"],"estimate":3} -->
### OPS-03 — Peluncuran produksi dan verifikasi QRIS live

**Tujuan:** Merilis versi yang sudah lulus UAT ke pengguna nyata.
**Hasil:** Rilis produksi + bukti transaksi live.
**Kriteria selesai:**
- [ ] Rilis dari tag/commit yang sudah lulus UAT.
- [ ] Migrasi produksi dijalankan dengan backup sebelum dan sesudah.
- [ ] Transaksi QRIS live nominal kecil berhasil dari awal sampai akhir.
- [ ] Webhook produksi terverifikasi (bukan tunnel/ngrok).
- [ ] Invoice dan status antrean benar setelah pembayaran live.
- [ ] Rencana pembatalan perubahan diuji dan didokumentasikan.
**Bergantung pada:** QA-05, OPS-01

<!-- /issue -->

<!-- issue {"key":"OPS-04","title":"Pelatihan tenant dan panduan pengguna","milestone":"M6 — UAT, Deployment & Pilot","labels":["type/ops","area/ops","priority/p1"],"estimate":5} -->
### OPS-04 — Pelatihan tenant dan panduan pengguna

**Tujuan:** Tenant dan Cust dapat memakai aplikasi tanpa pendampingan terus-menerus.
**Hasil:** Panduan 1 halaman + sesi pelatihan + poster/FAQ.
**Kriteria selesai:**
- [ ] Panduan mencakup login, antrean, ubah status, produk, omzet, dan pencairan.
- [ ] Pelatihan dilakukan untuk minimal 5 tenant dan mereka mempraktikkan langsung.
- [ ] Kontak bantuan dan jam dukungan jelas.
- [ ] Poster/FAQ Cust ditempatkan di kantin dengan izin.
- [ ] Masukan pelatihan dicatat untuk perbaikan.
**Bergantung pada:** QA-05

<!-- /issue -->

<!-- issue {"key":"OPS-05","title":"Pilot, pemantauan, retrospektif, dan serah terima","milestone":"M6 — UAT, Deployment & Pilot","labels":["type/ops","area/ops","priority/p1"],"estimate":7} -->
### OPS-05 — Pilot, pemantauan, retrospektif, dan serah terima

**Tujuan:** Menguji produk dalam operasi nyata dengan risiko terbatas dan menutup proyek.
**Hasil:** Laporan pilot + keputusan lanjut + retrospektif + serah terima.
**Kriteria selesai:**
- [ ] Pilot dibatasi pada tenant dan pengguna yang disepakati.
- [ ] Metrik harian dipantau: transaksi, keberhasilan pembayaran, bug, dan keluhan.
- [ ] Bug P0/P1 diperbaiki selama pilot dan dicatat dalam changelog.
- [ ] Masukan Cust/Tenant dikumpulkan.
- [ ] Keputusan lanjut/tidak dan alasannya didokumentasikan.
- [ ] Retrospektif, daftar pekerjaan versi 1.1, dan serah terima akses/runbook selesai.
**Bergantung pada:** OPS-03, OPS-04

<!-- /issue -->

# 01 — Rencana Riset dan Wawancara

> Tujuan tahap ini bukan mencari pembenaran bahwa aplikasi pasti dibutuhkan. Tujuan utamanya adalah memahami **cara pembeli dan penjual kantin bekerja saat ini**, masalah yang benar-benar terjadi, dan batasan operasional kantin. Hasil akhir tahap ini adalah **PRD v1 yang disetujui**.

## 1. Pertanyaan yang ingin dijawab

1. Bagaimana mahasiswa dan dosen memesan serta membayar makanan di kantin FT saat ini?
2. Di bagian mana waktu paling banyak terbuang atau kesalahan paling sering terjadi?
3. Bagaimana tenant mencatat pesanan, ketersediaan menu, omzet, dan pencairan dana?
4. Seberapa siap tenant dan pengelola kantin memakai pemesanan digital dan QRIS?
5. Apa yang membuat pembeli atau tenant berhenti memakai aplikasi seperti ini?
6. Apakah fitur pada spesifikasi (daftar tenant, detail, checkout, QRIS, invoice, riwayat, antrean, produk, laporan, pencairan) benar-benar dibutuhkan dalam bentuk yang sama?

## 2. Peserta dan cara mencari

| Kelompok | Kriteria | Target | Cara | Durasi |
| :--- | :--- | :---: | :--- | :---: |
| Cust | Mahasiswa FT semester 1–7 yang membeli di kantin minimal 2 kali dalam 2 minggu terakhir | 12–15 | Wawancara dengan panduan, tetapi bebas menggali | 20–30 menit |
| Cust (dosen/staf) | Pernah membeli di kantin dalam 1 bulan terakhir | 2–3 | Wawancara | 20 menit |
| Tenant | Tenant aktif, jenis makanan/minuman beragam, campuran pengguna QRIS dan tunai | 5–8 | Wawancara dan observasi | 30–40 menit |
| Pengelola kantin | Pengelola operasional kantin FT | 1–2 | Wawancara | 30–45 menit |
| Keuangan/fakultas | Pihak yang mengatur setoran atau bagi hasil, jika berbeda dari pengelola | 1 | Wawancara | 30 menit |

**Cara mencari peserta:** ajak pembeli saat berada di kantin (jam sibuk dan sepi), tawarkan lewat grup WhatsApp angkatan, dan minta bantuan pengelola untuk menghubungi tenant. Beri imbalan kecil jika diizinkan. Jangan hanya mewawancarai teman satu tim karena hasilnya bisa bias.

**Contoh pesan ajakan:**

> Halo, kami mahasiswa RPL yang sedang merancang aplikasi pemesanan kantin FT. Boleh meluangkan 20–30 menit untuk bercerita tentang pengalaman memesan makanan di kantin? Tidak ada jawaban benar atau salah. Data akan dicatat tanpa nama dan hanya dipakai untuk tugas proyek.

## 3. Jadwal riset (1–13 Desember 2026)

| Tanggal | Kegiatan | Hasil |
| :--- | :--- | :--- |
| Sel 1 Des | Rapat pembuka, peta pihak terkait, susun panduan wawancara dan persetujuan | Dokumen tujuan, panduan wawancara |
| Rab 2 Des | Uji coba 1 wawancara per kelompok, perbaiki pertanyaan | Panduan revisi |
| Kam 3–Jum 4 Des | Wawancara Cust 1–4, Tenant 1, observasi jam sibuk | Catatan wawancara tanpa nama |
| Sab 5 Des | Wawancara Cust 5–8, Tenant 2, bandingkan aplikasi sejenis | Catatan dan ringkasan perbandingan |
| Min 6 Des | Rapikan catatan, tinjauan mingguan, susun jadwal W2 | Rencana wawancara minggu 2 |
| Sen 7–Sel 8 Des | Cust 9–15, Tenant 3, wawancara pengelola | Target peserta terpenuhi |
| Rab 9 Des | Tenant 4–5, kelompokkan temuan | Peta masalah |
| Kam 10 Des | Persona, perjalanan pengguna, ruang lingkup, pertanyaan terbuka | Persona dan daftar prioritas |
| Jum 11 Des | Draf PRD dan tinjauan pihak terkait, peta halaman | Draf PRD dan alur |
| Sab 12 Des | Revisi PRD, persetujuan, finalisasi desain awal | PRD disetujui |
| Min 13 Des | **Gerbang M0**: tinjau PRD, mulai Sprint 1 | PRD v1 disetujui |

> Jadwal harian lengkap ada di [`docs/05-execution-plan-2-months.md`](05-execution-plan-2-months.md).

## 4. Etika dan data

- Minta izin sebelum merekam. Jelaskan tujuan, durasi, dan siapa yang akan mendengar rekaman.
- Gunakan kode peserta, misalnya `CUST-03` atau `TENANT-02`. Jangan menulis nama asli di catatan atau laporan.
- Jangan menanyakan data pribadi yang tidak perlu, seperti NIM, nomor HP, atau nomor rekening.
- Simpan rekaman di tempat terbatas. Hapus setelah proyek selesai atau sesuai aturan kampus.
- Hindari pertanyaan yang mengarahkan. Jangan bertanya, “Anda pasti butuh QRIS, kan?” Tanyakan kebiasaan dan kejadian nyata.
- Minta izin sebelum memotret tenant, menu, atau area kantin.

## 5. Panduan wawancara — Cust

**Pembuka (3 menit)**

> Terima kasih sudah meluangkan waktu. Kami sedang mempelajari pengalaman makan di kantin FT, bukan menguji Anda. Tidak ada jawaban benar atau salah. Kami akan mencatat poin penting. Boleh kami merekam agar tidak ada yang terlewat? Nama Anda akan diganti dengan kode.

**Pemanasan**

1. Seberapa sering Anda makan di kantin FT dalam seminggu? Biasanya jam berapa?
2. Biasanya sendiri, bersama teman, atau memesan untuk orang lain?

**Kebiasaan saat ini (minta cerita nyata, bukan pendapat umum)**

3. Ceritakan kunjungan terakhir Anda ke kantin, dari sebelum berangkat sampai selesai makan.
4. Langkah apa saja yang harus dilakukan untuk mendapatkan makanan? Berapa lama setiap langkah?
5. Bagian mana yang paling melelahkan atau menjengkelkan? Ceritakan kejadiannya.
6. Bagaimana Anda mengetahui menu dan harga yang tersedia? Pernah batal membeli karena informasi tidak jelas?
7. Bagaimana Anda membayar? Tunai, QRIS, atau e-wallet? Mengapa memilih cara itu?
8. Pernah mengalami antrean panjang? Jam berapa? Apa yang Anda lakukan?
9. Jika memesan untuk beberapa orang, bagaimana caranya? Dari satu tenant atau berpindah-pindah?
10. Pernah memakai layanan pesan-antar atau aplikasi kantin lain? Apa yang bagus dan apa yang buruk?
11. Saat pesanan sedang dibuat, apakah Anda ingin tahu statusnya? Mengapa?
12. Apakah Anda menyimpan struk atau riwayat pembelian? Untuk keperluan apa?
13. Apa kekhawatiran Anda jika memesan lewat aplikasi (biaya tambahan, data pribadi, pesanan salah)?
14. Jika hanya boleh ada satu fitur wajib, apa itu? Mengapa?

**Uji konsep (setelah membahas kebiasaan saat ini)**

15. Tunjukkan alur kasar: pilih tenant → pilih menu → keranjang → checkout → QRIS → invoice. Bagian mana yang membingungkan? Bagian mana yang tidak Anda butuhkan?
16. Apakah Anda bersedia membayar dengan QRIS di aplikasi? Apa yang membuat Anda ragu?

**Penutup**

17. Ada hal lain yang penting tetapi belum kami tanyakan?
18. Boleh kami hubungi lagi jika ada pertanyaan lanjutan?

> Jangan menanyakan “Apakah Anda mau fitur X?” sebelum menggali masalah. Fitur yang disebut tanpa bukti harus ditandai sebagai asumsi.

## 6. Panduan wawancara — Tenant

1. Ceritakan alur menerima dan menyiapkan pesanan pada jam sibuk.
2. Bagaimana pesanan dicatat sekarang (kertas, ingatan, chat, kasir)? Pernah salah catat atau pesanan hilang? Ceritakan.
3. Berapa pesanan per hari? Menu apa yang paling laris? Jam berapa paling sibuk?
4. Bagaimana Anda mengetahui menu habis? Siapa yang memperbarui informasi itu?
5. Bagaimana pembeli membayar? Siapa memiliki akun QRIS? Dana masuk ke rekening siapa?
6. Bagaimana Anda mencatat omzet harian? Kapan, oleh siapa, dan seberapa akurat?
7. Bagaimana proses setoran atau pencairan ke kantin/fakultas? Berapa lama dan ada potongan apa?
8. Perangkat apa yang tersedia untuk menerima pesanan (HP, tablet, printer)? Bagaimana koneksi internetnya?
9. Apa yang terjadi jika internet mati atau aplikasi lambat? Bagaimana Anda tetap melayani pembeli?
10. Apa yang membuat Anda mau mencoba aplikasi ini? Apa yang membuat Anda berhenti?
11. Laporan apa yang paling berguna: omzet hari ini, jumlah pesanan, menu terlaris, atau status pencairan?
12. Tunjukkan alur tenant pada konsep: antrean pesanan, kelola produk, laporan, dan pencairan. Bagian mana yang tidak sesuai dengan cara kerja Anda?

**Saat observasi:** perhatikan cara pesanan diserahkan, apakah ada nomor pesanan, bagaimana pembeli dipanggil, dan bagaimana tenant menandai pesanan selesai.

## 7. Panduan wawancara — Pengelola kantin dan keuangan

1. Apa peran dan tanggung jawab Anda terkait kantin?
2. Aturan apa yang berlaku untuk tenant (jam buka, menu, harga, kebersihan, bagi hasil)?
3. Bagaimana alur uang dari pembeli ke tenant saat ini? Siapa yang memegang dana dan kapan disalurkan?
4. Apakah kantin atau fakultas memiliki kebijakan QRIS, pajak, atau biaya layanan?
5. Data atau laporan apa yang Anda butuhkan untuk memantau kantin?
6. Bagaimana kesiapan infrastruktur (WiFi, listrik, perangkat, SDM)?
7. Siapa yang akan membantu tenant jika aplikasi bermasalah?
8. Risiko apa yang paling Anda khawatirkan (kecurangan, pesanan fiktif, dana tidak cair, data bocor)?

## 8. Daftar observasi lapangan

Lakukan minimal **2 sesi jam sibuk** dan **1 sesi jam sepi**.

| Yang diamati | Cara mencatat |
| :--- | :--- |
| Panjang antrean dan waktu tunggu | Hitung jumlah orang dan waktu dari datang sampai pesanan diterima |
| Urutan proses | Datang → lihat menu → pesan → bayar → tunggu → terima |
| Cara tenant mencatat pesanan | Foto atau catatan (dengan izin), catat alat yang dipakai |
| Metode pembayaran | Hitung perbandingan tunai dan QRIS/e-wallet |
| Penyerahan pesanan | Apakah ada nomor antrean? Bagaimana pembeli dipanggil? |
| Menu habis | Bagaimana informasi disampaikan? Apakah menu masih dipajang? |
| Pencatatan omzet | Kapan dilakukan? Manual atau aplikasi? |
| Kendala perangkat | HP/tablet, baterai, internet, printer |

## 9. Perbandingan aplikasi sejenis

Pilih 3–5 pembanding, misalnya aplikasi pesan-antar makanan, aplikasi kantin kampus, dan QRIS statis. Bandingkan:

- Alur pemesanan dan jumlah langkah
- Dukungan satu tenant atau banyak tenant
- Metode pembayaran dan status transaksi
- Kejelasan status pesanan dan notifikasi
- Biaya layanan, biaya QRIS, dan proses pencairan
- Keharusan membuat akun dan data yang diminta

Tulis **apa yang relevan** dan **apa yang sengaja tidak ditiru**, misalnya fitur pengantaran atau promo yang berada di luar ruang lingkup.

## 10. Merangkum hasil

1. **Kelompokkan catatan berdasarkan tema:** antrean, informasi menu, pembayaran, status pesanan, pencatatan tenant, dan pencairan.
2. **Nilai masalah:** letakkan masalah pada tabel berdasarkan seberapa sering terjadi dan seberapa besar dampaknya. Utamakan masalah yang sering dan berdampak besar.
3. **Tulis kebutuhan pengguna:** “Ketika ___, saya ingin ___, supaya ___.”
4. **Buat peta perjalanan pengguna:** Cust (sebelum ke kantin → pesan → bayar → tunggu → terima → riwayat) dan Tenant (terima pesanan → siapkan → serahkan → catat omzet → cairkan).
5. **Hubungkan bukti dengan fitur:** setiap fitur di PRD harus punya bukti dari riset atau ditandai sebagai asumsi yang perlu dipastikan.

## 11. Pertanyaan yang wajib diputuskan

| # | Pertanyaan | Asumsi awal | Dampak jika salah | Cara memastikan |
| :---: | :--- | :--- | :--- | :--- |
| 1 | Apakah satu checkout hanya untuk satu tenant? | Ya, keranjang per tenant | Struktur pesanan, pembayaran, antrean tenant | Wawancara Cust dan Tenant, PRD |
| 2 | Apakah Cust wajib membuat akun? | Ya, minimal email/HP dan kata sandi | Proses daftar, login, riwayat | Wawancara, kebijakan fakultas |
| 3 | Apakah Tenant mengelola produk sendiri? | Ya, karena tidak ada admin | Hak akses, pekerjaan operasional | Wawancara Tenant dan pengelola |
| 4 | Apakah ada refund atau pembatalan? | Tidak pada versi pertama; hanya kedaluwarsa/gagal | Status pesanan, dukungan pengguna | Pengelola dan keuangan |
| 5 | Siapa menanggung biaya QRIS? | Platform/kantin, tidak menambah harga pembeli | Harga, laporan, margin tenant | Pengelola dan penyedia QRIS |
| 6 | Pencairan otomatis atau manual? | Buku besar internal dan transfer manual pada versi pertama | Laporan, proses operasional, pencocokan data | Keuangan/fakultas |
| 7 | Status pesanan apa yang dipakai? | Menunggu bayar → Dibayar → Diproses → Selesai; ditambah Kedaluwarsa/Gagal | Tampilan antrean, laporan, notifikasi | Wawancara Tenant |
| 8 | Bagaimana menandai tenant sedang berjualan? | Tombol buka/tutup manual oleh Tenant | Daftar tenant, validasi checkout | Wawancara Tenant |
| 9 | Boleh satu akun memiliki dua peran? | Tidak pada versi pertama | Struktur pengguna, navigasi | Wawancara, PRD |
| 10 | Apakah perlu notifikasi? | Tidak pada versi pertama; cukup cek status berkala | Ruang lingkup, biaya, infrastruktur | Wawancara dan pengelola |
| 11 | Berapa lama data transaksi disimpan? | 1 tahun, tanpa data pembayaran sensitif | Privasi, biaya penyimpanan | Kebijakan fakultas |
| 12 | Perangkat utama Tenant? | Browser di HP/tablet | Desain responsif, ukuran layar | Observasi dan wawancara |

**Aturan:** pertanyaan tidak boleh dibiarkan menggantung saat coding dimulai. Pilih satu keputusan, catat di PRD/ADR, dan tentukan tanggal peninjauan.

## 12. Syarat selesai tahap riset

> Gunakan [`docs/prd-template.md`](prd-template.md) sebagai kerangka PRD.

- [ ] Minimal 15 Cust, 5 Tenant, dan 1 pengelola/keuangan diwawancarai.
- [ ] Observasi jam sibuk dan sepi selesai, minimal 3 sesi.
- [ ] 5 masalah utama memiliki bukti kutipan atau observasi, bukan asumsi.
- [ ] Persona dan peta perjalanan Cust serta Tenant selesai.
- [ ] Semua pertanyaan di §11 sudah diputuskan atau memiliki penanggung jawab dan tenggat.
- [ ] PRD v1 memuat alur, status pesanan, kebutuhan fungsional/non-fungsional, dan hal di luar ruang lingkup.
- [ ] PRD direview dan disetujui pengelola/dosen pembimbing.
- [ ] Daftar pekerjaan GitHub diperbarui sesuai temuan.

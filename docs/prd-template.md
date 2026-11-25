# PRD — FT Food

> Template. Isi setelah riset selesai, review bersama pihak terkait, lalu ubah status menjadi **Approved**. PRD menjadi acuan utama untuk desain, pengembangan, dan pengujian.

## 1. Informasi dokumen

| Item | Isi |
| :--- | :--- |
| Versi | 0.1 |
| Tanggal | |
| Pemilik | |
| Reviewer | |
| Status | Draft / In Review / **Approved** |
| Tautan riset | `research/synthesis/...` |
| Tautan desain | Figma |
| Tautan kontrak API | `openapi.yaml` |

## 2. Masalah yang ingin diselesaikan

<!-- Tulis 2–4 kalimat berdasarkan bukti riset. Sertakan kutipan tanpa nama. -->

## 3. Tujuan dan hal yang tidak termasuk

**Tujuan**

- 

**Tidak termasuk pada versi pertama**

- 

**Ukuran keberhasilan**

| Ukuran | Kondisi awal | Target | Cara mengukur |
| :--- | :---: | :---: | :--- |
| | | | |

## 4. Pengguna utama dan perjalanannya

- Pengguna utama Cust:
- Pengguna utama Tenant:
- Peta perjalanan: `research/synthesis/journey-*.png`

## 5. Ruang lingkup dan prioritas

| Fitur | Prioritas | Alasan | Issue |
| :--- | :---: | :--- | :--- |
| Daftar tenant | Wajib | | |
| Detail tenant dan keranjang | Wajib | | |
| Checkout dan QRIS | Wajib | | |
| Invoice | Wajib | | |
| Riwayat pemesanan | Wajib | | |
| Antrean pesanan | Wajib | | |
| Produk | Wajib | | |
| Laporan dan pencairan | Wajib | | |

**Tidak dikerjakan pada versi pertama:** ...

## 6. Peran dan hak akses

| Aksi | Cust | Tenant | Catatan |
| :--- | :---: | :---: | :--- |
| Melihat tenant aktif | Ya | — | |
| Melihat produk tenant | Ya | Ya | |
| Checkout | Ya | — | |
| Melihat antrean | — | Ya | Hanya tenant sendiri |
| Mengubah status pesanan | — | Ya | Hanya perpindahan yang valid |
| Mengelola produk | — | Ya | |
| Melihat omzet/pencairan | — | Ya | Hanya tenant sendiri |
| Melihat riwayat | Ya | — | Hanya milik sendiri |

## 7. Alur utama

### 7.1 Cust

1. Login.
2. Melihat daftar tenant yang sedang berjualan.
3. Membuka detail tenant, menekan `+`, lalu masuk ke keranjang.
4. Checkout dan pesanan dibuat.
5. Membayar dengan QRIS dan status diperbarui.
6. Melihat invoice.
7. Melihat riwayat pemesanan.

**Kondisi khusus:** tenant tutup, produk habis, QR kedaluwarsa, pembayaran gagal, coba ulang, dan koneksi terputus.

### 7.2 Tenant

1. Login dan membuka dashboard.
2. Melihat antrean pesanan yang sudah dibayar.
3. Memproses pesanan, lalu menandainya selesai.
4. Mengelola produk dan ketersediaan.
5. Melihat omzet hari ini dan pencairan.

**Kondisi khusus:** tidak ada pesanan, produk habis, koneksi lambat, dan perubahan status gagal.

## 8. Kebutuhan fungsional

| ID | Kebutuhan | Peran | Prioritas | Kriteria selesai |
| :--- | :--- | :--- | :---: | :--- |
| FR-01 | Menampilkan tenant yang sedang berjualan | Cust | Wajib | Hanya tenant buka; ada tampilan kosong/error |
| FR-02 | Menampilkan menu tenant | Cust | Wajib | Produk aktif; harga benar |
| FR-03 | Menambah menu ke keranjang | Cust | Wajib | Jumlah, subtotal, dan batas jumlah |
| FR-04 | Checkout | Cust | Wajib | Harga dihitung server; pesanan unik |
| FR-05 | Pembayaran QRIS | Cust | Wajib | QR tampil; status diperbarui |
| FR-06 | Invoice | Cust | Wajib | Hanya setelah dibayar; akses terbatas |
| FR-07 | Riwayat pemesanan | Cust | Wajib | Hanya milik sendiri; ada detail |
| FR-08 | Antrean pesanan | Tenant | Wajib | Hanya pesanan tenant; urut waktu |
| FR-09 | Mengubah status pesanan | Tenant | Wajib | Hanya perpindahan valid; bisa dibatalkan jika gagal |
| FR-10 | Mengelola produk | Tenant | Wajib | Tambah/ubah/arsip; ada validasi |
| FR-11 | Ketersediaan produk | Tenant | Wajib | Perubahan langsung terlihat oleh Cust |
| FR-12 | Laporan omzet hari ini | Tenant | Wajib | Pesanan dibayar/selesai; zona Asia/Jakarta |
| FR-13 | Pencairan | Tenant | Wajib | Status dan riwayat; memakai buku besar |

## 9. Status pesanan

| Dari | Kejadian | Menjadi | Pelaku | Syarat |
| :--- | :--- | :--- | :--- | :--- |
| — | Checkout | MENUNGGU_PEMBAYARAN | Cust | Ketersediaan dan tenant valid |
| MENUNGGU_PEMBAYARAN | Webhook sukses | DIBAYAR | Sistem | Tanda tangan valid, nominal cocok |
| MENUNGGU_PEMBAYARAN | Kedaluwarsa | KEDALUWARSA | Sistem | Melewati waktu kedaluwarsa |
| MENUNGGU_PEMBAYARAN | Gagal | GAGAL | Sistem | Penyedia pembayaran menolak |
| DIBAYAR | Proses | DIPROSES | Tenant | Pemilik tenant |
| DIPROSES | Selesai | SELESAI | Tenant | Pemilik tenant |

**Aturan coba ulang:** ...

## 10. Data dan aturan bisnis

- Satu pesanan hanya untuk satu tenant.
- Harga disimpan sebagai bilangan bulat Rupiah, tanpa desimal.
- Nama dan harga produk disalin ke item pesanan saat checkout.
- Tampilan memakai zona waktu Asia/Jakarta; penyimpanan memakai UTC.
- Pencairan memakai buku besar internal dan transfer manual pada versi pertama.
- Biaya QRIS: ...
- Lama penyimpanan data: ...

## 11. Kebutuhan non-fungsional

| Aspek | Target |
| :--- | :--- |
| Kecepatan | p95 API < 1 detik; halaman < 2 detik |
| Ketersediaan | ... |
| Keamanan | Hak akses per peran, validasi input, pembatasan request, penyimpanan rahasia |
| Aksesibilitas | WCAG AA, ukuran tombol minimal 44px |
| Perangkat | HP 360px, tablet, desktop; Chrome/Safari/Firefox |
| Pemantauan | ID permintaan, pencatatan error, peringatan pembayaran |

## 12. Tampilan kosong, error, dan memuat

| Layar | Kosong | Error | Memuat |
| :--- | :--- | :--- | :--- |
| Daftar tenant | | | |
| Detail tenant | | | |
| Keranjang | | | |
| QRIS | | | |
| Riwayat | | | |
| Antrean | | | |
| Produk | | | |
| Laporan | | | |

## 13. Metrik dan data penggunaan

<!-- Catat hanya kejadian yang diperlukan. Jangan menambah pelacakan tanpa tujuan. -->

| Kejadian | Data | Tujuan |
| :--- | :--- | :--- |
| | | |

## 14. Keputusan dan pertanyaan terbuka

| # | Pertanyaan | Keputusan | Penanggung jawab | Tanggal |
| :---: | :--- | :--- | :--- | :--- |
| 1 | | | | |

## 15. Syarat rilis

- [ ] Semua kebutuhan wajib memiliki kriteria selesai dan lulus UAT.
- [ ] Tidak ada bug P0/P1 yang terbuka.
- [ ] QRIS live nominal kecil berhasil dari awal sampai akhir.
- [ ] Pemeriksaan keamanan tidak menemukan masalah Critical/High.
- [ ] Panduan operasional, backup, dan pemantauan aktif.
- [ ] Tenant sudah dilatih; materi untuk Cust tersedia.

## 16. Di luar ruang lingkup versi pertama

- 

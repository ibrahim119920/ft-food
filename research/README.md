# Riset — Penyimpanan Data

Folder ini menyimpan **panduan dan ringkasan** riset yang boleh masuk ke repository. Data mentah peserta **tidak boleh di-commit**.

## Struktur

```
research/
├── README.md              # aturan ini
├── instruments/           # panduan wawancara, lembar persetujuan, kuesioner (boleh di-commit)
├── notes/                 # catatan mentah (diabaikan Git)
├── transcripts/           # transkrip (diabaikan Git)
├── recordings/            # rekaman audio/video (diabaikan Git)
└── synthesis/             # kelompok temuan, persona, peta perjalanan (boleh di-commit, tanpa nama)
```

## Aturan

1. Gunakan kode peserta: `CUST-01`, `TENANT-02`, `MGMT-01`. Jangan menulis nama, NIM, atau nomor HP.
2. Minta persetujuan sebelum merekam. Jelaskan tujuan dan siapa yang akan mendengar rekaman.
3. Simpan data mentah hanya di perangkat tim yang disepakati, bukan di repository publik.
4. Hapus rekaman setelah transkrip diperiksa dan proyek selesai, kecuali disepakati lain.
5. Kutipan di PRD atau issue harus tanpa nama dan tidak dapat melacak identitas.
6. Jangan memotret orang tanpa izin. Foto menu atau tenant hanya dengan izin pemilik.

## Format catatan

`notes/CUST-01_2026-12-02.md`

```markdown
# CUST-01

- Tanggal/jam:
- Lokasi:
- Cara bayar saat ini:
- Durasi:

## Ringkasan
...

## Kutipan penting
> "..."
```

## Setelah wawancara

- Isi catatan dalam 24 jam agar detail tidak hilang.
- Tandai kutipan yang dapat dipakai di PRD.
- Pindahkan temuan, bukan data mentah, ke folder `synthesis/`.

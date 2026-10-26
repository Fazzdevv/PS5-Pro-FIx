# PS5 Pro-Fix Standalone Payload Daemon (`pro_fix.elf`)

Payload mandiri (*standalone ELF*) untuk PlayStation 5 (Prospero) yang berfungsi memantau jalannya game secara otomatis di background dan melakukan *in-memory patching* pada instruksi GPU trap PS5 Pro (`s_trap 1` -> `s_nop 0`).

**Tidak memerlukan etaHEN** dan kompatibel penuh dengan **`itsPLK/ps5-payload-manager`** serta muncul di menu **Active Processes**.

---

## 🚀 Fitur Utama
1. **Muncul di Active Processes:** Berjalan sebagai daemon proses independen (`pro_fix.elf`), dapat dipantau statusnya dan dimatikan (*kill/terminate*) kapan saja lewat dashboard Payload Manager.
2. **Unlock Opsi Grafis PS5 Pro (In-Memory):** Mem-bypass deteksi hardware profile di engine Remedy Northlight (`0x376f720`) langsung di RAM sehingga opsi grafis PS5 Pro lengkap (**Quality**, **Performance**, dan mode eksklusif Pro **Balanced**) langsung terbuka di menu grafis tanpa mengubah file PKG di SSD (pada Base PS5 hanya tersedia Quality dan Performance).
3. **Notifikasi Layar TV (On-Screen Pop-ups):** Mengirimkan notifikasi langsung ke layar PS5:
   * **Saat Aktif:** *"PS5 Pro-Fix Daemon Active! Monitoring games in background..."*
   * **Saat Game Di-patch:** *"PS5 Pro-Fix [Title ID]: Pro Mode Unlocked! Patched X GPU traps."*
   * **Saat Game Selesai:** *"PS5 Pro-Fix [Title ID]: Game closed. Resuming background monitor..."*
4. **Dynamic In-Memory Patching:** Mengganti pola instruksi `01 00 92 bf` (`s_trap 1`) menjadi `00 00 80 bf` (`s_nop 0`) hanya pada segmen GPU shader tanpa menyentuh kode CPU x86_64.
5. **Auto-Pause Saat Gameplay (0.0% CPU):** Begitu game selesai di-patch, payload otomatis masuk ke mode **PAUSE / DEEP SLEEP** (memeriksa status proses tiap 3 detik tanpa scan memori) agar game mendapat 100% performa CPU penuh.
6. **Auto-Resume Saat Game Ditutup:** Saat keluar dari game ke dashboard PS5, payload otomatis bangun (*resume*) dan kembali memonitor game berikutnya.

---

## 📦 Cara Memasang di `itsPLK/ps5-payload-manager`

1. **Buka Web Dashboard Payload Manager:**
   * Buka browser di PC/HP atau langsung dari PS5.
   * Masuk ke dashboard IP PS5 kamu.
2. **Upload Payload:**
   * Masuk ke menu **Payloads** -> **Upload**.
   * Upload file [pro_fix.elf](file:///home/fazzdev/project/fpkg-gui-0.6.10/bakport/pro_fix.elf).
3. **Jalankan / Autoload:**
   * Klik tombol **Launch / Run** (dan aktifkan centang **Autoload** jika ingin jalan otomatis tiap jailbreak).
   * Pada layar TV PS5 akan langsung muncul pop-up notifikasi: *"PS5 Pro-Fix Daemon Active!"*.
   * Cek tab **Active Processes** di Payload Manager, kamu akan melihat `pro_fix.elf` aktif berjalan.
4. **Mainkan Game:**
   * Buka game yang diinginkan. Pop-up notifikasi akan muncul memberitahukan jumlah GPU trap yang berhasil di-patch!

---

## 🛠️ Cara Re-Compile (Jika Ingin Modifikasi)
Jika kamu ingin mengubah kode sumber di [pro_fix.c](file:///home/fazzdev/project/fpkg-gui-0.6.10/bakport/pro_fix.c):
```bash
cd /home/fazzdev/project/fpkg-gui-0.6.10/bakport
./build.sh
```
Binary baru akan otomatis terkompilasi menggunakan official `ps5-payload-sdk` ke `pro_fix.elf`.

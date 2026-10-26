# PS5 Pro-Fix Standalone Payload Daemon (`pro_fix.elf`)
**Version:** `v0.1.0`  
**Author:** Fazzdevv  

A standalone ELF payload daemon for the PlayStation 5 (Prospero) designed specifically for **PS5 PRO** hardware (CFI-7000 / SoC Trinity). It automatically monitors running games in the background and dynamically applies in-memory patches to enable PS5 Pro graphics features and neutralize AMD RDNA GPU shader traps without modifying or re-downloading installed PKG files.

---

## 🎮 Tested Environment & Verified Games
* **Console:** PlayStation 5 Pro (CFI-7000 / SoC Trinity)
* **Firmware:** **9.40**

### Verified Working Games:
1. **Control Resonant (`PPSA34547`, v01.300.300)** — *Remedy Northlight Engine*:
   * **Result:** 100% Working — 164 GPU shader traps patched. All PS5 Pro graphics options (**Quality**, **Performance**, and the Pro-exclusive **Balanced** mode, where Base PS5 only features Quality and Performance) fully unlocked and playable without crashes.
2. **Black Myth: Wukong** — *Unreal Engine 5*:
   * **Result:** 100% Working — 2 GPU shader traps cleanly patched. All **4 graphics presets / options** successfully appeared and gameplay runs completely smooth without any crashes.

---

## 🚀 Key Features

1. **In-Memory PS5 Pro Graphics Options Unlock:**
   * Bypasses the game engine's internal hardware profile check (`0x376f720` in Remedy Northlight) directly in RAM.
   * Forces Hardware Profile Mode `2` (PS5 Pro Mode), immediately revealing the full graphics mode selection (**Quality**, **Performance**, and the Pro-exclusive **Balanced** mode) along with Pro enhancements in the game's display settings (base PS5 only supports Quality and Performance).
   * Completely eliminates the need to unpack, patch, and repack massive 50+ GB PKG files.

2. **Airtight GPU Shader Trap Neutralization (`s_trap 1` -> `s_nop 0`):**
   * Games built with Pro SDK features include AMD RDNA shader trap assertions (`01 00 92 bf`) guarded by SOPP conditional branch instructions (`s_cbranch 1`).
   * When executed on PS5 Pro hardware with backported packages, these traps trigger immediate GPU faults when entering 3D levels.
   * The daemon scans shader segments (`>= 0x04000000`) and safely replaces all trap instructions with `s_nop 0` (`00 00 80 bf`) with zero false positives. CPU instructions (`x86_64`) are never touched.

3. **Zero CPU Overhead (0.0% CPU During Gameplay):**
   * Once the game process is patched, the daemon enters an ultra-light deep sleep loop (checking process liveness every 3 seconds) ensuring 100% of CPU and GPU resources remain dedicated to the game.

4. **On-Screen PS5 TV Notifications:**
   * Sends real-time pop-up notifications directly to the PS5 screen:
     * Daemon startup: *"PS5 Pro-Fix Daemon Active! Monitoring games in background..."*
     * Patch applied: *"PS5 Pro-Fix [Title ID]: Pro Mode Unlocked! Patched X GPU traps."*
     * Game exit: *"PS5 Pro-Fix [Title ID]: Game closed. Resuming background monitor..."*

---

## ⚠️ Known Limitations & Weaknesses

Please be aware of the following known behaviors in version `0.1.0`:

1. **Cannot Be Killed via Web UI (Process Not Visible):**
   * The daemon process currently **does not show up in the `Active Processes` list** within web-based payload managers (such as `itsPLK/ps5-payload-manager`).
   * Because it does not appear in the active process table, it cannot be stopped or terminated via the manager's "Kill" button.
2. **Console Reboot Required to Terminate:**
   * If you want to stop, unload, or restart the payload daemon, you must **restart / reboot the PS5 console**.
   * Note: The daemon consumes negligible memory (~120 KB) and 0% CPU during active gameplay, so leaving it running in the background until the next reboot causes no performance penalty.

---

## 📦 Installation & Usage

1. **Prerequisites:**
   * Jailbroken PS5 Pro (Firmware 9.40 tested).
   * A payload loader such as `ps5-elfldr` or `itsPLK/ps5-payload-manager`.

2. **Loading the Payload:**
   * Open your PS5 Payload Manager dashboard in a web browser.
   * Upload [pro_fix.elf](file:///home/fazzdev/project/fpkg-gui-0.6.10/bakport/pro_fix.elf).
   * Click **Launch / Run**.
   * Verify the on-screen TV notification: *"PS5 Pro-Fix Daemon Active!"*.

3. **Play:**
   * Launch your backported game (e.g., *Control Resonant*).
   * A notification will confirm that Pro mode and GPU traps have been patched.
   * Head into the game's **Display / Graphics Options** menu to enjoy PS5 Pro enhancements!

---

## 🛠️ Building from Source

This payload is built with the official [ps5-payload-sdk](https://github.com/ps5-payload-dev/ps5-payload-sdk) by John Törnblom.

```bash
cd bakport
./build.sh
```

The script compiles position-independent executable code (`prospero-clang -Wall -O2`) producing a clean 16KB-aligned `pro_fix.elf`.

---

## 📜 License
MIT License. Free for educational and reverse-engineering research purposes on jailbroken PlayStation 5 systems.

![Pick123](icon.png)

[中文](./README.md) |
[English](./README_EN.md)

# Pick123_inputMethod

A Windows Chinese input method built on the 小狼毫 (Weasel / RIME) engine.

> This version shows as "小狼毫 / Weasel" in the system language bar / keyboard
> list (internal name) for technical compatibility. **Pick123** is the product
> name used for release, docs, and recognition; a future version will rename the
> UI strings to Pick123.

Features
--------
- **Three-colour grouping**: press the trigger key to enter, `1/2/3` to choose a
  group, then `1/2/3` to choose a candidate, and it auto-returns to normal mode.
- **Slider mode**: the three colour slots stay fixed at the front; the trigger
  key slides the whole row left, the reverse key slides it right, and `1/2/3`
  selects the pressed word directly.
- **Fully customisable**: trigger key, selection keys (1/2/3), the three colours,
  and the slider reverse key — all adjustable in the control panel, apply
  immediately.
- **Cross-page candidates**: automatically pages when there are many candidates.

Installation
------------
1. Extract this archive to a folder without Chinese characters/spaces (e.g. `D:\Pick123`).
2. Right-click `install.bat` and choose "Run as administrator".
   (If you don't run it as admin it will prompt the UAC dialog automatically.)
   The script then does three steps automatically:
   - (a) `WeaselDeployer /install` — deploy Rime data to `%APPDATA%\Rime`;
   - (b) `WeaselSetupx64 /s` — register the IME into the keyboard layout / language bar;
   - (c) start the `WeaselServer` service.
   Wait for the script to print "install finished".
3. Log out / reboot once so Windows loads the newly-registered IME DLL.
4. Add Pick123 to the language bar:
   - Windows 11: Settings -> Time & Language -> Language & region -> your language
     -> ... -> Language options -> Add a keyboard.
   - Windows 10: Settings -> Time & Language -> Language -> Chinese (Simplified)
     -> Options -> Add a keyboard.
   Choose "小狼毫 / Weasel" in the list.
5. Switch to Pick123 with `Ctrl+Space` or `Win+Space` and start typing.

Usage
-----
- Click the「小狼毫」tray icon to open the settings menu.
- The three-colour / slider toggle, trigger key, colours, `1/2/3` keys and
  reverse key are all in the "input method settings" window; save to apply.

Notes
-----
- You must log out / reboot once after install, or the new DLL won't load and the
  language bar may not show it.
- If Pick123 doesn't appear in the language bar, run `install.bat` again.
- This app writes system registry (HKLM) to register the IME; install as admin.
- Uninstall:
  - Removing the folder alone does not remove the IME from the language bar.
  - To fully remove, run `WeaselSetupx64.exe /u` (from this folder), then delete
    this folder, and optionally clean `%APPDATA%\Rime`.

Troubleshooting
---------------
- Install failed / no candidates: check `install.log` in this folder.
- No candidates out: confirm you logged out / rebooted and `WeaselServer.exe` is running.
- Full reset: delete `%APPDATA%\Rime` and re-run `install.bat`.
- "cannot find xx.dll": ensure the zip was fully extracted, not just a single exe.

Contributors
============

Open-source projects used
-------------------------
This project is built on the following open-source projects. Thanks to their
authors and communities:
- **RIME / 中州韵 input method engine** — https://rime.im (librime; input engine and candidate logic)
- **小狼毫 Weasel** — https://github.com/rime/weasel (Windows IM framework, TSF, candidate window)
- **Boost C++ Libraries** — https://www.boost.org (boost serialization / data structures)
- **7-Zip** — https://www.7-zip.org (packing / extraction)
- **cURL** — https://curl.se (download / network support)
- **WinSparkle** — https://winsparkle.org (auto-update)

Development & build tools
-------------------------
This project was assisted in development and build by **DeepSeek Harness**
(deepseek-harness), including the code implementation and debugging of the
three-colour grouping, slider mode, cross-page candidates and control panel.

Douyin (TikTok) user ideas
--------------------------
The following Douyin users contributed ideas for this project's Windows version:
- Thanks to @陈晨, @zeeshee, @暮水 for suggesting new name references for the Windows version;
- Thanks to @lvs, @禾O看世界, @林青衣, @风渐渐 for the slider-mode idea;
- Thanks to @1fei for suggesting customised digit-mapping keys;
- Thanks to @在下雨 for suggesting custom three-colour customisation;
- Thanks to @McFlurry for suggesting making the secondary menu look cleaner.

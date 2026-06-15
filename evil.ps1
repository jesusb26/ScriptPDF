# evil.ps1 - Script remoto que se ejecuta en la víctima
Write-Host "Ejecutando payload malicioso en memoria..." -ForegroundColor Red
Start-Sleep -Seconds 2

# Verificar si se ejecuta como administrador (para la demo)
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show('¡Sistema comprometido con permisos de administrador!', 'Alerta de Seguridad')
} else {
    Write-Host "ADVERTENCIA: No se tienen permisos de administrador." -ForegroundColor Yellow
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show('Ejecutando sin permisos de administrador', 'Alerta de Seguridad')
}

# Crear archivo de prueba en el escritorio
$desktopPath = [Environment]::GetFolderPath("Desktop")
$proofFile = "$desktopPath\PRUEBA_EJECUCION.txt"
$fecha = Get-Date
"Payload ejecutado el $fecha" | Out-File -FilePath $proofFile
Write-Host "Archivo de prueba creado en: $proofFile" -ForegroundColor Green

# evil.ps1
Write-Host "Ejecutando payload malicioso en memoria..." -ForegroundColor Red
Start-Sleep -Seconds 2

# Opción B activada
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show('¡Sistema comprometido!', 'Alerta de Seguridad')

# El archivo de prueba también se creará
$desktopPath = [Environment]::GetFolderPath("Desktop")
$proofFile = "$desktopPath\PRUEBA_EJECUCION.txt"
"Este archivo confirma que el payload se ejecutó correctamente." | Out-File -FilePath $proofFile
Write-Host "Archivo de prueba creado en: $proofFile" -ForegroundColor Green

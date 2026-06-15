# evil.ps1 - Script que se ejecutará en la memoria de la máquina víctima
Write-Host "Ejecutando payload malicioso en memoria..." -ForegroundColor Red
Start-Sleep -Seconds 2

# Acción para demostrar la intrusión (descomenta la que prefieras)
# Opción A: Abre el Bloc de Notas como administrador
# Start-Process notepad.exe -Verb RunAs

# Opción B: Muestra un mensaje en pantalla
# Add-Type -AssemblyName System.Windows.Forms
# [System.Windows.Forms.MessageBox]::Show('¡Sistema comprometido!', 'Alerta de Seguridad')

# Opción C: Ejecuta una calculadora (prueba silenciosa)
# Start-Process calc.exe

# En este ejemplo, simplemente creará un archivo en el escritorio como prueba.
$desktopPath = [Environment]::GetFolderPath("Desktop")
$proofFile = "$desktopPath\PRUEBA_EJECUCION.txt"
"Este archivo confirma que el payload se ejecutó correctamente." | Out-File -FilePath $proofFile
Write-Host "Archivo de prueba creado en: $proofFile" -ForegroundColor Green
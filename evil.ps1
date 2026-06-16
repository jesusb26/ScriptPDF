# evil.ps1 - Versión mejorada para demostración
Add-Type -AssemblyName System.Windows.Forms

# Mostrar mensaje de alerta
[System.Windows.Forms.MessageBox]::Show('Ejecutando payload desde PDF... Sistema comprometido!', 'Alerta de Seguridad')

# Crear archivo de prueba en el escritorio
$desktop = [Environment]::GetFolderPath("Desktop")
$file = "$desktop\COMPROMETIDO.txt"
"El sistema fue comprometido el $(Get-Date)" | Out-File $file

# Abrir el bloc de notas con el archivo (evidencia visual)
Start-Process notepad.exe $file

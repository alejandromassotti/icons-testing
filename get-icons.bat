@echo off
setlocal

:: CONFIGURACIÓN DE RUTAS
:: Origen: Ajusta esto si la ruta real varía. 
:: Nota: Resolvemos la ruta absoluta para evitar errores de cálculo.
set "ORIGEN_RELATIVO=..\Resources\Icons"
set "DESTINO=svgs"

echo [1/3] Limpiando carpeta temporal...
if exist "%DESTINO%" rd /s /q "%DESTINO%"
mkdir "%DESTINO%"

echo [2/3] Sanitizando y renombrando iconos...

:: CAMBIOS EN ESTA LÍNEA:
:: 1. Reemplaza '\' y '/' por '_' (Estructura de carpetas)
:: 2. Reemplaza '+' por 'Plus' (Para arreglar el error de Notepad++)
:: 3. Reemplaza '-' y espacios por '_' (Para evitar otros errores)
:: 4. Elimina cualquier otro caracter que no sea letra, numero, guion bajo o punto.

:: VERSIÓN COMPLETA (COMENTADA):
:: powershell -Command "& { $sourcePath = (Resolve-Path '%ORIGEN_RELATIVO%').Path; Get-ChildItem -Path $sourcePath -Recurse -Filter *.svg | ForEach-Object { $relPath = $_.FullName.Substring($sourcePath.Length + 1); $newName = $relPath -replace '\\', '_' -replace '/', '_' -replace '\+', 'Plus' -replace '-', '_' -replace '\s', '_' -replace '[^a-zA-Z0-9_\.]', ''; Copy-Item -LiteralPath $_.FullName -Destination (Join-Path '%DESTINO%' $newName) } }"

:: VERSIÓN DE PRUEBA (SOLO 5 ICONOS):
powershell -Command "& { $sourcePath = (Resolve-Path '%ORIGEN_RELATIVO%').Path; Get-ChildItem -Path $sourcePath -Recurse -Filter *.svg | Select-Object -First 5 | ForEach-Object { $relPath = $_.FullName.Substring($sourcePath.Length + 1); $newName = $relPath -replace '\\', '_' -replace '/', '_' -replace '\+', 'Plus' -replace '-', '_' -replace '\s', '_' -replace '[^a-zA-Z0-9_\.]', ''; Copy-Item -LiteralPath $_.FullName -Destination (Join-Path '%DESTINO%' $newName) } }"

echo [3/3] Iconos listos para SVGR.
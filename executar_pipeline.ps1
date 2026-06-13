$ErrorActionPreference = "Stop"

$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Python = Join-Path $ProjectDir ".venv\Scripts\python.exe"
$NotebookDir = Join-Path $ProjectDir "notebooks"

if (-not (Test-Path $Python)) {
    Write-Host "Ambiente .venv nao encontrado. Criando..."
    & "C:\Users\gomes\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" -m venv (Join-Path $ProjectDir ".venv")
}

Write-Host "Instalando/checando dependencias..."
& $Python -m pip install -r (Join-Path $ProjectDir "requirements.txt")

$env:IPYTHONDIR = Join-Path $ProjectDir ".ipython"
$env:JUPYTER_CONFIG_DIR = Join-Path $ProjectDir ".jupyter"
$env:MPLCONFIGDIR = Join-Path $ProjectDir ".matplotlib"

Push-Location $NotebookDir
try {
    Write-Host "Executando 01_segmentacao.ipynb..."
    & $Python -m nbconvert --to notebook --execute --inplace "01_segmentacao.ipynb"

    Write-Host "Executando 02_features.ipynb..."
    & $Python -m nbconvert --to notebook --execute --inplace "02_features.ipynb"

    Write-Host "Executando 03_classificacao.ipynb..."
    & $Python -m nbconvert --to notebook --execute --inplace "03_classificacao.ipynb"
}
finally {
    Pop-Location
}

Write-Host "Pipeline concluido."

# modRTToggle - adiciona/remove as teclas F8 e F9 no input.settings
# Uso: powershell -ExecutionPolicy Bypass -File teclas.ps1 [-Remover]
param([switch]$Remover)

$ErrorActionPreference = 'Stop'

$bindings = @('IK_F8=(Action=ModCycleRT)', 'IK_F9=(Action=ModToggleFG)')
$contexts = @(
    'Exploration', 'Exploration_Replacer_Ciri',
    'Combat', 'Combat_Replacer_Ciri',
    'Horse', 'Horse_Replacer_Ciri',
    'Boat', 'BoatPassenger',
    'Swimming', 'Diving',
    'Scene', 'ScriptedAction',
    'BASE_PanelsShortcuts'
)

if (Get-Process -Name witcher3 -ErrorAction SilentlyContinue) {
    Write-Host "Feche o The Witcher 3 antes de continuar (o jogo regrava o input.settings ao sair)." -ForegroundColor Red
    exit 1
}

$docs = [Environment]::GetFolderPath('MyDocuments')
$file = Join-Path $docs 'The Witcher 3\input.settings'
if (-not (Test-Path $file)) {
    Write-Host "Nao encontrei $file. Abra o jogo uma vez para ele criar o arquivo." -ForegroundColor Red
    exit 1
}

$backup = "$file.modRTToggle.bak"
Copy-Item $file $backup -Force

$lines = [IO.File]::ReadAllLines($file)
$out = New-Object System.Collections.Generic.List[string]

# sempre remove as linhas antigas do mod primeiro (deixa a instalacao idempotente)
foreach ($l in $lines) {
    if ($l -notmatch '\(Action=Mod(CycleRT|ToggleFG|ToggleRT|TogglePT)\)') { $out.Add($l) }
}

$added = 0
$conflicts = @()
if (-not $Remover) {
    $result = New-Object System.Collections.Generic.List[string]
    $ctx = ''
    for ($i = 0; $i -lt $out.Count; $i++) {
        $l = $out[$i]
        $result.Add($l)
        if ($l -match '^\[(.+)\]$') {
            $ctx = $matches[1]
            if ($contexts -contains $ctx) {
                foreach ($b in $bindings) { $result.Add($b) }
                $added++
            }
        }
        elseif ($contexts -contains $ctx -and $l -match '^(IK_F8|IK_F9)=') {
            $conflicts += "[$ctx] $l"
        }
    }
    $out = $result
}

[IO.File]::WriteAllLines($file, $out, (New-Object Text.UTF8Encoding($false)))

if ($Remover) {
    Write-Host "Teclas do modRTToggle removidas." -ForegroundColor Green
} else {
    Write-Host "Teclas F8/F9 adicionadas em $added contextos." -ForegroundColor Green
    if ($conflicts.Count -gt 0) {
        Write-Host "Atencao: F8/F9 ja tinham outras funcoes nestes contextos:" -ForegroundColor Yellow
        $conflicts | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
    }
}
Write-Host "Backup salvo em: $backup"

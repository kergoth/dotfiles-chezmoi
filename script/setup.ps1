Join-Path $PSScriptRoot "bootstrap.ps1" | Invoke-Expression

Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Set path to this dotfiles repo
$env:DOTFILES_DIR = $PSScriptRoot | Split-Path -Parent

# Apply my dotfiles
Write-Output "Applying dotfiles"
chezmoi init --apply --source="$env:DOTFILES_DIR" kergoth/dotfiles-chezmoi

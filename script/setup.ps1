function RefreshEnvPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Use RemoteSigned execution policy for PowerShell. Needed for scoop, etc.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install chezmoi if necessary
if (-Not (Get-Command chezmoi -ErrorAction SilentlyContinue)) {
    Write-Output "Installing chezmoi"

    if (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    }

    RefreshEnvPath

    scoop install chezmoi
}

# Set path to this dotfiles repo
$env:DOTFILES_DIR = $PSScriptRoot | Split-Path -Parent

# Apply my dotfiles
Write-Output "Applying dotfiles"
chezmoi init --apply --source="$env:DOTFILES_DIR" kergoth/dotfiles-chezmoi

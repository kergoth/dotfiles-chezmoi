# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($myWindowsPrincipal.IsInRole($adminRole)) {
    # We are running "as Administrator" - so relaunch as user

    $cmd = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoExit -WindowStyle Maximized -NoProfile -InputFormat None -ExecutionPolicy RemoteSigned -File " + $MyInvocation.MyCommand.Definition
    runas /trustlevel:0x20000 $cmd
    exit
}

. $PSScriptRoot\common.ps1

# Install PowerShell modules
. $PSScriptRoot\..\scripts\install-pwsh-modules.ps1

# Use RemoteSigned execution policy for PowerShell. Needed for scoop, etc.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if ($IsWindows) {
    # Install scoop
    if (-Not $env:SCOOP)
    {
        $env:SCOOP = "$env:USERPROFILE/scoop"
    }
    if (-Not (Test-Path "$env:SCOOP"))
    {
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    }
    RefreshEnvPath

    # Install git
    scoop install git

    # Install chezmoi
    scoop install chezmoi

    # Install languages
    scoop install rust go python
    $reg = Get-ChildItem $env:USERPROFILE\scoop\apps\python\*\install-pep-514.reg -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($reg) {
        Write-Host "Importing python registry entries"
        reg import $reg
    }
    RefreshEnvPath

    # Windows-specific
    scoop install sudo gow starship npiperelay

    # Install core
    # Unavailable on Windows: tmux, zsh
    scoop install neovim
    scoop install wget

    # Add scoop's Git for Windows bin directory to the PATH for its bash
    $gitdir = scoop prefix git
    Add-EnvironmentVariableItem "PATH" "$gitdir\bin" -User

    # Add cargo bindir to the PATH
    Add-EnvironmentVariableItem "PATH" "$env:USERPROFILE\.cargo\bin" -User

    # Install tools
    scoop install bat
    scoop install cht
    scoop install direnv
    scoop install duf
    scoop install fd
    scoop install ripgrep
    scoop install zoxide
    scoop install fzf

    try {
        $VSInstall = (Get-VSSetupInstance | Where-Object DisplayName -Match 'Build Tools' | Sort-Object -Property InstallationVersion | Select-Object -Last 1 -ExpandProperty InstallationPath)
        $VSTools = $VSInstall + "/Common7/Tools"
        if (Test-Path $VSTools) {
            . ($VSTools + "/Launch-VsDevShell.ps1")
        }

        cargo install eza
    }
    catch {
        Write-Error "Failed to install eza. Please make sure the Visual Studio Build Tools with the C++ Desktop workload is installed."
    }

    scoop install gh
    scoop install delta
    scoop install shfmt
    scoop install shellcheck
    scoop install jq
    scoop install sad
    scoop install sd
    cargo install choose
    scoop install git-branchless
    scoop install unar
    scoop install zstd

    # Disk tools
    scoop install dua
    scoop install dust

    pip install --user --disable-pip-version-check git-revise
    pip install --user --disable-pip-version-check git-imerge
    pip install --user --disable-pip-version-check peru

    # git-absorb is available only via release archives on Windows. It fails to build with cargo.
    if (-Not (Test-Path "$env:USERPROFILE\.cargo\bin\git-absorb.exe")) {
        $DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
        $absorb_url = Get-GithubLatestRelease tummychow/git-absorb "pc-windows-msvc.*.zip"
        $absorb = "$DownloadsFolder\" + (Split-Path $absorb_url -Leaf)
        if (-Not (Test-Path $absorb)) {
            Start-BitsTransfer $absorb_url -Destination $DownloadsFolder
        }
        $absorbtemp = "$env:TEMP\absorb"
        try {
            Expand-Archive "$absorb" -DestinationPath $absorbtemp -Force
            $absorbdir = (Get-ChildItem -Path $absorbtemp | Select-Object -First 1).FullName
            Move-Item "$absorbdir\git-absorb.exe" -Destination "$env:USERPROFILE\.cargo\bin\"
        }
        finally {
            Remove-Item $absorbtemp -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    RefreshEnvPath

    # Add installed software to the user's PATH and/or startup
    if (Test-Path "C:\Program Files\7-Zip") {
        Add-EnvironmentVariableItem "PATH" "C:\Program Files\7-Zip" -User
    }

    # Run SyncTrayzor, which will add itself to startup
    if (Test-Path "C:\Program Files\SyncTrayzor") {
        Start-Process "C:\Program Files\SyncTrayzor\SyncTrayzor.exe" -ArgumentList --minimized
    }
}

if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
    # Set path to this dotfiles repo
    $env:DOTFILES_DIR = $PSScriptRoot | Split-Path -Parent

    # Apply my dotfiles
    chezmoi init --apply --source="$env:DOTFILES_DIR" kergoth/dotfiles-chezmoi
}

if (-Not (Get-Command pipx -ErrorAction SilentlyContinue)) {
    python3 -m pip install --user --disable-pip-version-check pipx
    python3 -m pipx ensurepath
    RefreshEnvPath
}

Write-Output "Setup complete"

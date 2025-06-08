

. .\utils.ps1

$script_path = Convert-WindowsPathToWslPath "$bucketsdir\Chuckie_s\scripts\my_archlinux\init_archlinux.sh"
wsl --distribution Arch bash -c $script_path
$script_path = Convert-WindowsPathToWslPath "$bucketsdir\Chuckie_s\scripts\my_archlinux\install_pkgs.sh"
TODO:chezmoi

#!/usr/bin/bash

# init
###################################################
echo 'precedence ::ffff:0:0/96 100' >/etc/gai.conf
cat >/etc/pacman.d/mirrorlist <<EOF
Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch
Server = http://mirrors.zju.edu.cn/archlinux/\$repo/os/\$arch
EOF

# install packages
###################################################
pacman -Sy --noconfirm
packages=(
    chezmoi
    zsh
    zsh-completions
    starship
    which
    wget
    zoxide
    git
    sudo
    docker
    base-devel
    neovim
    python
    git # yay 需要
    pacman-contrib
    archlinuxcn-keyring
    screenfetch
    reflector
)
pacman -S --noconfirm --needed "${packages[@]}"

# dotfiles
###################################################
src="/home/Chuckie"
dst="/mnt/c/Users/Chuckie"
ln -s "$dst" "$src"

# FIXME:
# Chuckie is not in the sudoers file.
# ls -la /etc/sudoers
# -r--r----- 1 root root 5026 Jun  6 23:20 /etc/sudoers

useradd -m -s /usr/bin/zsh -G wheel Chuckie
echo "Chuckie: " | chpasswd
sudo chown Chuckie:Chuckie /home/Chuckie

# settings outside homedir
###################################################
SOURCE_DIR="/home/Chuckie/.local/share/chezmoi/etc"
TARGET_ROOT="/etc"
# 遍历所有文件（包含子目录）
find "$SOURCE_DIR" -type f | while read -r src; do
    # 获取去掉前缀后的路径
    rel_path="${src#$SOURCE_DIR}"
    target="$TARGET_ROOT$rel_path"

    # 确保目标目录存在
    mkdir -p "$(dirname "$target")"

    # 删除已有目标（可选，确保链接覆盖）
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -f "$target"
    fi

    # 创建软链接
    ln -s "$src" "$target"
    echo "Linked $target → $src"
done

####################################################

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
su Chuckie
makepkg -si

####################################################
# systemctl start docker.service
# sudo pacman-key --init             # 初始化 GPG 密钥体系
# sudo pacman-key --populate archlinux manjaro  # 加载官方信任公钥
# pacman -Syu --noconfirm

# 下载镜像列表，按速度排序并覆盖原列表
sudo systemctl daemon-reexec # 确保重载 systemd
sudo systemctl enable --now reflector.timer

# 清除系统中无用的包
sudo pacman -R $(pacman -Qdtq)

# 清除已下载的安装包
sudo pacman -Scc

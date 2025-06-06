#!/usr/bin/bash

useradd -G wheel Chuckie
ln -s /mnt/c/Users/Chuckie /home/Chuckie

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

# pacman -Syu sudo base base-devel docker

# systemctl start docker.service

# # TODO: chezmoi

# sudo pacman-key --init             # 初始化 GPG 密钥体系
# sudo pacman-key --populate archlinux manjaro  # 加载官方信任公钥

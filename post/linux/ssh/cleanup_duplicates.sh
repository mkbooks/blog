#!/bin/bash

# 设置默认文件夹路径为 /home/user/test
folder=${1:-"/home/user/test"}

# 统计文件夹下的文件总数
file_count=$(find "$folder" -maxdepth 1 -type f | wc -l)
processed_count=0

# 找出文件夹下所有文件，并计算每个文件的 MD5 值
find "$folder" -maxdepth 1 -type f -exec md5sum {} + | sort > "$folder/md5sum.txt"

# 根据 MD5 值进行重复文件的处理
while read -r line; do
    md5=$(echo "$line" | awk '{print $1}')
    filename=$(echo "$line" | awk '{print $2}')

    # 检查是否有重复的文件
    duplicates=$(grep "$md5" "$folder/md5sum.txt" | grep -v "$filename")

    if [[ -n $duplicates ]]; then
        shortest_filename=$filename

        # 查找文件名较短的重复文件
        while read -r duplicate; do
            duplicate_filename=$(echo "$duplicate" | awk '{print $2}')
            if [[ ${#duplicate_filename} -lt ${#shortest_filename} ]]; then
                shortest_filename=$duplicate_filename
            fi
        done <<< "$duplicates"

        # 删除除了文件名最短的重复文件之外的其他文件
        while read -r duplicate; do
            duplicate_filename=$(echo "$duplicate" | awk '{print $2}')
            if [[ "$duplicate_filename" != "$shortest_filename" ]]; then
                rm "$duplicate_filename"
            fi
        done <<< "$duplicates"
    fi

    # 更新进度
    processed_count=$((processed_count + 1))
    progress=$((processed_count * 100 / file_count))
    echo "Processing: $progress%"
done <<< "$(tail -n +2 "$folder/md5sum.txt")"  # 跳过第一行，不包括 md5sum.txt 文件本身

# 删除临时文件
rm "$folder/md5sum.txt"


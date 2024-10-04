calculate_dir_size() {
    local dir="$1"
    local total_size=0

    # Проходим по каждому элементу в каталоге
    for item in "$dir"/*; do
        if [ -f "$item" ]; then
            # Если это файл, получаем его размер с помощью stat
            size=$(stat --format="%s" "$item")
            total_size=$((total_size + size))
        elif [ -d "$item" ]; then
            # Если это каталог, рекурсивно вызываем функцию
            subdir_size=$(calculate_dir_size "$item")
            total_size=$((total_size + subdir_size))
        fi
    done

    echo "$total_size"
}

# Проверяем, передан ли аргумент (каталог)
if [ -z "$1" ]; then
    echo "Укажите каталог для расчета его размера."
    exit 1
fi

printf

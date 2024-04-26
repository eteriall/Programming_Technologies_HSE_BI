#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

if [ $# -ne 2 ]; then
  echo -e "${RED}Usage:${NC}  $0 <src> <dest>"
  exit 1
fi

echo -e "${GREEN}Rasskazchikov Alexander's script (TZ1)${NC}"
source_dir=$1
destination_dir=$2

mkdir -p "$destination_dir"

echo -e "Копирую файлы, находящиеся ${GREEN}в корне исходной директории...${NC}"
for entry in "$source_dir"/*
do
if [ -f "$entry" ];then
    echo "$entry"
  fi
done

echo -e "\nПолучаю список директорий, находящихся ${GREEN}в корне исходной директории...${NC}"
for entry in "$source_dir"/*
do
if [ -d "$entry" ];then
    echo "$entry"
  fi
done

echo -e "\nПолучаю список ВСЕХ файлов, находящихся ${GREEN}в исходной директории...${NC}"
all=$(find "$source_dir" -type f)
i=1
sp="/-\|"

for entry in $all
do
	if [ -f "$entry" ];then
		file=$(basename "$entry")
		file_name=$(basename "$entry" | cut -d. -f1)
		file_ext=$(basename "$entry" | cut -d. -f2)
		if [ -f "$destination_dir/$file" ]; then
			highest_number=$(ls "$destination_dir" | grep "$file_name" | sed 's/[^0-9]*//g' | sort -nr | head -1)
			new_number=$((highest_number + 1))
			new_file_name="$file_name copy $new_number.$file_ext"
			echo -e "Найден дубликат! ${GREEN}${entry}${NC} -> ${GREEN}${new_file_name}${NC}"
		else
			new_file_name="$file"
		fi
		cp "$entry" "$destination_dir/$new_file_name"   
		# echo -e "\rКопирую все файлы... ${GREEN} ${sp:i++%${#sp}:1} ${NC}"
	#    cp "$entry" "$destination_dir"
	fi
done
echo -e "${GREEN}Готово!${NC}"
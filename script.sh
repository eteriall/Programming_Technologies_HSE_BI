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
			new_file_name=${entry//\//-}
			echo -e "Найден дубликат! ${GREEN}${file}${NC} -> ${GREEN}${new_file_name}${NC}"
			if [ -f "$destination_dir/$new_file_name" ]; then
				echo -e "ERROR ${RED}${entry}${NC} -> ${RED}${new_file_name}${NC}"
				echo $(ls "$destination_dir" | grep "$file_name")
			fi

			cp "$entry" "$destination_dir/$new_file_name"   
		else
			cp "$entry" "$destination_dir"
		fi
	fi
done
echo -e "${GREEN}Готово!${NC}"

echo -e "Кол-во исходных файлов $(find $source_dir -type f| wc -l)"
echo -e "Кол-во файлов в копии $(find $destination_dir -type f| wc -l)"
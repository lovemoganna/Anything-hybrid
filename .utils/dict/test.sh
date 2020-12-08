#! /usr/bin/env bash
pyim_greatdict_folder="~/.emacs.d/dict/"

# check fpyim greatdict folder whether existed
check_pyim_dict_folder_whether_exist() {
 if [ -d "$pyim_greatdict_folder" ]; then
    echo "pyim greatdict does not exist, now will help generate the folder..."
    echo "$pyim_greatdict_folder"

else
    echo "$pyim_greatdict_folder alreay existed!" 
fi
}

# check pyim greatdict file whether existed
check_pyim_dict_file_whether_exist() {
		local hell ="Asd"
}


check_pyim_dict_folder_whether_exist

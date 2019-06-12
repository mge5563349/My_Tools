#!/bin/bash
# version 0.0.1

echo_notified() {
    echo "-------------------------------------------------------------------------"
    echo "use the 'rm' comman as usual to move to ~/.Trush;-)"
    echo "use 'rm -force [someting]' to remove like '/bin/rm' command."
    echo "use 'rm -clean' to clear the trush."
    echo "------------------------install sucess-----------------------------------"
}

move_command() {
if [ ! -d /usr/cmd ];then
	mkdir /usr/cmd -p
fi
} 

file_trush() {
    chmod +x saferm
    ./saferm -install >> /dev/null 2>&1
    if [ $? = 0 ];then
	    echo_notified
    fi
}

run_as_root() {
	read -p "Do you run the script as root or run as sudo(Y/N):" AS_ROOT
        if [ $AS_ROOT = "N" ] || [ $AS_ROOT = "n" ] ;then
		echo 'run as root or run as sudo'
		exit 1
	fi
}


run_as_root
if [ $? -ne 0 ];then
        exit 1
fi

file_trush
if [ $? -ne 0 ];then
        exit 1
fi



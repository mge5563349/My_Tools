#!/bin/bash
# version 0.0.1

echo_notified() {
    echo "-------------------------------------------------------------------------"
    echo "The command are move to /usr/cmd directory"
    echo "If you want use eg:reboot,init,reboot command,please type /usr/cmd/reboot"
    echo "-------------------------------------------------------------------------"
    echo "use the 'rm' comman as usual to move to ~/.Trush;-)"
    echo "use 'rm -force [someting]' to remove like '/bin/rm' command."
    echo "use 'rm -clean' to clear the trush."
    echo "-------------------------------------------------------------------------"
    echo "------------------------install sucess-----------------------------------"
}

move_command() {
if [ ! -d /usr/cmd ];then
	mkdir /usr/cmd -p
fi

cmd_dir=/usr/cmd
S_SHUTDOWN=$(which shutdown)
S_REBOOT=$(which reboot)
S_INIT=$(which init)

mv $S_SHUTDOWN $cmd_dir >> /dev/null 2>&1
if [ $? -ne 0 ];then
	if [ ! -f /usr/cmd/shutdown ];then
		echo "System OS does not exist shutdown command,exit!"
		exit 1
	fi
fi

mv $S_REBOOT $cmd_dir >> /dev/null 2>&1
if [ $? -ne 0 ];then
        if [ ! -f /usr/cmd/reboot ];then
                echo "System OS does not exist reboot command,exit!"
                exit 1
        fi
fi

mv $S_INIT $cmd_dir >> /dev/null 2>&1
if [ $? -ne 0 ];then
        if [ ! -f /usr/cmd/init ];then
                echo "System OS does not exist init command,exit!"
                exit 1
        fi
fi

}

file_trush() {
    chmod +x saferm
    ./saferm -install
}

run_as_root() {
    if [ `whoami` != 'root' ];then
	    echo 'run as root!'
	    exit 1
    fi
}

run_as_root

move_command
if [ $? -ne 0 ];then
        exit 1
fi

file_trush
if [ $? -ne 0 ];then
        exit 1
fi

echo_notified


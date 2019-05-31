#!/bin/bash
# version 0.0.1

echo_notified() {
    echo "-------------------------------------------------------------------------"
    echo "The command are move to /usr/cmd directory"
    echo "If you want use eg:reboot,init,reboot command,type /usr/cmd/reboot"
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
which shutdown >> /dev/null 2>&1
if [ $? = 0 ];then
    $(S_SHUTDOWN=$(which shutdown)) &>> /dev/null 
    mv $S_SHUTDOWN $cmd_dir >> /dev/null 2&>1
    if [ $? -ne 0 ];then
        	if [ ! -f /usr/cmd/shutdown ];then
	        	echo "System OS does not exist shutdown command,exit!"
	        	exit 1
	        fi
    fi
else
	echo "Warn:shutdown command not found,May be it already in /usr/cmd."
fi

which reboot >> /dev/null 2>&1
if [ $? = 0 ];then
	$(S_REBOOT=$(which reboot)) &>> /dev/null
        mv $S_REBOOT $cmd_dir >> /dev/null 2&>1
        if [ $? -ne 0 ];then
                if [ ! -f /usr/cmd/reboot ];then
                        echo "System OS does not exist reboot command,exit!"
                	exit 1
        	fi
	fi
else
        echo "Warn:shutdown command not found,May be it already in /usr/cmd."

fi

which init >> /dev/null 2>&1
if [ $? = 0 ];then
	$(S_INIT=$(which init)) &>> /dev/null
	mv $S_INIT $cmd_dir >> /dev/null 2&>1
	if [ $? -ne 0 ];then
        	if [ ! -f /usr/cmd/init ];then
                	echo "System OS does not exist init command,exit!"
                	exit 1
        	fi
	fi
else
        echo "Warn:shutdown command not found,May be it already in /usr/cmd."

fi
}

file_trush() {
    chmod +x saferm
    ./saferm -install >> /dev/null 2>&1
    if [ $? = 0 ];then
	    echo "-------------------------------------------------------------------------"
	    echo "The Linux File Trush Install Success!"
    fi
}

run_as_root() {
	read -p "Do you run the script as root or run as sudo(Y/N):" AS_ROOT
        if [ $AS_ROOT = "N" ] || [ $AS_ROOT = "n" ] ;then
		echo 'run as root or run as sudo'
		exit 1
	fi
}

ch_attr() {
    chattr +i /boot
    chattr +i /etc
    chattr +i /home
    chattr +i /mnt
    chattr +i /opt
    chattr +i /root
    chattr +i /srv
    chattr +i /usr
    chattr +i /var
    if [ -d /application ];then
        chattr +i /application
    fi
}

customize_file() {
    read -p "Type your customize directory or file:" file
    chattr -i $file
    echo "ONE RUN,ONE ADD!"
    exit 0
}

read -p "Type N use default policy,Do you want to customize directory or file(Y/N):" customize
if [ $customize = "Y" ] || [ $customize = "y" ];then
    customize_file
else
    run_as_root
    move_command
    if [ $? -ne 0 ];then
            exit 1
    fi

    file_trush
    if [ $? -ne 0 ];then
            exit 1
    fi

    ch_attr
    echo_notified
fi

#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Error! need 1 arg at least, like below:"
    echo "scp_rk.sh <file|dir> ..."
    exit 1
fi

DST_DIR="root@rk3308:/userdata/app/"

scp_exp() {
	expect -c "  
	    set timeout 5;  
	    spawn $1;  
	    expect {                
	        \"*assword:\" { send \"rk,123\r\" }  
	        \"yes/no\" { send \"yes\r\"; exp_continue }  
	    } ;  
	    expect eof 
	"
}

for arg in "$@"
do
    if [ -f $arg ]; then
        scp_exp "scp $arg $DST_DIR"
    elif [ -d $arg ]; then
        scp_exp "scp -r $arg $DST_DIR"
    else
        echo "can't find the file: ${arg}"
    fi
done


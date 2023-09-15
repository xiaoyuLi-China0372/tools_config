#!/bin/bash
AUTO_CMD()	## 建立AUTO_CMD函数
{
expect <<EOF
spawn ssh root@$1 "$3"
expect {
"yes/no" { send "yes\r";exp_continue }
"password:" { send "$2\r" }
}
expect eof
EOF
}

ping -c1 -w1 $1 &> /dev/null && {
	AUTO_CMD $1 $2 "$3"
}


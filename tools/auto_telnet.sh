#!/bin/bash
AUTO_CMD()	## 建立AUTO_CMD函数
{
expect <<EOF
spawn telnet $1 -l root
expect {
"login:" { send "root\r";exp_continue }
"*assword:" { send "$2\r";exp_continue }
"# " { send "$3;exit\r" }
}
expect eof
EOF
}

AUTO_CMD $1 $2 "$3"


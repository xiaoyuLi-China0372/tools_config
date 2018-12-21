#!/bin/sh

FORMAT=astyle
CODE_STYLE="$FORMAT --style=linux --suffix=none --max-code-length=80"
#CODE_STYLE="$FORMAT --style=allman --suffix=none --max-code-length=80"

if [ $# -lt 1 ]; then
    echo "Error! need 1 arg at least, like below:"
    echo "code_style.sh <code_file|code_dir> ..."
    exit 1
fi

for arg in "$@"
do
    if [ -f $arg ]; then
        $CODE_STYLE $arg
        if [ `uname` != "Linux" ]; then
            dos2unix $arg
        fi
    elif [ -d $arg ]; then
        file_list=$(find $arg | grep -E [.]{1}c$)
        file_list="$file_list $(find $arg | grep -E [.]{1}cpp$)"
        file_list="$file_list $(find $arg | grep -E [.]{1}cc$)"
        for file in $file_list
        do
            $CODE_STYLE $file
            if [ `uname` != "Linux" ]; then
                dos2unix $file
            fi
        done
    else
        echo "can't find the file: ${arg}"
    fi
done


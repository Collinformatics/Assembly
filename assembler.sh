#!/bin/bash

fileName="${1%%.*}" # remove .s extension

# Assemble
nasm -f elf64 ${fileName}".s"
if [ $? -ne 0 ]; then
  echo "NASM assembly failed" >&2
  exit 1
fi

ld ${fileName}".o" -o ${fileName} -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2
if [ "$2" == "-c" ]; then
	exit
elif [ "$2" == "-g" ]; then
	gdb -q ${fileName} # Debug
else
	./${fileName} # Execute
fi

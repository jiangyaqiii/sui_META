#!/bin/bash

if screen -list | grep -q sui_meta; then
    echo "运行中"
else
    echo "停止"
fi

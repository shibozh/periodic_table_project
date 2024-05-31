#!/bin/bash
echo Please provide an element as an argument.

# 接收一个参数
INPUT=$1

# 如果是个数字
if [[ $INPUT =~ ^[0-9]+$ ]]
then
  echo It is a number
# 如果不是数字且长度小于等于2
elif [[ ${#INPUT} -le 2 ]]
then
  echo "Its length is <= 2"
# 如果不是数字且长度大于2
else
  echo "Its length is > 2"
fi


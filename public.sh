#!/usr/bin/env bash

##
#
#   @method 读取配置文件
#   @param 文件名包含路径；
#   @param 选项名；
#   @param  条目名称；
#   @echo 输出条目对应的值；
read_conf(){
    local conf=$1

    if [ ! -r ${conf} ] &> /dev/null; then
        echo "Fatal Error: The file doesn't exist"
        return 0
    fi

    local opt=$2

    local item=$3

    local result=$(sed -n "/\[${opt}\]/,/\[.*\]/p" ${conf} | grep -v "\[.*\]" | grep ${item} | awk -F'=' '{print $2}' | tr -d '\n')

    echo ${result}
}

##
#
#   @method 读取配置文件
#   @param 字符串；
#   @param 正则表达式；
#   @echo  匹配的结果；
#   @return 成功则返回1，失败则返回0；
preg_match(){
    repo_path=$1
    exp=$2
    res=$(echo ${repo_path} | grep -oP "${exp}" | tr -d "\n")
    echo ${res}
    if [ ${res} ]; then
        return 1
    else
        return 0
    fi
}
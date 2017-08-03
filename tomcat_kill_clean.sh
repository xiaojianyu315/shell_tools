#!/bin/bash



function check_param(){
    echo '====================== start check param ============================='
    APP_NAME=$1
    if [  ! -n "$APP_NAME"  ]
    then
        echo '=== APP_NAME Can`t be empty'
        exit 0
    else
        continue;
    fi

    TOMCAT_HOME=$2

    if [  ! -n "$TOMCAT_HOME"  ]
    then
        echo '=== TOMCAT_HOME Can`t be empty'
        exit 0
    else
        continue;
    fi

    echo '=== app_name :'$APP_NAME
    echo '=== tomcat_home :'$TOMCAT_HOME
    echo '====================== param success ============================='
}


function kill(){
    APP_NAME=$1
    TOMCAT_HOME=$2

    echo '====================== start kill ============================='
    # 找到要kill的tomcat
    TOMCAT_PROCESS_STR=`ps aux | grep 'java.*'$APP_NAME | grep -v grep`
    PROCESS_ARRAY=(${TOMCAT_PROCESS_STR// / })
    TOMCAT_PROCESS_ID=${PROCESS_ARRAY[1]}

    echo '=== pid list :'$TOMCAT_PROCESS_ID

    # 利用tomcat自身关闭脚本尝试关闭
    sh $TOMCAT_HOME/bin/catalina.sh stop

    sleep 12

    # 循环检查是否已经关闭，未关闭强制关闭
    for ((reTry=1;reTry<=20;reTry++))
    do
        CHECK_STR_LENGTH=0
        TOMCAT_PROCESS_CHECK_STR=`ps aux | grep 'java.*'$APP_NAME | grep -v grep`
        CHECK_STR_LENGTH=${#TOMCAT_PROCESS_CHECK_STR}
        if [ $CHECK_STR_LENGTH != 0 ]
        then
            echo '=== start kill pid'
            kill $TOMCAT_PROCESS_ID
            sleep 2
            echo '=== Try to kill tomcat once more'
        else
            echo '=== Tomcat is already killed'
            break
        fi
    done
    echo '====================== kill success ============================='
}


function clean(){
    TOMCAT_HOME=$1
    echo '====================== start clean ============================='
    echo '=== clean webapps path:'$TOMCAT_HOME/webapps/*
    echo '=== clean work path:'$TOMCAT_HOME/work/*
    rm -rf $TOMCAT_HOME/webapps/*
    rm -rf $TOMCAT_HOME/work/*
    echo '=== clean success'
    echo '====================== clean success ============================='
}




app_name=$1
tomcat_name=$2
check_param $app_name $tomcat_name
kill $app_name $tomcat_name
clean $tomcat_name




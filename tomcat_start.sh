#!/bin/bash



function check_param(){
    echo '====================== start check param ============================='

    TOMCAT_HOME=$1

    if [  ! -n "$TOMCAT_HOME"  ]
    then
        echo '=== TOMCAT_HOME Can`t be empty'
        exit 0
    else
        continue;
    fi

    echo '=== tomcat_home :'$TOMCAT_HOME
    echo '====================== param success ============================='
}



function start(){
    TOMCAT_HOME=$1
    echo '====================== start tomcat ============================='
    sh $TOMCAT_HOME/bin/catalina.sh start
    echo '====================== start success ============================='

}

tomcat_name=$2
check_param  $tomcat_name
start $tomcat_name



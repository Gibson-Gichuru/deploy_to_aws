#!/bin/bash

set -e

trap 'current_command=$BASH_COMMAND' DEBUG

trap 'echo "\"${current_command}\" command filed with exit code $?."' EXIT


function run_database_migrations(){

    echo "Running database migrations"
}

function deploy_updates(){

    PWD=$(pwd)

    if [ -f "/etc/systemd/system/api.service" ]; then

        echo "Api Service file Found"

        # Api status check 

        API_STATUS=`sudo systemctl status api`


        if [ "$API_STATUS" == "active" ]; then 

            echo "Stoping api service"

            sudo systemctl stop api

        fi

        # install any dependencies

        install_depedencies

        # perform and database migrations

        run_database_migrations

        # reload-or-start the api service

        sudo systemctl reload-or-restart api 


    else

        echo "Api Service file not found"

        sudo cp $PWD/api.service "/etc/systemd/system/"

        # install any dependencies

        install_depedencies

        # perform and database migrations

        run_database_migrations

        # reload-or-start the api service

        systemctl reload-or-restart api 



    fi
}

function install_depedencies(){

    # create a python environment

    PWD=$(pwd)


    if [ ! -d $PWD/env ]; then

        python3 -m venv env 

    fi

    $PWD/env/bin/pip install -r $PWD/requirements.txt    
}

deploy_updates
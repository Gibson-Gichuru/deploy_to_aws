#!/bin/bash

set -e

trap 'current_command=$BASH_COMMAND' DEBUG

trap 'echo "\"${current_command}\" command filed with exit code $?."' EXIT

PWD=$(pwd)

function run_database_migrations(){

    echo "Running database migrations"
}

function deploy_updates(){


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

        # overwite service file

        sudo mv $PWD/api.service /etc/systemd/system/api.service


        # reload systemctl deamon

        sudo systemctl daemon-reload

        # reload-or-start the api service

        sudo systemctl reload-or-restart api 


    else

        echo "Api Service file not found"

        sudo cp $PWD/api.service "/etc/systemd/system/"

        # install any dependencies

        install_depedencies

        # perform and database migrations

        run_database_migrations

        # create the uwsgi socket file

        sudo touch /var/run/api.sock

        # reload-or-start the api service

        sudo systemctl start api 



    fi
}

function install_depedencies(){

    # create a python environment

    if [ ! -d $PWD/env ]; then

        python3 -m venv env 

    fi

    $PWD/env/bin/pip install -r $PWD/requirements.txt    
}

function configure_nginx(){

    # copy application server config file to sites-available

    sudo cp $PWD/api.conf /etc/nginx/sites-available

    # Enble server config

    sudo ln -sf /etc/nginx/sites-available/api.conf /etc/nginx/sites-enabled

    # reload nginx server

    sudo nginx -s reload
}

deploy_updates

# if deploy exits with code 0 then configure nginx

if [ $? -eq 0 ];then

    configure_nginx
fi
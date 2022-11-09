#!/bin/bash

function deploy_updates(){

    # check if api service is running

    API_SERVICE_STATUS = `sudo systemctl status flaskApi`


    # if its running stop the service

    if [ "$API_SERVICE_STATUS" = "active" ];then

        # stop the service
        'sudo systemctl stop flaskApi'

    fi 


    # activate python virtual environment

    `source env/bin/activate`

    # install all the depedencies

    `pip install --update pip`

    `pip install -r requirements.txt`

    # if need make any database migration do it here 

    deploy_database_migrations()

    # deactivate python virtual environment
    
    `deactivate`

    # restart the  api service
    `sudo systemctl reload-restart flaskApi`

}

function deploy_database_migrations(){

    echo "Checking for new database migrations"
}

deploy_updates()
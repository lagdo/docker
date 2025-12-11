#!/bin/bash

COMMAND=$1

if [ "${RUN_INSTALL}" == "true" ]
then
    if [ "${COMMAND_USER}" == "" ]
    then
        (cd ${COMMAND_DIR} && composer ${INSTALL_OPTIONS})
    else
        (cd ${COMMAND_DIR} && su ${COMMAND_USER} -c 'composer ${INSTALL_OPTIONS}')
    fi
fi

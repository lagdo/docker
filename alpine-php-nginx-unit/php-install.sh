#!/bin/bash

if [ "${COMPOSER_RUN}" == "true" ]
then
    if [ "${COMPOSER_RUN_USER}" == "" ]
    then
        (cd ${COMPOSER_RUN_DIR} && composer install ${COMPOSER_RUN_OPTIONS})
    else
        (cd ${COMPOSER_RUN_DIR} && su ${COMPOSER_RUN_USER} -c 'composer install ${COMPOSER_RUN_OPTIONS}')
    fi
fi

#!/usr/bin/env bash

set -e
shopt -s nullglob

ROOT_DIR=/etc/pgpool2
CONF_FILE=${ROOT_DIR}/pgpool.conf
SERVER_DIR=${ROOT_DIR}/servers.d

cat ${ROOT_DIR}/pgpool.conf.base > ${CONF_FILE}

echo "" >> ${CONF_FILE}

#create the server entries in the conf file
if [ $(ls -1A ${SERVER_DIR} | wc -l) -gt 0 ]; then
  FILES=${SERVER_DIR}/*
  COUNTER=1
  for file in ${FILES};
  do
      sed "s/XYZ/${COUNTER}/g" ${file} >> ${CONF_FILE}
      echo "" >> ${CONF_FILE}
      let COUNTER=COUNTER+1
  done
fi

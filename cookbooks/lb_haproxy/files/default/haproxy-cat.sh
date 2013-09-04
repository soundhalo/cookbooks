#!/usr/bin/env bash
# 
# Cookbook Name:: lb_haproxy
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

set -e
shopt -s nullglob

CONF_FILE=/etc/haproxy/haproxy.cfg

cat /etc/haproxy/haproxy.cfg.head > ${CONF_FILE}

echo "frontend all_requests" >> ${CONF_FILE}
echo "  bind 0.0.0.0:80" >> ${CONF_FILE}
echo "  timeout client 5000" >> ${CONF_FILE}
echo "  option http-server-close" >> ${CONF_FILE}
echo "  option forwardfor" >> ${CONF_FILE}

pools=""

for line in $(cat "/etc/haproxy/lb_haproxy.d/pool_list.conf");
do
  pools=${pools}" "${line}
done

echo "" >> ${CONF_FILE}

echo "  acl acl_my_soundhalo_com hdr_beg(host) -i my.soundhalo.com" >> ${CONF_FILE}
echo "  acl acl_https hdr_beg(X-Forwarded-Proto) -i https" >> ${CONF_FILE}

for single_pool in ${pools}
do
  if [ -e /etc/haproxy/lb_haproxy.d/acl_${single_pool}.conf ]; then
    cat "/etc/haproxy/lb_haproxy.d/acl_${single_pool}.conf" >> ${CONF_FILE}
  fi
done

echo "" >> ${CONF_FILE}
echo "  redirect prefix https://app.soundhalo.com/me if acl_my_soundhalo_com" >> ${CONF_FILE}
for single_pool in ${pools}
do
  # this will add redirect statements to config file
  if [ -r  /etc/haproxy/lb_haproxy.d/redirect_${single_pool}.conf ]; then
    cat /etc/haproxy/lb_haproxy.d/redirect_${single_pool}.conf >> ${CONF_FILE}
  fi
done

echo "" >> ${CONF_FILE}

for single_pool in ${pools}
do
  # this will add advanced use_backend statements to config file
  if [ -r  /etc/haproxy/lb_haproxy.d/use_backend_${single_pool}.conf ]; then
    cat /etc/haproxy/lb_haproxy.d/use_backend_${single_pool}.conf>> ${CONF_FILE}
  fi
done

echo "" >> ${CONF_FILE}

cat /etc/haproxy/haproxy.cfg.default_backend >> ${CONF_FILE}

echo "" >> ${CONF_FILE}

for single_pool in ${pools}
do
  if [ -e /etc/haproxy/lb_haproxy.d/backend_${single_pool}.conf ]; then
    cat /etc/haproxy/lb_haproxy.d/backend_${single_pool}.conf >> ${CONF_FILE}

    if [ $(ls -1A /etc/haproxy/lb_haproxy.d/${single_pool} | wc -l) -gt 0 ]; then
      cat /etc/haproxy/lb_haproxy.d/${single_pool}/* >> ${CONF_FILE}
    fi
  fi

  echo "" >> ${CONF_FILE}
done

#ssl
#cat /etc/haproxy/haproxy.ssl >> ${CONF_FILE}
#echo "" >> ${CONF_FILE}
#if [ $(ls -1A /etc/haproxy/ssl | wc -l) -gt 0 ]; then
#  cat /etc/haproxy/ssl/* >> ${CONF_FILE}
#fi




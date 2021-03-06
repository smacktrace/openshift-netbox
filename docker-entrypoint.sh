#!/bin/bash
##  Docker Entrypoint for NETBOX on Openshift
##  MAINTAINER smacktrace <smacktrace942@gmail.com>

set -e


###################################################################################
##################### CONFIGURE ARBITRARY OCP USER ################################
###################################################################################
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

###################################################################################
###################### PREP POSTGRES CONFIG FILE  #################################
###################################################################################

#Insert DB_NAME
sed -i -e "s/DB_NAME/$(echo $DB_NAME)/g" /opt/netbox/netbox/netbox/configuration.py

#Insert DB_USER
sed -i -e "s/DB_USER/$(echo $DB_USER)/g" /opt/netbox/netbox/netbox/configuration.py

#Insert DB_PASSWORD
sed -i -e "s/DB_PASSWORD/$(echo $DB_PASSWORD)/g" /opt/netbox/netbox/netbox/configuration.py

#Insert DB_HOST
sed -i -e "s/DB_HOST/$(echo $DB_HOST)/g" /opt/netbox/netbox/netbox/configuration.py

#Insert DJANGO_SECRET_KEY
sed -i -e "s/DJANGO_SECRET_KEY/$(echo $DJAGNO_SECRET_KEY)/g" /opt/netbox/netbox/netbox/configuration.py

#Insert FQDN
sed -i -e "s/FQDN/$(echo $FQDN)/g" /opt/netbox/netbox/netbox/configuration.py

###################################################################################
##########################      PREP NGINX    #####################################
###################################################################################

sed -i -e "s/FQDN/$(echo $FQDN)/g" /opt/netbox/netbox/netbox/nginx.conf


###################################################################################
##########################      Start UWSGI   #####################################
###################################################################################
uwsgi --ini /opt/netbox/netbox/netbox/uwsgi.ini

###################################################################################
##########################      RUN CMD    ########################################
###################################################################################

exec "$@"



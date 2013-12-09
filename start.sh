#!/bin/bash

if [[ ! -d ${NAGIOS_HOME}/bin ]]; then
        cd /tmp/nagios-4.0.2 && make install && make install-commandmode && make install-webconf
        cd /tmp/nagios-plugins-1.5 && make install
        mkdir -p /var/nagios/spool/checkresults && chown -R ${NAGIOS_USER}:${NAGIOS_GROUP} /var/nagios
        ln -s /opt/nagios/bin/nagios /usr/local/bin/nagios
        htpasswd -c -b -s /etc/nagios/htpasswd.users ${NAGIOSADMIN_USER} ${NAGIOSADMIN_PASS}
        env --unset NAGIOSADMIN_PASS
        sed -i 's,/opt/nagios/etc,/etc/nagios,g' /etc/apache2/conf.d/nagios.conf
        if [[ ! -z $NAGIOS_CGI_CONFIG ]]; then
                echo "SetEnv NAGIOS_CGI_CONFIG $NAGIOS_CGI_CONFIG" >> /etc/apache2/conf.d/nagios.conf
        fi
        if [[ ! -f /etc/nagios/nagios.cfg ]]; then
                cd /tmp/nagios-4.0.2 && make install-config
                cp ${NAGIOS_HOME}/etc/* /etc/nagios/
        fi
fi


chown -R ${NAGIOS_USER}.${NAGIOS_GROUP} /var/nagios
chown -R ${NAGIOS_CMDUSER}.${NAGIOS_CMDGROUP} /var/nagios/rw
chown -R ${NAGIOS_USER}.${NAGIOS_GROUP} ${NAGIOS_HOME}
chown -R ${NAGIOS_USER}.${NAGIOS_GROUP} /etc/nagios
/etc/init.d/apache2 start
/usr/local/bin/nagios /etc/nagios/nagios.cfg

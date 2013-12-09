## Docker-Nagios ##

Basic Docker image for running Nagios.<br />
This is running Nagios 4.0.2

### Knobs ###
- NAGIOS_HOME=/opt/nagios (main nagios location)
- NAGIOS_USER=nagios
- NAGIOS_GROUP=nagios
- NAGIOS_CMDUSER=nagios
- NAGIOS_CMDGROUP=nagios
- NAGIOS_CGI_CONFIG=/etc/nagios/cgi.cfg
- NAGIOSADMIN_USER=nagiosadmin
- NAGIOSAMDIN_PASS=nagios

### Web UI ###
The Nagios Web UI is available on port 80 of the container<br />

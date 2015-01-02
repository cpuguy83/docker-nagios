## Docker-Nagios  [![Docker Build Status](http://72.14.176.28/cpuguy83/nagios)](https://registry.hub.docker.com/u/cpuguy83/nagios)

Basic Docker image for running Nagios.<br />
This is running Nagios 3.5.1

You should either link a mail container in as "mail" or set MAIL_SERVER, otherwise
mail will not work.

### Knobs ###
- NAGIOSADMIN_USER=nagiosadmin
- NAGIOSAMDIN_PASS=nagios

### Web UI ###
The Nagios Web UI is available on port 80 of the container<br />

### Example usage ###
    ls ./
        configure.sh
        commands.cfg
    
    cat configure.sh
        #!/bin/bash
        script_path=$( cd "$( dirname "$0" )" && pwd )
        cp ${script_path}/commands.cfg /opt/nagios/etc/objects/

    docker run -d --name nagios
    docker run --rm -v $(pwd):/tmp --volumes-from nagios --entrypoint /tmp/configure.sh cpuguy83/nagios

# librenms
Deployment program for docker based LibreNMS with Oxidized and syslog enabled



Based on the example found in [LibreNMS Docker Repo](https://github.com/librenms/docker/tree/master/examples/compose "LibreNMS Docker examples")

Converted to Ansible playbook


## Installation

Quickest way to install is to use the kickstart. Currently only available for Ubuntu [click here for ubuntu setup instructions](https://github.com/sensaehf/librenms/blob/master/docs/ubuntu-install.md).

`curl https://raw.githubusercontent.com/sensaehf/librenms/master/kickstart/ubuntu.sh | sh`

Bare in mind, you should always read over scripts before you curl them straight into sh !

This installation will get librenms with oxidized up and running with some defaults and generated passwords.
The configuration can be found in

`/etc/sensa/librenms/pbvars.yaml`

This file can also be modified, either directly or by executing the configure.sh script. If you need to change the CPE user and passwords for isntance. You can modify this file and then reconfigure the installation with

`$ sudo sh rebuild.sh`




## Reverse Proxy and TLS

In order to get TLS you need to update the nginx config to the one located at [playbooks/templates/nginx](https://github.com/sensaehf/librenms/tree/master/playbooks/templates/nginx) called site-secure.cfg.j2

This file should be modified to include the server name, lines are commented with # CHANGE ME

Add your certificate and key in pem format to /etc/ssl/certs and /etc/ssl/private respectively and change permissions to 644

If you get your cert in pkcs12 format, you may need to convert it with the following steps as root:

```
 openssl pkcs12 -in tls.pfx -clcerts -nokeys -out /etc/ssl/certs/tls.crt
 mkdir /etc/ssl/certs/private/
 pkcs12 -in $certname -nocerts -nodes -out /etc/ssl/certs/private/tls.key
 chmod 644 /etc/ssl/certs/librenms.crt /etc/ssl/certs/private/tls.key
```

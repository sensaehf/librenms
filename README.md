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



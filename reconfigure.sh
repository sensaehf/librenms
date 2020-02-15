# Create working dir for download
cd /etc/sensa/librenms
if [ ! -f "/etc/sensa/librenms/pbvars.yaml" ]
then
        sudo sh configure.sh
fi
sudo ansible-playbook playbooks/shutdown.yml
sudo ansible-playbook playbooks/install.yml
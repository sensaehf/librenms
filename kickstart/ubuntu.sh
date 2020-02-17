# Update the system fully
echo "Upgrading system"
sudo apt-get update
sudo apt-get upgrade -y

# Install Ansible
echo "Installing Ansible"
sudo apt-get install python -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y

# Install git
echo "Installing git"
sudo apt-get install git -y
sudo apt autoremove

# Install docker things
echo "Installing docker related things"
sudo apt-get remove docker docker-engine
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker librenms
sudo apt-get install python-docker -y

# Check for config in current dir
echo "checking for config in current dir"
if [ -f "pbvars.yaml" ]
then
    CFGPath=`pwd`"/pbvars.yaml"
fi
if [ -z "$CFGPath" ]
then
    if [ -f "../pbvars.yaml" ]
    then
        CFGPath="$(dirname "$(pwd)")/pbvars.yaml"
    fi
fi
# Create working dir for download
echo "Creating /etc/sensa"
if [ ! -f "/etc/sensa" ]
then
    sudo mkdir /etc/sensa
fi
cd /etc/sensa/
echo "Cloning into librenms"
if [ ! -f "/etc/sensa/librenms" ]
then
    sudo git clone https://github.com/sensaehf/librenms.git
fi
echo "Entering /etc/sensa/librenms"
cd /etc/sensa/librenms
echo "Pulling from git for fresh update"
sudo git pull
if [ -z "$CFGPath" ]
then
    if [ ! "$CFGPath" == "/etc/sensa/librenms/pbvars.yaml" ]
    then
        sudo cp $CFGPath /etc/sensa/librenms/pbvars.yaml
    fi
fi
echo "Checking for pbvars config"
if [ ! -f "/etc/sensa/librenms/pbvars.yaml" ]
then
    echo "/etc/sensa/librenms/pbvars.yaml configuration file not present"
    echo "You can create one based on the example in /examples folder or"
    echo "by running the configure.sh script"
    echo ""
    echo "Would you like to run the configure script now? (Y/n)"
    read doconf
    if [ "$doconf" = "n" ]
    then
	    exit 0
    fi
    sudo sh configure.sh
fi
sudo ansible-playbook /etc/sensa/librenms/playbooks/install.yml
echo ""
echo "Configuration file with generated passwords can be found in"
echo "/etc/sensa/librenms/pbvars.yaml please store file in a safe"
echo "place in case of redeployment, and delete file from system."
echo ""
echo "To reconfigure the installation, modify pbvars.yaml and run:"
echo " $ cd /etc/sensa/librenms"
echo " $ sudo sh rebuild.sh"
echo ""
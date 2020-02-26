sudo apt-get -y install snmpd
sudo curl -o /etc/snmp/snmpd.conf https://raw.githubusercontent.com/sensaehf/librenms/master/examples/snmpd.conf
sudo curl -o /usr/bin/distro https://raw.githubusercontent.com/librenms/librenms-agent/master/snmp/distro
sudo chmod +x /usr/bin/distro
sudo systemctl restart snmpd
sudo systemctl enable snmpd
sudo iptables -A INPUT -p tcp -m tcp --dport 161 -i docker0 -j ACCEPT
sudo export API_KEY=`cat /etc/sensa/librenms/pbvars.yaml | grep API_TOKEN | awk '{print $2'}`
sudo curl -X POST -d "{\"hostname\":\"172.18.0.1\",\"version\":\"v2c\",\"community\":\"librenms\"}" -H "X-Auth-Token: $API_KEY" http://127.0.0.1/api/v0/devices
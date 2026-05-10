ll
cd /etc
ll
ll | grep paawd
ll
ll | grep passwd
ll
ll | grep p???wd
ll
ll | grep hos??
ll | grep ???ts
ll
ll | grep ???ts
ll
ll | grep ???ts
ll
ll | grep ???t
ll
cd /etc
ll
ll | grep ???t
ll | grep ???ts
ll
ll | grep hos??
ll | grep d*
ll | grep ?k???
ll | grep pa*
ll
ll | grep pa????
ll | grep s?????r
ll | grep s?????s
ll | grep p*
ll | grep 
ll | grep s*
ll
init 0
hostnamectl set-hostname system1
init 6
systemctl poweroff
sudo nano /etc/hosts
ip -br addr show | greo UP
ip -br addr show | grep UP
if down
sudo rm -f /etc/machine-id /run/machine-id
sudo systemd-machine-id-setup
sudo reboot
sudo hostnamectl set-hostname node2
sudo dnf upgrade --refresh -y
sudo hostnamectl set-hostname node2
sudo dnf upgrade --refresh -y
sudo poweroff
sudo ip addr flush dev enp0s3
sudo ip addr add 192.168.56.51/24 dev enp0s3
sudo nmcli device connect enp0s3
ip -br addr
nmcli connection show
sudo nmcli connection modify enp0s3 ipv4.method auto
sudo nmcli connection up enp0s3
sudo nmcli connection modify enp0s3 ipv4.never-default no
sudo nmcli connection up enp0s3
ip -br addr show enp0s3
sudo ip addr del 192.168.1.52/24 dev enp0s3
sudo ip route add default via 10.0.2.2 dev enp0s3
ping -c 3 google.com
sudo dnf upgrade -y
sudo poweroff
ip link show
ping -c 3 node2
sudo hostnamectl set-hostname node1
sudo nano /etc/hosts
ping -c 3 node2
sudo dnf install epel-release -y
sudo dnf install ansible -y
sudo dnf install ansible-core -y
ssh-keygen -t rsa
rm -rf ~/.ssh/id_rsa*
ssh-keygen -t rsa
ssh-copy-id maths@node2
ssh-copy-id maths@node3
nano hosts.ini
ansible my_cluster -i hosts.ini -m ping
ssh-copy-id -f maths@node3
ssh node3
ansible my_cluster -i hosts.ini -m ping
ansible my_cluster -i hosts.ini -a "df -h /"
ansible my_cluster -i hosts.ini -m dn_module -a "name=docker state=present" --become
ansible my_cluster -i hosts.ini -m dnf -a "name=podman state=present" --become
ansible my_cluster -i hosts.ini -m dnf -a "name=podman state=present" --become -K
ansible my_cluster -i hosts.ini -a "podman --version"
ansible my_cluster -i hosts.ini -a "podman run hello-world"
ansible my_cluster -i hosts.ini -a "podman run -dt -p 8080:80 --name my-web nginx"
ansible my_cluster -i hosts.ini -a "curl localhost:8080"
nano deploy_web.yml
ansible-playbook -i hosts.ini deploy_web.yml -K
nano deploy_web.yml
ansible-playbook -i hosts.ini deploy_web.yml -K
ansible my_cluster -i hosts.ini -m firewalld -a "port=8080/tcp permanent=yes state=enabled immediate=yes" --become -K
ansible my_cluster -i hosts.ini -a "firewall-cmd --permanent --add-port=8080/tcp" --become -K
ansible my_cluster -i hosts.ini -a "firewall-cmd --reload" --become -K
ansible my_cluster -i hosts.ini -a "firewall-cmd --permanent --add-port=8080/tcp" --become -K
ansible my_cluster -i hosts.ini -a "firewall-cmd --reload" --become -K
ansible my_cluster -i hosts.ini -m file -a "path=/home/maths/html_data state=directory mode=0755"
ansible my_cluster -i hosts.ini -m copy -a 'content="<h1>This is my Cluster Node!</h1>" dest=/home/maths/html_data/index.html'
ansible my_cluster -i hosts.ini -a "podman rm -f my-web"
ansible my_cluster -i hosts.ini -a "podman run -dt -p 8080:80 --name my-web -v /home/maths/html_data:/usr/share/nginx/html:Z nginx"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install fontconfig java-21-openjdk jenkins -y
sudo systemctl enable --now jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
ansible my_cluster -i hosts.ini -a "uptime"
ssh-copy-id maths@192.168.56.52
ssh 192.168.56.52
sudo systemctl start prometheus
sudo systemctl start grafana-server
sudo bash -c 'cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
EOF'
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus
sudo systemctl enable --now grafana-server
ss -nltp | grep -E '3000|9090'
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo bash -c 'cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/ --web.listen-address=:9091

[Install]
WantedBy=multi-user.target
EOF'
sudo systemctl daemon-reload
sudo systemctl restart prometheus
ss -nltp | grep 9091
sudo systemctl status loki
# 1. Download the binary using a short link
sudo curl -L -o /usr/local/bin/loki.zip https://bit.ly
sudo unzip -o /usr/local/bin/loki.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/loki
# 2. Get the configuration file
sudo mkdir -p /etc/loki
sudo curl -L -o /etc/loki/loki-config.yml https://bit.ly
# 3. Create the Service "Directions"
sudo tee /etc/systemd/system/loki.service <<EOF
[Unit]
Description=Loki Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/loki -config.file=/etc/loki/loki-config.yml
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 4. Start it up
sudo systemctl daemon-reload
sudo systemctl enable --now loki
sudo systemctl status loki
ls -l /usr/local/bin/loki*
# Rename whatever was unzipped to just 'loki'
sudo mv /usr/local/bin/loki-linux-amd64 /usr/local/bin/loki 2>/dev/null
# Force the permissions again
sudo chmod +x /usr/local/bin/loki
# Try to start it now
sudo systemctl restart loki
sudo curl -L -o /usr/local/bin/loki.zip https://github.com
sudo curl -L -o /usr/local/bin/loki.zip https://tinyurl.com
find ~ -name "*.zip" -size +10M
sudo dnf install -y epel-release
sudo dnf install -y loki
sudo curl -L -o /usr/local/bin/loki.zip https://bit.ly
sudo rm -f /usr/local/bin/loki.zip /usr/local/bin/loki
sudo dnf install -y https://github.com
nano ~/heal_cluster.sh
chmod +x ~/heal_cluster.sh
sudo nano /etc/prometheus/alert_rules.yml
sudo systemctl restart prometheus
~/heal_cluster.sh
nano ~/heal_cluster.sh
~/heal_cluster.sh
nano deploy_web.yml
~/heal_cluster.sh
nano ~/heal_cluster.sh
~/heal_cluster.sh
ansible node2 -i hosts.ini -m shell -a "pkill -f gzip" --become -K
ansible all -i hosts.ini -m shell -a "shutdown now" --become -K
ansible node2 -i hosts.ini -m shell -a "pkill -f gzip" --become -K
sudo shut down now
sudo shutdown now
ip -br addr

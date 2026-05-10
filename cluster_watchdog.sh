#!/bin/bash
# A simple watchdog that checks if the cluster is healthy
# If the Load Balancer is reachable, it ensures everything is Scale Up.
if ping -c 1 192.168.56.52 &> /dev/null
then
    echo "Cluster is healthy. Ensuring full capacity..."
    ansible-playbook -i hosts.ini scale_up.yml -K
else
    echo "Load Balancer unreachable! Manual intervention required."
fi

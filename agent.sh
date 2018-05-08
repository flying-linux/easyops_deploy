#!/bin/bash
crtPath=$(cd "$(dirname "$0")"; pwd)

action=$1
#sh unique_hosts.sh

echo $action

if [ "$action" == "install" ] ; then
    #ansible-playbook agent.yml --extra-vars "ansible_ssh_user=root" -i $crtPath/hosts -K -k
    ansible-playbook agent.yml --extra-vars "ansible_ssh_user=root" -i $crtPath/hosts 
fi

if [ "$action" == "init_disk" ] ; then
    ansible-playbook agent.yml --extra-vars "ansible_ssh_user=root" -i $crtPath/hosts -t init_disk -K -k
fi

if [ "$action" == "init_sys" ]; then
    ansible-playbook agent.yml --extra-vars "ansible_ssh_user=root" -i $crtPath/hosts -t init_sys -K -k
fi



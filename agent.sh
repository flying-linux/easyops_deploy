#!/bin/bash
crtPath=$(cd "$(dirname "$0")"; pwd)

action=$1
#sh unique_hosts.sh


case $action in
agent_install|agent_uninstall|proxy_install)
    ansible-playbook -i hosts -t $action agent.yml -K ;;
*)
   echo -e "\033[31mThe action should be one of :\033[0m""\033[32m [agent_install|agent_uninstall|proxy_install] \033[0m"  
esac

#!/bin/bash
crtPath=$(cd "$(dirname "$0")"; pwd)

action=$1
#sh unique_hosts.sh

echo "The action is :"$action

case $action in
agent_install|agent_uninstall|proxy_install)
    ansible-playbook -i hosts -t $action agent.yml -K ;;
*)
   echo 'the action should be one of [agent_install|agent_uninstall|proxy_install]'
esac

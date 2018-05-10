#  easyosp agent deploy guide

## 使用方式




### 


## 目录

1. [使用方式](#-使用方式)
2. [参数配置](#-参数配置)  
  2.1. [主机组配置](#-主机组配置)  
  2.2. [环境变量配置](#-环境变量配置)  
  2.3. [系统设置](#-系统设置)  

## <a id='-使用方式'></a> 1. 使用方式

直接执行脚本agent.sh即可显示提示信息

```
[root@b80a510d75cc easyops_deploy]# sh agent.sh 
The action should be one of : [agent_install|agent_uninstall|proxy_install] 
```

|    功能    |             命令            |
|-----------|-----------------------------|
| 安装agent | sh agent.sh agent_install   |
| 卸载agent | sh agent.sh agent_uninstall |
| 安装proxy | sh agent.sh proxy_install   |






## <a id='-参数配置'></a> 2. 参数配置
### 配置文件说明
|          配置文件          |                    作用                   |               是否必需               |
|----------------------------|-------------------------------------------|--------------------------------------|
| hosts                      | 所有需要执行任务的主机信息都保存在hosts   | 是                                   |
| group_vars/all/all         | 常用的系统环境相关变量的配置都在all文件中 | 是                                   |
| ansible.cfg                | ansible的系统配置                         | 按需配置                             |
| group_vars/all/default_all | 针对服务的一些默认配置                    | 按需配置（一般用户不需要修改此配置） |

备注：一般用户只需要配置hosts和group_vars/all/all 即可


### <a id='-主机组配置'></a> 2.1. 主机组配置

#### 主机配置文件模板

```
[proxy1]
agent1-1 ansible_ssh_host=192.172.0.6 
agent1-2 ansible_ssh_host=192.172.0.7 

[proxy1:vars]
agent_download_proxy_ip=192.172.0.3

[proxy2]
agent2-1 ansible_ssh_host=192.172.0.8 
agent2-2 ansible_ssh_host=192.172.0.9 

[proxy2:vars]
agent_download_proxy_ip= 192.172.0.4

[proxy3]
agent3-1 ansible_ssh_host=192.172.0.10 
agent3-2 ansible_ssh_host=192.172.0.11 

[proxy3:vars]
agent_download_proxy_ip= 192.172.0.5

[proxy]
proxy_h1 ansible_ssh_host=192.172.0.3
proxy_h2 ansible_ssh_host=192.172.0.4
proxy_h3 ansible_ssh_host=192.172.0.5
```

主机配置文件分三个部分：1、主机组 2、组变量 3、主机

|   ID   |        说明        |
|--------|--------------------|
| 主机组 | 标识一组具有某些相 |
| 组变量 | 一组主机共用的变量 |
| 主机   | 具体的某个节点     |

备注：所有的节点名不可重复，如果未定义相关的组变量agent_download_proxy_ip，系统自动以非proxy方案部署，也就是说：如果不采用proxy方案，那么就一定不要定义相关的组变量agent_download_proxy_ip




### <a id='-环境变量配置'></a> 2.2. 环境变量配置

#### 环境变量配置模板

```

common:
  normal_user: dgadmin
  root_user: root

openapi:
  access_key: cad90b2673b1f66e2e913ddd
  secret_key: c64c11bebd3f6c270a538f8b67a7c443b9e1a51aa1fcacc59231624b4f7a4934

org: 1028
agent_download_real_ip: 40.125.160.118
ansible_ssh_pass: gx@easyops
uuid_in_url: e06f38d51c6ef605e26c530719b68bb457b374fe
```


|           ID           |             说明            |
|------------------------|-----------------------------|
| agent_download_real_ip | cmdb IP                     |
| ansible_ssh_pass       | 普通用户密码                |
| uuid_in_url            | agent下载路径中的一串字符串 |





### <a id='-系统设置'></a> 2.3. 系统设置

#### 系统设置模板

```
[defaults]
forks             = 100
timeout           = 120
transport         = smart
host_key_checking = False

display_skipped_hosts = False

log_path=deploy.log

gathering         = implicit
deprecation_warnings = False
[ssh_connection]
ssh_args          = -o ControlMaster=auto -o ControlPersist=1800s
pipelining        = True
scp_if_ssh        = True

[privilege_escalation]
become=True
become_method='su'
become_user='root'
become_ask_pass=True
```


|        ID       |                解释                |
|-----------------|------------------------------------|
| forks           | 并发连接数（一次性执行多少个节点） |
| gathering       | 是否收集远程节点信息               |
| become_method   | 提权方式（一般为su或者sudo）       |
| become_user     | 具有root权限的用户                 |
| become_ask_pass | 切特权用户是否询问密码             |




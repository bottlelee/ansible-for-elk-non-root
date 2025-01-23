# ansible-for-elk-non-root
Deploy ELK cluster with less root permission

## 0. Introduction

What we will have:

1. An ELK cluster can operate without root permission
1. A minio node for elasticsearch data backup
1. Nginx with keepalived for load balancing and gateway proxy
1. (Optional) A Elastic Package Repository for air-gapped environment

Only need root permission when

1. Initialize the OS system
1. Deploy the keepalived(daily ops can be done by non-root user)
1. Deploy the docker registry

## 1. Prerequisites
- Docker/podman

## 2. Usage
### 2.1. Clone this repo

```bash
git clone https://github.com/chenxianpao/ansible-for-elk-non-root.git
```

### 2.2. Start up ansible runtime container

Build and start
```bash
cd ansible-for-elk-non-root/ansible-docker
docker-compose up -d --build
```

Login to the container
```bash
docker exec -it semaphore byobu
```

### 2.2. Create your own inventory file

```bash
cp -r /workdir/inventories/uat /workdir/inventories/<your_env>
```

Change the `ansible-for-elk-non-root/inventories/<your_env>/hosts.ini` file to your own

### 2.3. Adjust ansible.cfg

```bash
 nano /workdir/ansible-for-elk-non-root/ansible.cfg
```

Change `inventory = ./inventories/uat/hosts.ini` to your own `inventory = ./inventories/<your_env>/hosts.ini`

### 2.4 Adjust any vars you want

vars files are located in `/workdir/playbooks/vars`

### 2.5 Run the playbook

```bash
cd /workdir
ansible-playbook playbooks/99-playall.yml
```

## References

Ansible: https://www.ansible.com

ELK: https://www.elastic.co

Semaphore: https://semaphoreui.com

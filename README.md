# ansible-for-elk-non-root
Deploy ELK cluster with less root permission

## 1. Prerequisites
- Ansible 2.9.10
- Python 3.6~3.9(Dot no greater than 3.9)

## 2. Usage
### 2.1. Clone this repo
```bash
git clone https://github.com/chenxianpao/ansible-for-elk-non-root.git
```
### 2.2. Modify the inventory file
```bash
vi ansible-for-elk-non-root/inventories/uat/hosts.ini
```
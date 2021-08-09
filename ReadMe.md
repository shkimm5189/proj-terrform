# Terraform-ansible
Terraform을 사용하여 AWS Instance (ec2, rds)를 코드로서 정의하여 관리하고 직접 ec2 instance에 ansible을 사용하여  wordpress를 배포하고 rds와 연동한다. 

## 시작하기 전에..
ansible 패키지와 terraform이 설치 되어있어야한다. 

## ignore file
개인 정보가 포함이 되어있어 제외 시켰으며 해당 repo를 실행 시키려면 아래의 파일을 추가해줘야한다. 
1. db-config.tf
```
variable "mysql_db" {
  description = "your database name"
  type        = string
  default     = "wordpress"
}

variable "mysql_user" {
  description = "Your database user name"
  type        = string
  default     = "admin"
}

variable "mysql_passwd" {
  description = "Your database user passwd"
  type        = string
  default     = "testdb1234"
}

variable "mysql_port" {
  description = "Your database port"
  type        = number
  default     = 3306
}
```
2. my_sshkey
```
ssh 접속을 위해 해당 파일이 존재해야함.

ssh-keygen -f my_sshkey -N ''
```
 
# 디렉토리 구조
```
├── confing.tf
├── db-config.tf
├── group_vars
│   └── all.yaml
├── inventory.ini
├── main.tf
├── my_sshkey
├── my_sshkey.pub
├── output.tf
├── provider.tf
├── roles
│   └── wordpress
│       ├── defaults
│       │   └── main.yml
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       │   └── main.yml
│       ├── tasks
│       │   ├── Debian.yaml
│       │   └── main.yml
│       ├── templates
│       │   ├── port.conf.j2
│       │   └── wp-config.j2
│       ├── terraform.tfstate
│       └── vars
│           └── main.yaml
├── security-group.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── wpservers.yaml
```
config.tf : sshuser, instance_type,port 번호를 정의

security-group.tf : aws,rds의 보안 그룹을 정의 




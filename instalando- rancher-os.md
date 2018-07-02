

Confira o endereço IP para definirmos o arquivo cloud-config.yml

```
ip addr show eth0 
```



## Gerando o par de chaves pública e privada

Crie o par de chaves na máquinha cliente de onde você acessar o rancherOS.

 

```bash
ssh-keygen -f $HOME/.ssh/nome-da-minha-chave
```



## Criando o arquivo  cloud-config-yml

Copie e cole esse comando para ferar o arquivo cloud-config,  esse comando insere;

- [x] Chave pública do cliente ssh

- [x] Hostname do  RancherOS

- [x] Endereço ip do RancherOS

      Em ***ENDERECO-IP-DO-RANCHER*** insira o endereço IP do RancherOS

```bash
cat <<CONFIG> $HOME/cloud-config.yml
#cloud-config
ssh_authorized_keys:
 - $(cat $HOME/.ssh/nome-da-minha-chave.pub )

# rancherOS hostname
hostname: rancheros

# rancher-network settings
rancher:
  network:
    interfaces:
      eth0:
        dhcp: false
        address: 192.168.1.17/24
        gateway: 192.168.1.5
        mtu: 1500

    dns:
      nameservers:
        - 192.168.1.5
        - 1.1.1.1
        - 8.8.8.8
        - 8.8.4.4        
CONFIG
```





## Acessando o rancher server

Acesse o  RancherOS para para instalarmos o sistema no HD

```bash
ssh rancher@ip-rancher-server
```



Copie o arquivo cloud-config.yml para o RancherOS

```bash
scp marcos@192.168.50.123:cloud-config.yml .
```



## Instalando o rancher server no HD

Nesse momento já podemos instalar o sistema no hd executando o seguinte comando

```bash
sudo ros install -c  cloud-config.yml  -d /dev/sda
```



## Acessando o servidor após a instalação 

Após a instalação remova a iso do drive de dvd físico, ou virtual no caso do virtuabox ou qualquer outro hipervisor.



```bash
ssh -i $HOME/.ssh/nome-da-minha-chave rancher@ENDEREÇO-IP-RANCHE-SERVER
```



## Alterando a senha do usuário rancher para acesso ssh

Acesse o rancherOs e crie uma senha para o acessarmos via ssh.

```bash
sudo /bin/bash
passwd rancher
```




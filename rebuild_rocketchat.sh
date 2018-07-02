# Esse script  para  para, e  remove os containers e volumes relacionados ao rocket.chat
# Email Marcos.fr.rocha@gmail.com
# Site alfabech.eti.br
# Site alfabech.blogspot.com.br

# Esta função é utilizada para   prover um intervalo entre a execução dos containers afim de   fornecer um tempo hábil para que os serviços  subam.
aguarde(){
secs=$((20));while [ $secs -gt 0 ]; do    echo -ne "$secs\033[0K\r";    sleep 1;    : $((secs--)); done ;\
}

# Parando os containters
docker stop $(docker ps -af name=rocketchat)

# Removendo os containers
docker rm   $(docker ps -af name=rocketchat)

#Removendo volumes
docker volume   rm $(docker volume ls -qf name=rocketchat)


# Executando o mongo
docker-compose  up -d mongo ; aguarde

#Executando o mongo replica
docker-compose  up -d mongo-init-replica ; aguarde

# Executando o rocketchat
docker-compose  up -d rocketchat 


# Listandos os containers em execução
docker ps -af name=rocketchat

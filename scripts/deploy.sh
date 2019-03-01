#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp ssh -i ~/.ssh/spring-art.pem \
    target/spring-1.0-SNAPSHOT.jar \
    ubuntu@34.222.56.10:/home/ubuntu/

echo 'Restart server...'

ssh -i ~/.ssh/spring-art.pem ubuntu@34.222.56.10 << EOF

pgrep java | xargs kill -9
nohup java -jar spring-1.0-SNAPSHOT.jar > log.txt &

EOF

echo 'Bye'
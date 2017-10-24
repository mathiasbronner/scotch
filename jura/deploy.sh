docker push docker.deadlock.se/jura
ssh totalorder@deadlock.se 'cd deadlock.se/docker/jura && docker pull docker.deadlock.se/jura && docker-compose up -d'

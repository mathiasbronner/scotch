docker push docker.deadlock.se/dwex
ssh totalorder@deadlock.se 'cd deadlock.se/docker/dwex && docker pull docker.deadlock.se/dwex && docker-compose up -d'

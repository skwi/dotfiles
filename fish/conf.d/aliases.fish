# disk space usage
alias ducks='du -cks * | sort -rn | head'
alias duh='du -cksh *'
alias myip='dig @resolver1.opendns.com ANY myip.opendns.com +short'

#docker
alias stop-docker='docker stop (docker ps -q)'
alias clean-docker='docker system prune --volumes --force; docker container ls'
alias reset-docker='stop-docker; clean-docker'

#dockeriezed
alias mysql-dockerized='docker run --name one-shot-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=painauchocolat -d mysql:5.5 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci'

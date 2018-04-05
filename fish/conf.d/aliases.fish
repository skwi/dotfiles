# fuck this
alias fuck='sudo !!'

# disk space usage
alias ducks='du -cks * | sort -rn | head'
alias duh='du -cksh *'

# Symfony
alias sf='php bin/console'

#docker
alias stop-docker='docker stop (docker ps -q)'
alias clean-docker='docker system prune --volumes --force; docker container ls'
alias reset-docker='stop-docker; clean-docker'

#dockeriezed
alias mysql-dockerized='docker run --name one-shot-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=painauchocolat -d mysql:5.5 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci'

# Misc
alias meteo='curl -4 "wttr.in/Lyon?2nQ"'
function gifsearch 
    open "https://google.com/search?q=$1&tbm=isch&tbs=itp:animated" 
end

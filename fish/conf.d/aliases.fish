# fuck this
alias fuck='sudo !!'

# disk space usage
alias ducks='du -cks * | sort -rn | head'
alias duh='du -cksh *'

# Symfony
alias sf='php bin/console'

#docker
alias clean-docker='docker stop (docker ps -q); docker rm (docker ps -aq); docker system prune --force'

# Misc
alias meteo='curl -4 "wttr.in/Lyon?2nQ"'
function gifsearch 
    open "https://google.com/search?q=$1&tbm=isch&tbs=itp:animated" 
end

function manage_error

    set -l last_command $history[1]

    if test $argv -eq 128
    
        # HANDLE PUSH WITHOUT UPSTREAM
        if [ $last_command = "git push" ]
            set -l branch (git rev-parse --abbrev-ref HEAD)
            commandline -j "git push --set-upstream origin $branch"
        end


    else if test $argv -eq 127
    
        # HANDLE GITMOJI WHEN NO NVM VERSION SELECTED
        if [ $last_command = "gitmoji -c" ]
            commandline -j "nvm use; gitmoji -c"
            # nvm use --exit-code
            # gitmoji -c --exit-code
        end
    end

    # TODO : need root <-
    # commandline -j "$history[1]  $argv"
end
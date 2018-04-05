function fish_greeting -d "Hi Skwi !"
    
    set neutralColor blue
    set goodColor green
    set warningColor yellow
    set dangerColor red    
    
    # Uptime 
    set uptime (uptime | sed 's/.*up \([^,]*\), .*/\1/')
    set uptimeDays (echo $uptime | sed 's/ days//g')
    set uptimeColor normal
    if [ $uptimeDays -gt 30 ]
        set uptimeColor $neutralColor
    end
    if [ $uptimeDays -gt 60 ]
        set uptimeColor $dangerColor
    end

    # Disk space
    set space (df -h / | cut -c-41)
    set spaceData (echo $space | sed 's/Filesystem     Size   Used  Avail Capacit \/dev\/disk1s1//g')
    set spacePercent (string match --regex '([0-9]{2})%' '113Gi   92Gi   12Gi    89%' | sed -n 2p)
    set spaceText (string match --regex -a '([0-9]+)[A-Za-z]{2}' '113Gi   92Gi   12Gi    89%' |  sed -n 5p)
    set spaceColor normal
    if [ $spacePercent -gt 70 ]
        set spaceColor $neutralColor
    end
    if [ $spacePercent -gt 80 ]
        set spaceColor $warningColor
    end
    if [ $spacePercent -gt 90 ]
        set spaceColor $dangerColor
    end

    # Build message
    echo (whoami)'@'(hostname)' - Uptime: '(set_color $uptimeColor)$uptime
    set_color normal
    echo 'Free disk space: '(set_color $spaceColor)$spaceText' ('$spacePercent'%)'
    set_color normal
    
    # Devtools versions
    echo 'PHP: '(php -v | head -1 | cut -c5-10)' - NPM: '(npm -v)' - Node: '(node -v | cut -c2-) 
    
    # Brew outdated
    brew update > /dev/null 2>&1 &
    brew cleanup > /dev/null 2>&1 &
    brew outdated > /tmp/outdated &
    set nbOutdated (wc -l /tmp/outdated | sed 's/       \(.*\) \/tmp\/outdated/\1/')
    if [ $nbOutdated -gt 0 ]
        set outdatedColor $warningColor
        if [ $nbOutdated -gt 10 ]
            set outdatedColor $dangerColor
        end
        set outdatedString (tr '\n' ' ' < /tmp/outdated | sed 's/\ $//')
        echo 'Homebrew outdated packages: '(set_color $outdatedColor)$outdatedString
        set_color black
        echo 'To update all packages run "'(set_color --bold black)'brew upgrade '$outdatedString'"'
        set_color normal
    end

end
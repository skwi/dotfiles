function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  segment white 1b402c " $pwd "
end

function show_user -d "Show user"
  # TODO : use this when you have fish-shell on different machines

  # if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
  #   set -l host (hostname -s)
  #   set -l who (whoami)

  #   # Skip @ bit if hostname == username
  #   if [ "$USER" != "$host" ]
  #     segment fa0 111 " $who@$host"
  #   else
  #     segment fa0 111 " $who"
  #   end
  # end
end

function show_prompt -d "Shows the prompt with privilede appropriate symbol"
  segment black green " "
end


## SHOW PROMPT
function fish_prompt
  show_prompt
  show_user
  show_pwd

  segment_close
end

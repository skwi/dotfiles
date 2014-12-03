# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/dotfiles/.{path,bash_git,bash_prompt,exports,aliases,functions,extra}; do
        [ -r "$file" ] && source "$file"
done
unset file
source ~/.bash_local
rm -Rf ~/.vim && cp -R ~/dotfiles/.vim ~/.vim
rm -Rf ~/.vimrc && cp -R ~/dotfiles/.vimrc ~/.vimrc

rm -Rf ~/.gitconfig && cp -R ~/dotfiles/.gitconfig ~/.gitconfig
rm -Rf ~/.gitignore && cp -R ~/dotfiles/.gitignore ~/.gitignore


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion
[ -f ~/dotfiles/.git-completion.sh ] && . ~/dotfiles/.git-completion.sh
[ -f ~/dotfiles/.git-flow-completion.sh ] && . ~/dotfiles/.git-flow-completion.sh

# Color for LS command
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
	alias ls='ls --color=auto'
fi

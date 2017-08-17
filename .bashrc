alias l='ls -al'
alias ll='ls -l'

alias pretty='php71 ~/dev/php/pretty.php '
alias unpretty='php71 ~/dev/php/pretty.php -u '

# alias sonar='~/Downloads/sonarqube-5.4/bin/macosx-universal-64/sonar.sh'
# alias sonar-runner='~/Downloads/sonar-scanner-2.5.1/bin/sonar-runner'
# alias fontforge='/Applications/FontForge.app/Contents/MacOS/FontForge'

if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# Prompt customization
PS1='\[\033[38;5;114m\]\u\[\033[38;5;168m\]@\h\[\033[38;5;180m\]:\W \[\033[38;5;75m\]$(vcprompt)\[\e[0m\]$ '

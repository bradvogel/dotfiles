# source .bashrc if it's there
# Add git shell autocompletion
GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-completion.bash
export PS1='\[\e[1G\e[0;36m\]\u: \W$(__git_ps1 " (%s)")\[\e[m\] '

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Change dir
alias dev="cd ~/dev"
alias tmp="cd /tmp"

# Git commands
alias gti="git"
alias gitcleanup="git branch --merged | perl -ne 'print if not /\\* master/' | xargs git branch -d"
alias gittrash="find . -name \"*.orig\" -o -name \"*BACKUP*\" -o -name \"*LOCAL*\" -o -name \"*REMOTE*\" -o -name \"*BASE*\" | xargs rm"
alias gitclean="gittrash && git gc && git remote prune origin && gitcleanup"
alias gu="git fetch --all --prune && git pull --ff-only"
alias guf="git fetch --all --prune && git pull --ff-only && npm ci && git checkout -- package-lock.json 2> /dev/null"
alias gp="git push"
alias gpf="git push -f"
alias json="python -m json.tool"
# See https://stackoverflow.com/questions/25356810/git-how-to-squash-all-commits-on-branch
alias gitsquashmaster='git fetch origin;git rebase -i HEAD~$(git rev-list --count HEAD ^origin/master)'
alias gitsquashmain='git fetch origin;git rebase -i HEAD~$(git rev-list --count HEAD ^origin/main)'
alias gitx="open -a /Applications/GitX.app ."
alias gitresetmaster="git reset --hard origin/master; git checkout master; gu"
alias gitresetmain="git reset --hard origin/main; git checkout main; gu"
alias updaterepos="rm -rf /opt/homebrew/lib/node_modules/@mixmaxhq/mixmax && npm rm -g @mixmaxhq/mixmax && npm i -g @mixmaxhq/mixmax@latest && pushd ~/dev/mixmax-runner && gu && mixmax dev repo update --skip-deps && popd"
alias gitdiscard="git checkout -- ."

# DBs
localdb() {
  mongosh 'mongodb://localhost:3001/meteor' $@
}

appproddb() {
  mongosh 'mongodb://localhost:37028/app-prod?readPreference=secondary&directConnection=true&ssl=false&serverSelectionTimeoutMS=10000' $@
}

contactsdb() {
  mongosh 'mongodb://localhost:37034/contacts?readPreference=secondary&directConnection=true&ssl=false&serverSelectionTimeoutMS=10000' $@
}

appstagingdb() {
  mongosh "mongodb://localhost:37022/app-stag?readPreference=secondary&directConnection=true&ssl=false&serverSelectionTimeoutMS=10000" $@
}


# PRs
alias pr="mixmax dev pr create brad -m master"
alias prs="mixmax dev pr create brad"

alias killdev="killall node; killall ruby; killall gulp"

alias smerge="/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge ."
# https://apple.stackexchange.com/questions/31872/how-do-i-reset-the-scrollback-in-the-terminal-via-a-shell-command
alias clear="clear && printf '\e[3J'"

# Notify me
# Useful for notifying me via audio when a long running command is done, eg: npm test; notifyme
alias notifyme="say 'command finished'"
alertme() {
    message=${1:-"command finished"}
    osascript -e "display alert \"$message\"" >/dev/null 2>&1 &
}


logs() {
  ssh dev -t "pm2 logs $1"
}
restart() {
  ssh dev -t "pm2 restart $@"
}
stop() {
  ssh dev -t "pm2 stop $@"
}
start() {
  ssh dev -t "pm2 start $@"
}
rlogs() {
  ssh dev -t "pm2 restart $1; clear; pm2 logs $1"
}

alias status=" ssh dev -t \"pm2 status\""
alias statusdep=" ssh dev -t \"pm2dep status\""

# Set a timer, eg: settimer 10 "is deploy done building?"
settimer() {
    sleep $(echo "$1 * 60" | bc)
    if [ -z "$2" ]
    then
      say "timer finished"
    else
      say "$2"
    fi
}


function kp(){
  kill -9 $(lsof -ti :$1);
}

function gitclone(){
  git clone --recursive $1 && cd `echo $_ | sed -n -e 's/^.*\/\([^.]*\)\(.git\)*/\1/p'` && code .
}

function gitsummary(){
  pushd ~/dev;

  for x in $(find . -maxdepth 2 -type d -name ".git")
  do (
    cd $(dirname $x)
    GREP=$(git status|grep -v -e 'On branch master' -e 'nothing to commit, working tree clean' -e 'Your branch is up to date' -e'^$')
    if [[ -n "$GREP" ]]
    then
      echo -e "\n$(dirname $x)"
      echo $GREP
    fi
  )
  done
  F=$(find */node_modules */node_modules/\@* -name .bin -prune -false -o -maxdepth 1 -type l)
  if [[ -n "$F" ]]
  then
    echo 'npm links:'
    echo $F | xargs -n 1 echo
  fi

  popd
}

function ge(){
  pushd /tmp; git clone --recursive $1 && cd `echo $_ | sed -n -e 's/^.*\/\([^.]*\)\(.git\)*/\1/p'` && cd . && git log; popd;
}

# Increase history size.
HISTSIZE=10000

##
# Your previous /Users/brad/.bash_profile file was backed up as /Users/brad/.bash_profile.macports-saved_2014-07-30_at_16:20:11
##

# MacPorts Installer addition on 2014-07-30_at_16:20:11: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH:$HOME"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"

export PATH=$PATH:"~/Library/Python/3.8/bin"

export NODE_EXTRA_CA_CERTS='/Users/brad/dev/mixmax-runner/certs/rootCA.pem'

export TF_VAR_pagerduty_token='KfXDsanU_94LPzU6tZKH'
export TF_VAR_grafana_token='eyJrIjoiYTI3NTN3Vk5rQVRTY09YT25RdkM2WkF3azh2N3Bza2IiLCJuIjoiVGVycmFmb3JtIC0gQnJhZCIsImlkIjoxfQ=='

# https://mixmax.slack.com/archives/CFX7QK7PW/p1615905959001500
export AWS_PROFILE=default


# Tell Node.js to accept the locally generated Mixmax CA certificate.
export NODE_EXTRA_CA_CERTS='/Users/brad/dev/mixmax-runner/certs/rootCA.pem'

# Hide the "The default interactive shell is now zsh" warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Give user-installed binaries preference
# Brad 4/11/22 commented out since it kills node
# export PATH="/usr/local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/brad/Desktop/google-cloud-sdk/path.bash.inc' ]; then . '/Users/brad/Desktop/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/brad/Desktop/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/brad/Desktop/google-cloud-sdk/completion.bash.inc'; fi

# Setting PATH for Python 3.12
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"

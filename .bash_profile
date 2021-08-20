
# source .bashrc if it's there
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
alias gu="git fetch --all --prune && git pull --ff-only && npm install"
alias guf="git fetch --all --prune && git pull --ff-only && npm ci"
alias gp="git push"
alias gpf="git push -f"
alias json="python -m json.tool"
# See https://stackoverflow.com/questions/25356810/git-how-to-squash-all-commits-on-branch
alias gitsquash='git fetch origin;git rebase -i HEAD~$(git rev-list --count HEAD ^origin/master)'
alias gitx="open -a /Applications/GitX.app ."

# PRs
alias pr="mixmax dev pr create brad -m master"
alias prs="mixmax dev pr create brad"

alias killdev="killall node; killall ruby; killall gulp"
alias supervisorrecover="supervisorctl restart notifications admin contacts compose emailapps app api files homepage website event-delivery rule-distribution gateway publications send mail data service-people service-sequences maintenance"
alias supervisorrecoveraftersleep="sleep 250 && supervisorctl restart notifications admin contacts compose emailapps app api files homepage website event-delivery rule-distribution gateway publications send mail data service-people service-sequences maintenance"

alias smerge="/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge ."
alias resetdb="pushd ~/dev/app && rm -rf .localdb && mkdir .localdb && popd && supervisorctl restart app"
# https://apple.stackexchange.com/questions/31872/how-do-i-reset-the-scrollback-in-the-terminal-via-a-shell-command
alias clear="clear && printf '\e[3J'"

# Notify me
# Useful for notifying me via audio when a long running command is done, eg: npm test; notifyme
alias notifyme="say 'command finished'"
# Useful for notifying me via text when a long running command is done, eg: npm test; textme
textme() {
  curl -s -XPOST 'https://gateway.mixmax.com/ir/icELAcH6ft7EZnLYh/gvXlGUhMxLbghLNlS' --data-urlencode "message=$* -- status is $?"
}

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

# Use Sublime as default editor.
export EDITOR='subl -w'

##
# Your previous /Users/brad/.bash_profile file was backed up as /Users/brad/.bash_profile.macports-saved_2014-07-30_at_16:20:11
##

# MacPorts Installer addition on 2014-07-30_at_16:20:11: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH:$HOME"
# Finished adapting your PATH environment variable for use with MacPorts.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"

export PATH=$PATH:"~/Library/Python/2.7/bin"

export PATH=$PATH:"~/dev/mixmax-runner/scripts"
# Give user-installed binaries preference
# export PATH=/usr/local/bin:/Users/brad/.nvm/versions/node/v8.9.3/bin:/usr/local/opt/mongodb/bin:/opt/local/bin:/opt/local/sbin:/Users/brad/.yarn/bin:/usr/local/heroku/bin:/usr/local/opt/mongodb/bin:/opt/local/bin:/opt/local/sbin:/Users/brad/.yarn/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/brad/.rvm/bin:/bin:/Users/brad/go/bin:/Users/brad:/Applications/Sublime Text.app/Contents/SharedSupport/bin:~/Library/Python/2.7/bin:~/dev/mixmax-runner/scripts:/Users/brad/.rvm/bin:/bin:/Users/brad/go/bin:/Users/brad:/Applications/Sublime Text.app/Contents/SharedSupport/bin:~/Library/Python/2.7/bin:~/dev/mixmax-runner/scripts

export NODE_EXTRA_CA_CERTS='/Users/brad/dev/mixmax-runner/certs/rootCA.pem'

# See https://mixmax.slack.com/archives/C1UD2GT5G/p1575324650337400?thread_ts=1575318864.335100&cid=C1UD2GT5G
export MONGOMS_DOWNLOAD_DIR="$HOME/.cache/mongodb-binaries"
# Tell Node.js to accept the locally generated Mixmax CA certificate.
export NODE_EXTRA_CA_CERTS='/Users/brad/dev/mixmax-runner/certs/rootCA.pem'
# Tell Node.js to accept the locally generated Mixmax CA certificate.
export NODE_EXTRA_CA_CERTS='/Users/brad/dev/mixmax-runner/certs/rootCA.pem'
# Tell Node.js to accept the locally generated Mixmax CA certificate.
export NODE_EXTRA_CA_CERTS='/Users/brad/dev/mixmax-runner/certs/rootCA.pem'

export TF_VAR_pagerduty_token='KfXDsanU_94LPzU6tZKH'
export TF_VAR_grafana_token='eyJrIjoiYTI3NTN3Vk5rQVRTY09YT25RdkM2WkF3azh2N3Bza2IiLCJuIjoiVGVycmFmb3JtIC0gQnJhZCIsImlkIjoxfQ=='

export PATH="/usr/local/opt/mongodb-community@4.2/bin:$PATH"
export ES_HOME=/usr/local/etc/elasticsearch-7.9.3

# https://mixmax.slack.com/archives/CFX7QK7PW/p1615905959001500
export AWS_PROFILE=default

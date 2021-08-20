
# Add git shell autocompletion
GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-completion.bash
export PS1='\[\e[1G\e[0;36m\]\u: \W$(__git_ps1 " (%s)")\[\e[m\] '

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/brad/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# See http://stackoverflow.com/questions/21001387/how-do-i-set-the-gopath-environment-variable-on-ubuntu-what-file-must-i-edit
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH="$HOME/.yarn/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# From https://mixmax.slack.com/archives/CECBZGLTU/p1574117574003800?thread_ts=1574117227.002800&cid=CECBZGLTU
# Define a common download directory for mongodb-memory-server to avoid needing to re-download the
# mongo binaries when you interact with node_modules via npm.
export MONGOMS_DOWNLOAD_DIR="$HOME/.cache/mongodb-binaries"

unstick() {
    kill -9 $(lsof -ti :$@) && touch src/server/router.js
}

pretty() {
  npx prettier --write "src/**/*.js";
  npx prettier --write "src/**/*.jsx";
  npx prettier --write "test/**/*.js";

  npx eslint --fix "src/**/*.js";
  npx eslint --fix "src/**/*.jsx"
  npx eslint --fix "test/**/*.js";
}

nvm use default

# The next line updates PATH for Netlify's Git Credential Helper.
if [ -f '/Users/brad/.netlify/helper/path.bash.inc' ]; then source '/Users/brad/.netlify/helper/path.bash.inc'; fi

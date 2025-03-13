# Add Homebrew paths
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

# Setup Homebrew
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

### Added by the Heroku Toolbelt

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# See http://stackoverflow.com/questions/21001387/how-do-i-set-the-gopath-environment-variable-on-ubuntu-what-file-must-i-edit
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH="$HOME/.yarn/bin:$PATH"

pretty() {
  npx prettier --write "src/**/*.js";
  npx prettier --write "src/**/*.jsx";
  npx prettier --write "test/**/*.js";

  npx eslint --fix "src/**/*.js";
  npx eslint --fix "src/**/*.jsx"
  npx eslint --fix "test/**/*.js";
}
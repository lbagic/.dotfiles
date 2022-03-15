## Define all paths here. This simplifies hunting for random path clobbering.
# vim:ft=zsh

# USER_BIN="$HOME/bin"
SYSTEM="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# NVM bin
# NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Check for symlinks to directories in bin and
# append them to the path. This is useful when linking in
# a suite such as flutter or android SDK.
local elem
for elem in $USER_BIN/*; do
    if [[ -L "$elem" && -d "$elem" ]]
    then
        USER_BIN=$USER_BIN:$elem
    fi
done
unset elem

# export final result
export PATH="$PATH:$SYSTEM:$NVM_DIR"

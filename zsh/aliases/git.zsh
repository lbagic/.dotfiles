# vim:ft=zsh
alias g="git"
# https://git-scm.com/docs/pretty-formats - reference on --format flag.
alias glog="git log --decorate --oneline --graph --color=always --pretty=format:'%C(auto)%h%C(auto)%d %s %C(cyan)(%aN, %cr)'"
alias gloga="glog --all"
alias gp='git push origin HEAD'
alias gd="git diff --compact-summary"
alias ga="git add ."
alias gc='git commit'
alias gcm='git commit -m '
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gac='git add -A; git commit'
alias gacm='git add -A; git commit -m '
alias g-='git checkout -' # quickly switch between branches.
alias gstash='git stash --include-untracked'

export forgit_checkout_branch=gcob # move wfxr/forgit 'gco' to 'gcob'
alias gcb='git checkout -b'

# clone git repos when bare link is pasted into shell
alias -s git="git clone" # this is a suffix alias.

alias gj='open `git config remote.origin.url`'

greset() {
  git reset --soft HEAD~${1:-1}
}

git-branch-del-regex() {
  git for-each-ref --format="%(refname:short)" refs/heads/$1 | xargs git branch -D
}

cloneall() {
  for branch in $(git branch -a | grep remotes | grep -v HEAD | grep -v master); do
    git branch --track ${branch#remotes/origin/} $branch
  done
}

# Update Git submodule to latest commit on origin
alias gsur='git submodule update --remote --merge'

# git commit browser by Junegunn Choi
# https://junegunn.kr/2015/03/browsing-git-commits-with-fzf
function gshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

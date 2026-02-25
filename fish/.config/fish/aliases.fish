alias ls="eza"
alias la="eza -la"
alias ll="eza -l"
alias cat="bat"
alias vim="nvim"

abbr -a g git
abbr -a gst git status
abbr -a ga git add
abbr -a gdf git diff
abbr -a gfe git fetch
abbr -a gpl git pull
abbr -a gp git push
abbr -a gpf git push --force-with-lease --force-if-includes
abbr -a gco git checkout
abbr -a gc git commit
abbr -a gcm git commit -m
abbr -a gca git commit --amend --no-edit
abbr -a gcam git commit --amend
abbr -a gbr git branch
abbr -a glg git log --graph
abbr -a gmr git merge
abbr -a grb git rebase
abbr -a gsw git switch
abbr -a gcl git clone
abbr -a grst git reset

abbr -a jab jj abandon
abbr -a jabs jj absorb
abbr -a jbl jj b l
abbr -a jbs jj b s
abbr -a jbm jj b m
abbr -a jbf jj b f
abbr -a jbt jj b t
abbr -a jbu jj b u
abbr -a jbmb "jj b m -f 'heads(::@- & bookmarks())' -t @-"
abbr -a jc jj commit
abbr -a jd jj desc
abbr -a jdf jj diff
abbr -a jdfe jj diffedit
abbr -a je jj edit
abbr -a jgc jj git clone
abbr -a jgf jj git fetch
abbr -a jgfm "jj git fetch && jj new 'trunk()'"
abbr -a jgi jj git init
abbr -a jgp jj git push
abbr -a jl jj log
abbr -a jll jj log -r ::@
abbr -a jlm "jj log -r '::trunk()'"
abbr -a jn jj new
abbr -a jnm "jj new 'trunk()'"
abbr -a jrb jj rebase
abbr -a jrs jj restore
abbr -a jrv jj revert
abbr -a jsp jj split
abbr -a jsq jj squash
abbr -a jst jj st

abbr -a tfa terraform apply
abbr -a tfi terraform init
abbr -a tfp terraform plan
abbr -a tf terraform

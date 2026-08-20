alias ls="eza"
alias la="eza -la"
alias ll="eza -l"
alias cat="bat"
alias vim="nvim"
alias pn="pnpm" # Fix completions for pnpm's `pn` alias

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
abbr -a jba jj b a
abbr -a jbd jj b d
abbr -a jbf jj b f
abbr -a jbl jj b l
abbr -a jbm jj b m
abbr -a jbs jj b s
abbr -a jbt jj b t
abbr -a jbu jj b untrack
abbr -a jc jj commit
abbr -a jcl jj git clone
abbr -a --set-cursor jcm jj commit -m \"%\"
abbr -a jd jj desc
abbr -a jdf jj diff
abbr -a jdfe jj diffedit
abbr -a je jj edit
abbr -a jfe jj git fetch
abbr -a jfem "jj git fetch && jj new 'trunk()'"
abbr -a jgi jj git init
abbr -a jl jj log
abbr -a jll jj log -r ::@
abbr -a jlm "jj log -r '::trunk()'"
abbr -a jltm "jj log -r 'heads(::@ & ::trunk())::(@ | trunk())'"
abbr -a jn jj new
abbr -a jne jj next
abbr -a jnm "jj new 'trunk()'"
abbr -a jnmy "jj new 'my_bookmarks()'"
abbr -a jp jj git push
abbr -a jpa jj git push --all
abbr -a jpr jj prev
abbr -a jrb jj rebase
abbr -a jrbm "jj rebase -o 'trunk()'"
abbr -a jrs jj restore
abbr -a jrv jj revert
abbr -a jsd jj spr diff
abbr -a jsdc jj spr diff --cherry-pick
abbr -a jsh jj show
abbr -a jsl jj spr land
abbr -a jsp jj split
abbr -a jspr jj spr
abbr -a jsq jj squash
abbr -a jst jj st

abbr -a tfa tofu apply
abbr -a tfi tofu init
abbr -a tfp tofu plan
abbr -a tf tofu

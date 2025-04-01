set fish_greeting

# Activate mise
mise activate fish | source
mise hook-env -s fish | source

# Init starship
starship init fish | source

if status is-interactive
    abbr -a gst git status
    abbr -a g git
    abbr -a gst git status
    abbr -a ga git add
    abbr -a gdf git diff
    abbr -a gfe git fetch
    abbr -a gpl git pull
    abbr -a gp git push
    abbr -a gpf git push --force-with-lease
    abbr -a gco git checkout
    abbr -a gc git commit
    abbr -a gcm git commit -m
    abbr -a gbr git branch
    abbr -a glg git log --graph
    abbr -a gmr git merge
    abbr -a grb git rebase
    abbr -a gsw git switch
    abbr -a gcl git clone
    abbr -a grst git reset

    abbr -a tfa terraform apply
    abbr -a tfi terraform init
    abbr -a tfp terraform plan
    abbr -a tf terraform
end

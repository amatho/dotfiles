set -g fish_color_autosuggestion brblack
set -g fish_color_cancel -r
set -g fish_color_command brgreen
set -g fish_color_comment brmagenta
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape brcyan
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator cyan
set -g fish_color_param brwhite
set -g fish_color_quote yellow
set -g fish_color_redirection bryellow
set -g fish_color_search_match white --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r

abbr -a gst git status
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

abbr -a tfa terraform apply
abbr -a tfi terraform init
abbr -a tfp terraform plan
abbr -a tf terraform

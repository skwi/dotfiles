function show_result -d "Shows the result of the previous command, or the duration if successful"
    set -l status_copy $status

    if test "$CMD_DURATION" -gt 20
        set -l duration (echo $CMD_DURATION | humanize_duration)

        if test ! -z "$duration"
            set -l indicator

            if test $status_copy -ne 0
                set indicator " $status_copy "
            end

            segment_right white 2980b9 " $duration "
            # segment_close
        end
    else if test $status_copy -ne 0
        segment_right white f00 " $status_copy "
        # segment_close
    else
        segment_right eee 2980b9 (date +%H:%M)
        # segment_close
    end
end

function show_git_revision
    set -l rev_info ""
    set branch_status (git status --branch --porcelain=v2 | \
                      grep "branch.ab" | \
                      sed "s/# branch.ab //" \
                      2> /dev/null)
                      
    if [ "$branch_status" != "+0 -0" ]
        if [ "$branch_status" = "" ]
            set rev_info " UNTRACKED "
        else
            set rev_info " $branch_status "
        end
        segment_right B7DBDC 680F0F $rev_info
    end

    if [ "$rev_info" != "" ]
    end
end

function show_git_rebase
    set git_top_level (git rev-parse --show-toplevel)
    set git_path "$git_top_level/.git"
    set -l rebase_info ""
    if test -d "$git_path/rebase-apply"
        set -l rebase_last (cat .git/rebase-apply/last)
        set -l rebase_next (cat .git/rebase-apply/next)
        set rebase_info " REBASE $rebase_next/$rebase_last "
        segment_right black white $rebase_info
    end
end

function show_git -d "Display the current git state"
    set -l ref
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set ref (command git symbolic-ref HEAD 2> /dev/null)
        if [ $status -gt 0 ]
            set -l branch (command git show-ref --head -s --abbrev |head -n1 2> /dev/null)
            set ref "➦ $branch "
        end
        set branch_symbol \uE0A0
        set -l branch (echo $ref | sed  "s-refs/heads/-$branch_symbol -")

        set -l BG PROMPT
        set -l dirty (command git status --porcelain --ignore-submodules=dirty 2> /dev/null)
        set -l dirty_files (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)

        if [ "$dirty" = "" ]
            set BG green
            set PROMPT "$branch"
        else
            set BG yellow
            set dirty ''

            # Check if there's any commit in the repo
            set -l empty 0
            git rev-parse --quiet --verify HEAD >/dev/null ^&1
            or set empty 1

            set -l target
            if [ $empty = 1 ]
                # The repo is empty
                set target '4b825dc642cb6eb9a060e54bf8d69288fbee4904'
            else
                # The repo is not emtpy
                set target 'HEAD'

                # Check for unstaged change only when the repo is not empty
                set -l unstaged 0
                git diff --no-ext-diff --ignore-submodules=dirty --quiet --exit-code
                or set unstaged 1
                if [ $unstaged = 1 ]
                    set dirty $dirty"●"
                end
            end

            # Check for staged change
            set -l staged 0
            git diff-index --cached --quiet --exit-code --ignore-submodules=dirty $target
            or set staged 1
            if [ $staged = 1 ]
                set dirty $dirty'✚'
            end

            # Check for dirty
            if [ "$dirty" = "" ]
                set PROMPT "$branch"
            else
                set PROMPT "$branch $dirty"
            end
        end

        segment_right white 2e8352 " $PROMPT "
        show_git_rebase
        show_git_revision
        segment_right 2c3e50 white " $dirty_files "

    end
end

function fish_right_prompt -d "Prints right prompt"
    show_result
    show_git

    segment_close
end

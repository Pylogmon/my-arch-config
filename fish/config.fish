if status is-interactive
    if test "$TERM_PROGRAM" = "WezTerm"
        oh-my-posh init fish --config /home/hgy/.config/poshthemes/mojada.omp.json | source
    else
        return
    end
    # Commands to run in interactive sessions can go here
end

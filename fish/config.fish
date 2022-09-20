if status is-interactive
    if test "$XDG_CURRENT_DESKTOP" = "KDE"
        oh-my-posh init fish --config ~/.config/poshthemes/mojada.omp.json | source
    else
        echo "No Desktop!"
    end
    # Commands to run in interactive sessions can go here
end

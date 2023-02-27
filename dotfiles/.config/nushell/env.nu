mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
let-env EDITOR = 'nvim'

local style = {}

style.border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

style.vitesse_highlights = {
    Comment = { fg = '#5c6b5e' },
    Function = { fg = '#80a665' },
    String = { fg = '#c98a7d' },
    Number = { fg = '#4c9a91' },
    Keyword = { fg = '#4d9375' },
    Boolean = { fg = '#4d9375' },
    Identifier = { fg = '#bd976a' },
    Operator = { fg = '#cb7676' },
    Constant = { fg = '#c99076' },
    Structure = { fg = '#6893BF' },
    Type = { fg = '#5da9a7' },
    Error = { fg = '#cb7676' },

    Cursor = { fg = '#212121', bg = '#c8c5b8' },
    Directory = { fg = '#6394bf' },
    SignColumn = { fg = '#3c463d' },
}

style.catppuccin_overrides = {
    base = '#202020',
    crust = '#181818',
    mantle = '#191919',
    surface1 = '#3c463d',
    surface2 = '#5c6b5e',
    peach = '#4C9A91',
    text = '#c8c5b8',
    sky = '#cb7676',
    flamingo = '#bd976a',

    green = '#4d9375',
    red = '#cb7676',
    blue = '#6394bf',
    yellow = '#e6cc77',
}

return style

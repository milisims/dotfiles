## dotfiles

This is my repo for my dotfiles. Primarily, zsh/(n)vim.

neovim reads the vim runtime dir, so global changes go there, otherwise
you can just change neovim's configuration.

TODO:
 * investigate:
 * kana/vim-operator-user and related plugins (operator section)

## Key-mappings and useful Commands: reference
### Vim
Key | Mode | Action
--- | :--: | ------
`Space` | All | **Leader**
`;` | All | **Local Leader**
`Y` | Normal | Yank to the end of line (y$)
`<Return>` | Normal | Toggle fold (za)
`S`+`<Return>` | Normal | Focus the current fold by closing all others (zMza)
`S`+`<Return>` | Insert | Start new line from any cursor position (\<C-o>o)
`F2` | _All_ | Toggle paste mode
`!` | Normal | Shortcut for `:!`
`}` | Normal | After paragraph motion go to first non-blank char (}^)
`<` | Visual/Normal | Indent to left and re-select
`>` | Visual/Normal | Indent to right and re-select
`Tab` | Visual | Indent to right and re-select
`Shift`+`Tab` | Visual | Indent to left and re-select
`gh` | Normal | Show highlight group that matches current cursor (TODO: remove)
`gp` | Normal | Select last paste (TODO: make this)
`Q` | Normal | Start/stop macro recording
`M` | Normal/Visual | Play macro 'q'
`<M-j>`/`<M-k>` | Normal/Visual | Move lines down/up
`cp` | Normal | Duplicate paragraph
`<leader>`+`a` | Normal | Align paragraph
`<leader>`+`os` | Normal | Load last session (TODO works?)
`<leader>`+`se` | Normal | Save current workspace as last session
`<leader>`+`d` | Normal/Visual | Duplicate line or selection
`<leader>`+`S` | Normal/Visual | Source selection (TODO: make vim only)
`<leader>`+`ml` | Normal | Append modeline

### File Operations

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`cd` | Normal | Switch to the directory of opened buffer (:lcd %:p:h)
`W!!` | Command | Write as root

### Editor UI

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`ts` | Normal | Toggle spell-checker (:setlocal spell!)
`<leader>`+`tl` | Normal | Toggle hidden characters (:setlocal nolist!)
`<leader>`+`th` | Normal | Toggle highlighted search (:set hlsearch!)
`<leader>`+`tw` | Normal | Toggle wrap (:setlocal wrap! breakindent!)
`g0` | Normal | Go to first tab (:tabfirst)
`g$` | Normal | Go to last tab (:tablast)
`gr` | Normal | Go to previous tab (:tabprevious)
`*` | Visual | Search selection forwards  TODO: selects up to that point?
`#` | Visual | Search selection backwards
`<leader>`+`j` | Normal | Next on location list
`<leader>`+`k` | Normal | Previous on location list

### Window Management

Key   | Mode | Action
----- |:----:| ------------------
`q` | Normal | Quit window (and Vim if last window. Pauses on modified buffer)
`Ctrl`+`j` | Normal | Move to window below (\<C-w>j)
`Ctrl`+`k` | Normal | Move to upper split (\<C-w>k)
`Ctrl`+`h` | Normal | Move to left split (\<C-w>h)
`Ctrl`+`l` | Normal | Move to right split (\<C-w>l)
`<leader>`+`w` | Normal | Enter window mode (\<C-w>)

Additional window mode commands (`:help windows`):
Key   | Mode | Action
----- |:----:| ------------------
`s` | Normal | Horizontal (:split)
`v` | Normal | Vertical split (:vsplit)
`o` | Normal | Close other windows (:only)
`c` | Normal | Closes current buffer (:close)
`d` | Normal | Removes current buffer (:bdelete)
`H/J/K/L` | Normal | Move window to absolute left/bottom/top/right
`z` | Normal | Close any "preview" windows that are open

### Plugin: yankstack
TODO

### Plugin: vim-easy-align
TODO

### Plugin: sexp
TODO

### Plugin: Denite
TODO

Key   | Mode | Action
----- |:----:| ------------------
`<localleader>`+`r` | Normal | Resumes last Denite window
`<localleader>`+`f` | Normal | File search
`<localleader>`+`b` | Normal | Buffers and MRU
`<localleader>`+`d` | Normal | Directories
`<localleader>`+`l` | Normal | Location list
`<localleader>`+`q` | Normal | Quick fix
`<localleader>`+`n` | Normal | Dein plugin list
`<localleader>`+`g` | Normal | Grep search
`<localleader>`+`j` | Normal | Jump points
`<localleader>`+`o` | Normal | Outline tags
`<localleader>`+`s` | Normal | Sessions
`<localleader>`+`h` | Normal | Help
`<localleader>`+`/` | Normal | Buffer lines
`<localleader>`+`*` | Normal | Match line
`<localleader>`+`z` | Normal | Z (jump around)
`<leader>`+`gl` | Normal | Git log
`<leader>`+`gs` | Normal | Git status
`<leader>`+`gf` | Normal | Grep word under cursor
`<leader>`+`gg` | Normal/Visual | Grep word under cursor
| **Within _Denite_ mode** |||
`Escape` | Normal/Insert | Toggle modes
`jj` | Insert | Leave Insert mode
`Ctrl`+`y` | Insert | Redraw
`r` | Normal | Redraw
`st` | Normal | Open in a new tab
`sg` | Normal | Open in a vertical split
`sv` | Normal | Open in a split
`'` | Normal | Toggle mark current candidate

### Plugin: Deoplete

Key   | Mode | Action
----- |:----:| ------------------
`Enter` | Insert | Select completion or expand snippet
`Tab` | Insert/select | Smart tab movement or completion
`Ctrl`+`j/k/f/b/d/u` | Insert | Movement in completion pop-up
`Ctrl`+`<Return>` | Insert | Expand Emmet sequence
`Ctrl`+`g` | Insert | Undo completion
`Ctrl`+`l` | Insert | Refresh candidates
`Ctrl`+`e` | Insert | Cancel selection and close pop-up
`Ctrl`+`y` | Insert | Close pop-up

### Plugin: Commentary

Key   | Mode | Action
----- |:----:| ------------------
`gcc` | Normal | Toggle single line comment
`gc{motion}` | Normal | Toggle comments over motion
`gc` | Visual | Toggle comments over selection

### Plugin: Easymotion
TODO: remap
Key   | Mode | Action
----- |:----:| ------------------
`s`+`s` | Normal | Jump to two characters from input
`s`+`d` | Normal | Jump to a character from input
`s`+`f` | Normal | Jump over-windows
`s`+`h` | Normal | Jump backwards in-line
`s`+`l` | Normal | Jump forwards in-line
`s`+`j` | Normal | Jump downwards
`s`+`k` | Normal | Jump upwards
`s`+`/` | Normal/operator | Jump to free-search
`s`+`n` | Normal | Smart next occurrence
`s`+`p` | Normal | Smart previous occurrence

### Plugin: Nvim-R
TODO

### Misc Plugins

Key   | Mode | Action
----- |:----:| ------------------
`<leader>`+`o` | Normal | Open tag-bar
`<F5>` | Normal | Open undo tree

## Credits & Contribution

[Rafi] - Most of my customization was a merge of my old one and his.

[Rafi]: https://github.com/rafi/vim-config

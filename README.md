## dotfiles

This is my repo for my dotfiles. Primarily, zsh/(n)vim. Bash is very old
settings

neovim reads the vim runtime dir, so global (vim and neovim) changes go there,
neovim specific settings are in nvim dir. The following documentation doesn't
distinguish between the two.

TODO: unimpaired, vim-eunuch, rewrite for WHEN they are used, not per-plugin

## Key-mappings and useful Commands: reference
### Vim
Key             | Mode          | Action
---             | :--:          | ------
`Space`         | All           | **Leader**
`;`             | All           | **Local Leader**
`Y`             | Normal        | Yank to the end of line (y$)
`<Return>`      | Normal        | Toggle fold (za)
`S`+`<Return>`  | Normal        | Focus the current fold by closing all others (zMza)
`S`+`<Return>`  | Insert        | Start new line from any cursor position (\<C-o>o)
`F2`            | _All_           | Toggle paste mode
`!`             | Normal        | Shortcut for `:!`
`}`             | Normal        | After paragraph motion go to first non-blank char (}^)
`<`             | Visual/Normal | Indent to left and re-select
`>`             | Visual/Normal | Indent to right and re-select
`Tab`           | Visual        | Indent to right and re-select
`Shift`+`Tab`   | Visual        | Indent to left and re-select
`gh`            | Normal        | Show highlight group that matches current cursor (TODO: remove)
`gp`            | Normal        | Select last paste (TODO: make this)
`Q`             | Normal        | Start/stop macro recording
`M`             | Normal/Visual | Play macro 'q'
`<M-j>`/`<M-k>` | Normal/Visual | Move lines down/up
`cp`            | Normal        | Duplicate paragraph
`<leader>`+`a`  | Normal        | Align paragraph
`<leader>`+`os` | Normal        | Load last session (TODO works?)
`<leader>`+`se` | Normal        | Save current workspace as last session
`<leader>`+`d`  | Normal/Visual | Duplicate line or selection
`<leader>`+`S`  | Normal/Visual | Source selection (TODO: make vim only)
`<leader>`+`ml` | Normal        | Append modeline

### Text Objects

Source     | Key   | Text
------     | ----- | ------------------
commentary | `gc`  | Commented region
sideways   | `aa`  | Toggle comments over motion
sideways   | `ia`  | `change` a commented region
surround   |       |

### File Operations

Key             | Mode    | Action
-----           | :----:  | ------------------
`<leader>`+`cd` | Normal  | Switch to the directory of opened buffer (:lcd %:p:h)
`W!!`           | Command | Write as root

### Editor UI

Key             | Mode   | Action
-----           | :----: | ------------------
`<leader>`+`ts` | Normal | Toggle spell-checker (:setlocal spell!)
`<leader>`+`tl` | Normal | Toggle hidden characters (:setlocal nolist!)
`<leader>`+`th` | Normal | Toggle highlighted search (:set hlsearch!)
`<leader>`+`tw` | Normal | Toggle wrap (:setlocal wrap! breakindent!)
`g0`            | Normal | Go to first tab (:tabfirst)
`g$`            | Normal | Go to last tab (:tablast)
`gr`            | Normal | Go to previous tab (:tabprevious)
`*`             | Visual | Search selection forwards  TODO: selects up to that point?
`#`             | Visual | Search selection backwards
`<leader>`+`j`  | Normal | Next on location list
`<leader>`+`k`  | Normal | Previous on location list

### Window Management

Key            | Mode   | Action
-----          | :----: | ------------------
`q`            | Normal | Quit window (and Vim if last window. Pauses on modified buffer)
`Ctrl`+`j`     | Normal | Move to window below (\<C-w>j)
`Ctrl`+`k`     | Normal | Move to upper split (\<C-w>k)
`Ctrl`+`h`     | Normal | Move to left split (\<C-w>h)
`Ctrl`+`l`     | Normal | Move to right split (\<C-w>l)
`<leader>`+`w` | Normal | Enter window mode (\<C-w>)

Additional window mode commands (`:help windows`):

Key       | Mode   | Action
-----     | :----: | ------------------
`s`       | Normal | Horizontal (:split)
`v`       | Normal | Vertical split (:vsplit)
`o`       | Normal | Close other windows (:only)
`c`       | Normal | Closes current buffer (:close)
`d`       | Normal | Removes current buffer (:bdelete)
`H/J/K/L` | Normal | Move window to absolute left/bottom/top/right
`z`       | Normal | Close any "preview" windows that are open

### Plugin: vim-easy-align
TODO

### Plugin: Denite
`<leader>d` essentially acts like "Tell denite to..."

Key             | Mode                     | Action
-----           | :----:                   | ------------------
`<leader>d`+`r` | Normal                   | Resumes last Denite window
`<leader>d`+`f` | Normal                   | File search (recursive from cwd, and MRU)
`<leader>d`+`b` | Normal                   | Buffers
`<leader>d`+`l` | Normal                   | Location list
`<leader>d`+`q` | Normal                   | Quick fix list
`<leader>d`+`g` | Normal                   | Grep search  NOTE: searches in cwd recursively
`<leader>d`+`j` | Normal                   | Jump points
`<leader>d`+`o` | Normal                   | Outline tags
`<leader>d`+`s` | Normal                   | Sessions
`<leader>d`+`h` | Normal                   | Help  Use over :help!
`<leader>d`+`/` | Normal                   | Buffer lines
`<leader>d`+`*` | Normal                   | Match word under cursor
`<leader>`+`z`  | Normal                   | Z (jump around)
`<leader>`+`gg` | Normal/Visual            | Grep word under cursor
                | **Within _Denite_ mode** |
`Escape`        | Normal/Insert            | Toggle modes
`<C-j>`         | Insert                   | Move to next line
`<C-k>`         | Insert                   | Move to previous line
`<C-n>`         | Insert                   | Next in denite insert history
`<C-p>`         | Insert                   | Previous in denite insert history
`jk`            | Insert                   | Leave Insert mode
`Ctrl`+`y`      | Insert                   | Redraw
`r`             | Normal                   | Redraw
`'`             | Normal                   | Select
`<C-q>`         | Normal                   | Send selection/current line to quickfix list (see: help cdo)
`<C-n>`         | Normal                   | Move to next source
`<C-p>`         | Normal                   | Move to previous source
`gg`            | Normal                   | Move to first line of search
`t`             | Normal                   | Open in a new tab
`v`             | Normal                   | Open in a vertical split
`s`             | Normal                   | Open in a split
`'`             | Normal                   | Toggle mark current candidate

### Plugin: Deoplete

Key                  | Mode          | Action
-----                | :----:        | ------------------
`Enter`              | Insert        | Select completion or expand snippet
`Tab`                | Insert/select | Smart tab movement or completion
`Ctrl`+`j/k/f/b/d/u` | Insert        | Movement in completion pop-up
`Ctrl`+`g`           | Insert        | Undo completion
`Ctrl`+`l`           | Insert        | Refresh candidates
`Ctrl`+`e`           | Insert        | Cancel selection and close pop-up
`Ctrl`+`y`           | Insert        | Close pop-up

### Plugin: Commentary

Key          | Mode   | Action
-----        | :----: | ------------------
`gcc`        | Normal | Toggle single line comment
`gc{motion}` | Normal | Toggle comments over motion
`cgc`        | Normal | `change` a commented region
`gcu`        | Visual | Uncomment a commented region

### Plugin: Sideways

Key               | Mode   | Action
-----             | :----: | ------------------
`Shift` + `Left`  | Normal | Move function argument left
`Shift` + `right` | Normal | Move function argument right

### Misc Plugins

Key     | Mode          | Action
-----   | :----:        | ------------------
`<F5>`  | Normal        | Open undo tree
`<M-p>` | Normal/Insert | Access yankring after `put`

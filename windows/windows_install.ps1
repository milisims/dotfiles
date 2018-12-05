(get-item ~\AppData\Local\nvim).Delete()  # workaround because del didn't work
md -Force ~\AppData\Local\nvim-data\tmp\swap
md -Force ~\AppData\Local\nvim-data\tmp\undo
md -Force ~\AppData\Local\nvim-data\tmp\backup

# $uri = 'https://github.com/neovim/neovim/releases/download/v0.3.1/nvim-win64.zip'
# (New-Object Net.WebClient).DownloadFile(
#   $uri,
#   $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
#     "./nvim-download.zip"
#   )
# )

Copy-Item -Path dot\gitconfig -Destination ~\.gitconfig
cmd /c mklink /d $HOME\AppData\Local\nvim $PWD\vim
nvim -u NORC +'set spell' +qa

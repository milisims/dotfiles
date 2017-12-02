md ~\AppData\Local\nvim\autoload
md ~\AppData\Local\nvim-data\swap
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

Copy-Item -Path vim\* -Filter *.vim -Destination ~\AppData\Local\nvim
nvim +'PlugInstall --sync' +qa

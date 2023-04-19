# Installation
<!-- 
http://stackoverflow.com/questions/5735666/execute-bash-script-from-url
https://stackoverflow.com/questions/692000/how-do-i-write-standard-error-to-a-file-while-using-tee-with-a-pipe
-->
```shell
bash <(curl -s https://raw.githubusercontent.com/garyteh/mac-init/master/init.sh) 2>&1 | tee -a "debug-$(date +%s).log"
```

## Additional Parameter
Prepend the following to the installation command.
```shell
SKIP_INSTALL_HOMEBREW=1
SKIP_INSTALL_HOMEBREW_DEPENDENCIES=1
SKIP_SETUP_DEFAULT_SHELL=1
SKIP_INSTALL_POWERLINE_GO=1
SKIP_SETUP_MACOS_PREFERENCES=1
SKIP_CLONE_DOTFILES=1
```

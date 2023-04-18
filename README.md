# http://stackoverflow.com/questions/5735666/execute-bash-script-from-url
# https://stackoverflow.com/questions/692000/how-do-i-write-standard-error-to-a-file-while-using-tee-with-a-pipe
bash <(curl -s https://raw.githubusercontent.com/garyteh/mac-init/master/init.sh) 2>&1 | tee -a "debug-$(date +%s).log"

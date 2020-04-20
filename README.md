# http://stackoverflow.com/questions/5735666/execute-bash-script-from-url
bash <(curl -s https://raw.githubusercontent.com/garyteh/mac-init/master/init.sh)

# http://stackoverflow.com/questions/4642915/passing-parameters-to-bash-when-executing-a-script-fetched-by-curl
curl https://raw.githubusercontent.com/garyteh/mac-init/master/init.sh | bash -s arg1 arg2
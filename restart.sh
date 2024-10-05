source ~/.bashrc
cd ~
rm -f monit.sh
rm -rf sui_meta_miner
pkill monit
git clone https://github.com/suidouble/sui_meta_miner.git
cd sui_meta_miner
npm install
#监控screen脚本
echo '#!/bin/bash
while true
do
    if ! screen -list | grep -q "sui_meta"; then
        echo "Screen session not found, restarting..."
        cd ~/sui_meta_miner
        screen -dmS sui_meta bash -c "node mine.js --fomo --meta --chain=mainnet --phrase='suiprivkey1qrykv8zukh5zj624rqyzuwjur89n8mvqelqf7m2vg90safg2mw62qg8q7zn'"
    fi
    sleep 10  # 每隔10秒检查一次
done' > monit.sh
##给予执行权限
chmod +x monit.sh
nohup ./monit.sh &

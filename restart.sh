source ~/.bashrc
cd ~
source ~/.bashrc
#监控screen脚本
echo '#!/bin/bash
while true
do
    if ! screen -list | grep -q "sui_meta"; then
        echo "Screen session not found, restarting..."
        cd ~/sui_meta_miner
        screen -dmS sui_meta bash -c "node mine.js --chain=mainnet --phrase='$phrase'"
    fi
    sleep 10  # 每隔10秒检查一次
done' > monit.sh
##给予执行权限
chmod +x monit.sh
nohup ./monit.sh &

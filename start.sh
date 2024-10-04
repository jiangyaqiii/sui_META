curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm install 20

# verifies the right Node.js version is in the environment
node -v # should print `v20.17.0`

# verifies the right npm version is in the environment
npm -v # should print `10.8.2`

git clone https://github.com/suidouble/sui_meta_miner.git
cd sui_meta_miner/
npm install


# ===================================公共模块===监控screen模块======================================================================
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

# # ================================================================================================================================
# echo '[Unit]
# Description=sui_META Monitor Service
# After=network.target

# [Service]
# Type=simple
# ExecStart=/bin/bash /root/monit.sh

# [Install]
# WantedBy=multi-user.target' > /etc/systemd/system/sui_meta_monitor.service
# sudo systemctl daemon-reload
# sudo systemctl enable sui_meta_monitor.service
# sudo systemctl start sui_meta_monitor.service
# sudo systemctl status sui_meta_monitor.service




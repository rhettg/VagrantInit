useradd -m -s /bin/bash rhettg
usermod -aG adm rhettg
usermod -aG sudo rhettg

su -l rhettg -c 'cd /home/rhettg && git clone https://github.com/rhettg/dotfiles && /home/rhettg/dotfiles/install'

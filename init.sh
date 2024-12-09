#!/bin/sh

# update the system
sudo apt-get update -y && sudo apt-get upgrade -y

# download packages
for list in ./lists/*.list:
	for package in $(cat list);do sudo apt-get install $package -y;done

# oh my zsh
if find ~/.oh-my-zsh ; then
    echo "oh-my-zsh already installed!"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# java jdk23
if java -version && javac -version ; then
    echo "java already installed!"
else
    wget https://download.java.net/java/GA/jdk23/3c5b90190c68498b986a97f276efd28a/37/GPL/openjdk-23_linux-aarch64_bin.tar.gz
    sudo tar -xvzf openjdk-23_linux-aarch64_bin.tar.gz -C /opt
    rm -rf openjdk-23_linux-aarch64_bin.tar.gz
    export JAVA_HOME=/opt/jdk-23
    export PATH=$PATH:$JAVA_HOME/bin
fi

# node version manager
if node -v ; then
    echo "node already installed!"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm install 20
fi

# docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/raspbian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/raspbian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

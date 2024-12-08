#!/bin/bash

# update the system
sudo apt-get update -y && sudo apt-get upgrade -y
sudo -v

GAMES = "nsnake bastet 2048 cmatrix cbonsai sl"
TOOLS = "make git gh fzf tree bat thefuck"
UTILITIES = "neofetch mc ranger tmux lynx"
MUST_HAVE = "python3 zsh"

sudo apt-get install $MUST_HAVE $GAMES $TOOLS $UTILITIES -y
sudo -v

# java jdk23
wget https://download.java.net/java/GA/jdk23/3c5b90190c68498b986a97f276efd28a/37/GPL/openjdk-23_linux-aarch64_bin.tar.gz
sudo tar -xvzf openjdk-23_linux-aarch64_bin.tar.gz -C /opt
rm -rf openjdk-23_linux-aarch64_bin.tar.gz
echo "export JAVA_HOME=/opt/jdk-23" >> ~/.zshrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.zshrc

# node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
nvm install 20

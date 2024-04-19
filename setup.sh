if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root"
    exit -1
fi

echo >> ~/.bashrc #insert newline into .bashrc

#Setup and install dotnet (v6 & 8)
. /etc/os-release
wget https://packages.microsoft.com/config/$ID/$VERSION_ID/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
apt remove dotnet* aspnet* netstandard* -y
dpkg -i ./packages-microsoft-prod.deb
rm ./packages-microsoft-prod.deb
export DOTNET_CLI_TELEMETRY_OPTOUT=1
echo export DOTNET_CLI_TELEMETRY_OPTOUT=1 >> ~/.bashrc

apt update
apt upgrade -y
apt install build-essential g++ openjdk-17-jdk openjdk-11-jdk openjdk-8-jdk dotnet6 dotnet8 unzip python3 python3-pip python3-venv automake trash-cli clangd -y
echo export JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc

#Install Rust
bash <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y

#Install neovim, node, and cmake
snap install node --classic --channel=20
snap install --beta nvim --classic
snap install cmake --classic

#Install some language servers
npm i -g typescript typescript-language-server vscode-langservers-extracted diagnostic-languageserver # @microsoft/compose-language-service dockerfile-language-server-nodejs pyright neovim snyk-cli # Commented out servers shouldn't need to be preinstalled

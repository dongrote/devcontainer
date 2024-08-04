ARG DOTNET_SDK_VERSION=8.0
FROM mcr.microsoft.com/dotnet/sdk:$DOTNET_SDK_VERSION

ARG USERID=1000
ARG GROUPID=1000
ARG LOGNAME=dongrote
ARG HOME=/home/$LOGNAME

# download and install neovim
ADD https://github.com/neovim/neovim-releases/releases/download/v0.10.0/nvim-linux64.deb /tmp/nvim.deb
RUN dpkg -i /tmp/nvim.deb
RUN rm /tmp/nvim.deb

# download and install omnisharp-mono
ADD https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.39.11/omnisharp-linux-x64.tar.gz /tmp/omnisharp.tgz
RUN mkdir -p /opt/omnisharp
RUN tar -zxvf /tmp/omnisharp.tgz -C /opt/omnisharp/
RUN rm /tmp/omnisharp.tgz

# setup mono repository
RUN apt update && apt install -y dirmngr ca-certificates gnupg
RUN gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list

# install packages
RUN apt update && apt install -y \
  build-essential \
  luarocks \
  procps \
  mono-roslyn \
  htop

ADD .config $HOME/.config
RUN echo "alias vim=nvim" >$HOME/.bashrc
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}dev:\w\$ "' >>$HOME/.bashrc

ENV LOGNAME=$LOGNAME
ENV HOME=$HOME

# install nodejs / nvm / npm
RUN bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
RUN bash -c "source $HOME/.nvm/nvm.sh && nvm install 20"

RUN chown -R $USERID:$GROUPID $HOME

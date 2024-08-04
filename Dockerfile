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


# install packages
RUN apt update && apt install -y \
  build-essential \
  luarocks \
  procps \
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

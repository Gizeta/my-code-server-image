FROM codercom/code-server:3.10.0

SHELL ["/bin/bash", "-c"]

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg2 bsdtar build-essential libssl-dev zlib1g-dev unzip

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.0 \
    && echo "source \$HOME/.asdf/asdf.sh" >> $HOME/.bashrc

# node
ENV NODE_VERSION 16.1.0
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add nodejs \
    && sudo ln -s /usr/bin/bsdtar /usr/local/bin/tar \
    && asdf install nodejs $NODE_VERSION \
    && sudo rm /usr/local/bin/tar \
    && asdf global nodejs $NODE_VERSION

# ruby
ENV RUBY_VERSION 3.0.1
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add ruby \
    && asdf install ruby $RUBY_VERSION \
    && asdf global ruby $RUBY_VERSION

# elixir
ENV ELIXIR_VERSION 1.11.4
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add elixir \
    && asdf install elixir $ELIXIR_VERSION \
    && asdf global elixir $ELIXIR_VERSION

# rust
ENV RUST_VERSION 1.52.1
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add rust \
    && asdf install rust $RUST_VERSION \
    && asdf global rust $RUST_VERSION

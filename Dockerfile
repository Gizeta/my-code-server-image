FROM codercom/code-server:4.2.0

SHELL ["/bin/bash", "-c"]

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg2 build-essential libssl-dev zlib1g-dev unzip

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.9.0 \
    && echo "source \$HOME/.asdf/asdf.sh" >> $HOME/.bashrc

# node
ENV NODE_VERSION 17.8.0
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add nodejs \
    && asdf install nodejs $NODE_VERSION \
    && asdf global nodejs $NODE_VERSION

# ruby
ENV RUBY_VERSION 3.0.2
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add ruby \
    && asdf install ruby $RUBY_VERSION \
    && asdf global ruby $RUBY_VERSION

# elixir
ENV ELIXIR_VERSION 1.13.3-otp-24
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add elixir \
    && asdf install elixir $ELIXIR_VERSION \
    && asdf global elixir $ELIXIR_VERSION

# rust
ENV RUST_VERSION 1.59.0
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add rust \
    && asdf install rust $RUST_VERSION \
    && asdf global rust $RUST_VERSION

# Emscripten SDK
ENV EMSDK_VERSION 3.1.8
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add emsdk \
    && asdf install emsdk $EMSDK_VERSION \
    && asdf global emsdk $EMSDK_VERSION

EXPOSE 7000-9000

FROM gcr.io/kaniko-project/executor:v1.1.0 AS kaniko

FROM codercom/code-server:4.13.0

SHELL ["/bin/bash", "-c"]

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg2 build-essential libssl-dev zlib1g-dev unzip libyaml-dev

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.11.3 \
    && echo "source \$HOME/.asdf/asdf.sh" >> $HOME/.bashrc

# node
ENV NODE_VERSION 20.2.0
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add nodejs \
    && asdf install nodejs $NODE_VERSION \
    && asdf global nodejs $NODE_VERSION

# ruby
ENV RUBY_VERSION 3.2.2
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add ruby \
    && asdf install ruby $RUBY_VERSION \
    && asdf global ruby $RUBY_VERSION

# elixir
ENV ELIXIR_VERSION 1.14.5-otp-26
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add elixir \
    && asdf install elixir $ELIXIR_VERSION \
    && asdf global elixir $ELIXIR_VERSION

# rust
ENV RUST_VERSION 1.70.0
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add rust \
    && asdf install rust $RUST_VERSION \
    && asdf global rust $RUST_VERSION

# Emscripten SDK
ENV EMSDK_VERSION 3.1.41
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add emsdk \
    && asdf install emsdk $EMSDK_VERSION \
    && asdf global emsdk $EMSDK_VERSION

# Go
ENV GO_VERSION 1.20.5
RUN source $HOME/.asdf/asdf.sh \
    && asdf plugin add golang \
    && asdf install golang $GO_VERSION \
    && asdf global golang $GO_VERSION

# kaniko
COPY --from=kaniko /kaniko/ /kaniko/
COPY --from=kaniko /etc/nsswitch.conf /etc/nsswitch.conf

RUN echo "PATH=\$PATH:/kaniko" >> $HOME/.bashrc

EXPOSE 7000-9000

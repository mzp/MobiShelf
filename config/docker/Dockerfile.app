FROM ubuntu:16.10

WORKDIR /tmp

RUN apt-get update

RUN apt-get install -y build-essential curl git libssl-dev libreadline-dev zlib1g-dev libmysqlclient-dev file

ARG ruby_version

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN git clone https://github.com/jf/rbenv-gemset.git ~/.rbenv/plugins/rbenv-gemset

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN bash -i -c "rbenv install $ruby_version"

RUN bash -i -c "rbenv shell $ruby_version && gem i bundler --no-document"

WORKDIR /fumifumi

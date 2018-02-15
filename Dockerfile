FROM ubuntu:16.04
MAINTAINER Fumiaki Kato

ENV CHROME_VERSION 2.31
ENV WORKSPACE /selenium-work

RUN sed -i "s:archive.ubuntu.com:ftp.jaist.ac.jp/pub/Linux:g" /etc/apt/sources.list

RUN apt-get update -y

# prepare
RUN apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:brightbox/ruby-ng

RUN apt-get update -y

# install library and ruby
RUN apt-get install -y \
  libappindicator1 \
  fonts-liberation \
  zlib1g-dev \
  zip \
  unzip \
  ruby2.2 \
  ruby2.2-dev \
  bundler \
  wget \
  gconf-service \
  libasound2 \
  libgconf-2-4 \
  libnspr4 \
  libxss1 \
  libnss3 \
  xdg-utils \
  fonts-ipafont-gothic fonts-ipafont-mincho

# create workspace
RUN mkdir -p ${WORKSPACE} \
  && mkdir -p ${WORKSPACE}/image \
  && mkdir -p ${WORKSPACE}/install \
  && mkdir -p ${WORKSPACE}/work

# copy Gemfile
COPY script/Gemfile ${WORKSPACE}/install

# install chromedriver
RUN cd ${WORKSPACE}/install \
  && wget "https://chromedriver.storage.googleapis.com/${CHROME_VERSION}/chromedriver_linux64.zip" \
  && unzip chromedriver_linux64.zip \
  && chmod +x chromedriver \
  && mv -f chromedriver /usr/local/share/chromedriver \
  && ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver \
  && ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

# install google-chrome
RUN cd ${WORKSPACE}/install \
  && touch /etc/default/google-chrome \
  && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
  && dpkg -i google-chrome-stable_current_amd64.deb

# bundle install
RUN cd ${WORKSPACE}/install \
  && bundle install

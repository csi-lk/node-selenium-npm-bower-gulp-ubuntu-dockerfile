# node-selenium-npm-bower-gulp-ubuntu-dockerfile
FROM ubuntu:14.04
MAINTAINER Callum Silcock "callum@webanyti.me"
RUN	sudo apt-get update
# Get the basics
RUN	sudo apt-get install --yes git wget curl build-essential screen
# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
# Install global NPM repos
RUN sudo npm install -g gulp ionic protractor bower
# Add Google Chrome's repo to sources.list
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list
# Install Google's public key used for signing packages (e.g. Chrome)
# (Source: http://www.google.com/linuxrepositories/)
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sudo apt-get update
RUN sudo apt-get -y install default-jre
RUN sudo npm install protractor -g
RUN sudo webdriver-manager update
RUN sudo ln /usr/lib/node_modules/protractor/selenium/chromedriver /usr/bin/chromedriver
# Install Google Chrome:
RUN sudo apt-get -y install libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4
RUN sudo apt-get -y install google-chrome-stable

# Dependencies to make "headless" chrome/selenium work:
RUN sudo apt-get -y install xvfb gtk2-engines-pixbuf
RUN sudo apt-get -y install xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable
# Capture screenshots of Xvfb display:
RUN sudo apt-get -y install imagemagick x11-apps
# Make sure that Xvfb starts everytime the box/vm is booted:
RUN echo "Starting X virtual framebuffer (Xvfb) in background..."
RUN Xvfb -ac :99 -screen 0 1280x1024x16 &
RUN export DISPLAY=:99
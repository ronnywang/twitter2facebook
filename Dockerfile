FROM ubuntu
RUN apt-get update
RUN apt-get install -y systemd-sysv curl unzip chromium-chromedriver chromium-browser
RUN apt-get install -y python3-pip
RUN apt-get install -y openssh-server
RUN apt-get install -y fonts-noto-cjk
RUN apt-get install -y sqlite3
RUN mkdir /var/run/sshd /root/.config/ /root/.config/twitter2facebook/ /root/.ssh/
RUN sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config
COPY . /srv/twitter2facebook
COPY config.ini /root/.config/twitter2facebook/config.ini
RUN sh -c 'cd /srv/twitter2facebook; pip3 install -r requirements.txt'
RUN echo 'CREATE TABLE entry (id INTEGER PRIMARY KEY AUTOINCREMENT, twitter_id TEXT UNIQUE, created_at INTEGER);' | sqlite3 /root/.config/twitter2facebook/entry.sqlite3
CMD ["/usr/sbin/sshd", "-D"]

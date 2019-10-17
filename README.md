# twitter2facebook

Sync Twitter's timeline to Facebook's without Facebook API by posting to `mbasic.facebook.com`.

# Installation

* On your server (any OS with docker & git installed)
    1. git clone https://github.com/ronnywang/twitter2facebook
    2. cd twitter2facebook/
    3. cp config.sample.ini config.ini
    4. (Edit config.ini)
       * https://developer.twitter.com/en.html
       * https://sentry.io
    5. docker build . -t twitter2facebook
    6. docker create --publish 127.0.0.1:10022:22 -t -i --name c-twitter2facebook twitter2facebook
    7. docker start c-twitter2facebook
    8. (Configure ssh login)
       * docker cp your-public-key-file c-twitter2facebook:/root/.ssh/authorized_keys
       * docker exec c-twitter2facebook chown root:root /root/.ssh/authorized_keys
* On your desktop
    1. ssh your-server -L10022:localhost:10022
    2. ssh root@localhost -p 10022 -i your-private-key-file -Y
       * chromium-browser --no-sandbox --disable-gpu --user-data-dir=/root/.config/chromium https://facebook.com/
       * (login your facebook account in the browser)
    3. disconnect 
* On your server
    1. docker exec c-twitter2facebook env PYTHONIOENCODING=utf-8 python3 /srv/twitter2facebook/twitter2facebook.py
    2. (check if your tweets sync to facebook)
    3. (add the command to your crontab)

```* * * * * root docker exec c-twitter2facebook env PYTHONIOENCODING=utf-8 python3 /srv/twitter2facebook/twitter2facebook.py ```

# License

See [LICENSE](LICENSE).

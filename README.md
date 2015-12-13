## This project is still work in progress
**Don't use this in production**

## building and running this image
    docker pull evolutio/dockerding
    docker run -d -p 3000:3000 --privileged --name dockerding -v /var/run/docker.sock:/var/run/docker.sock evolutio/dockerding

after this you can visit the webinterface on http://localhost:3000

## Screenshots
[http://imgur.com/a/oUqlB](http://imgur.com/a/oUqlB)
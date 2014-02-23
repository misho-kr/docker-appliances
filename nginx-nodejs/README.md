NodeJS Server with Nginx Frontend
=================================

Start and run node applications with this Docker container. Incoming
connections are handled by nginx, and node takes care of processing
the requests and generating the responses.

[Supervisord](http://supervisord.org) is in change of managing the processes.

## List of installed components

* Nginx server
* Node server
* SSH server

#### Start the Node server

Run a Docker container with the command below. Note the optional explicit
mapping of container ports. Without this explicit port mapping Docker will
pick  randon port numbers.

```
$ docker run -d -p 2020:22 -p 80:80 -p 8080:8080 -name=nginx-nodejs -h=nginx-nodejs misho1kr/nginx-nodejs
```

## TODO items

* Setup nginx to accept HTTPS connections
* Add logrotate to keep the logfiles in check
* Finish this README


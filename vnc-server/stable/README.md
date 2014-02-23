Stable setup
============

Improved version of the [VNC Server in Docker container](https://github.com/misho-kr/docker-appliances/tree/master/vnc-server).

* All important process are monitored and controled with [Supervisord](http://supervisord.org)
* If process terminates prematurely (due to bug or other reason) it will be restarted immediately

## How to use it

#### Start the VNC server

Run a Docker container with the command below. Note the VNC server port
(5900) is mapped to the same external port to facilitate the use of vnc
viewers. Without this explicit port mapping Docker will pick a randon port
number.

```
$ docker run -d -p 5900:5900 -name=vnc-server -h=vnc-server misho1kr/vnc-server-stable
```

#### Connect with VNC client

There are many choices for vnc client, the example below uses
[Vinagre](https://wiki.gnome.org/Apps/Vinagre). Assuming the Docker container
is running on host _docker-host_:

```
$ vinagre docker-host:0
```

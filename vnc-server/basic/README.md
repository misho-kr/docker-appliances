Basic setup
===========

This server has the simplest setup:

* The top level processes -- X server and VNC server, are started by the Docker daemon when the container boots up
* If any of them terminates (for whatever reason) the container has to be restarted
* Termination of the window manager (openbox) will cause the X server to exit, which too will render the container useless

## How to use it

#### Start the VNC server

Run a Docker container with the command below. Note the VNC server port
(5900) is mapped to the same external port to facilitate the use of vnc
viewers. Without this explicit port mapping Docker will pick a randon port
number.

```
$ docker run -d -p 5900:5900 -name=vnc-server -h=vnc-server misho1kr/vnc-server-basic
```

#### Connect with VNC client

There are many choices for vnc client, the example below uses
[Vinagre](https://wiki.gnome.org/Apps/Vinagre). Assuming the Docker container
is running on host _docker-host_:

```
$ vinagre docker-host:0
```


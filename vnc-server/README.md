VNC Server
==========

This image will run a minimal headless X server and vnc server to listen for
and accept VNC conenctions.

* Only _xterm_ is installed to demonstrate the use of X clients
* Window manager and panel are added to make the visual appearance a bit more appealing

## How to use it

#### Start VNC Server

Run a Docker container with the command below. Note the VNC server port (5900)
is mapped to the same external port to facilitate the use of vnc viewers. Without
this explicit port mapping Docker will pick a randon port number.

```
$ docker run -p 5900:5900 -name=vnc-server -h=vnc-server misho1kr/vnc-server
```

#### Connect with VNC Client

There are many choices for vnc client, the example below uses
[Vinagre](https://wiki.gnome.org/Apps/Vinagre):

```
$ vinagre docker.vmnet122.wonder.land:0
```

#### Additional Software

More software packages can be installed as needed, either by adding to the
Dockerfile and rebuilding the image, or by directly installing the software
inside the container and then commiting the image.

## List of installed components

### Minimal X server

[Xvfb](http://en.wikipedia.org/wiki/Xvfb) is an implementation of X server that 
runs without real graphical hardware like video card, keyboard abnd mouse. It
does implement the X11 protocol which allows X clients like _xterm_, or
_firefox_, to draw on it.

#### Window Manager

[Openbox](http://openbox.org) is fast windows manager with box style themes. The
image is set up to use _Clearlooks-Olive_ theme.

#### Panel

[fbpanel](http://fbpanel.sourceforge.net) is a lightweight desktop panel

#### X11Vnc

Finally the piece of software that connects the vnc viewer to the X server.
It will perform simple authentication with the password that is hardcoded in
the Dockerfile. The setting is very insecure because:

* Anyone can look in the Dockerfile and see the initial password
* The VNC protocol goes over unencrypted communication channel

## TODO items

* Setup the VNC connection over ssh channel to provide secure communication
* Add more desktop tools
* Customize the user interface

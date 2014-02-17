VNC Server
==========

The Docker containers will run a minimal headless X server and a vnc server.
Each folder contains _Dockerfile_ that will build Docker image with VNC server
that is setup in some perticular way -- basic setup, with supervisor, and
one using encrypted VNC channel.

* Only _xterm_ is installed to demonstrate the use of X clients
* Window manager and panel are added to make the visual appearance a bit more appealing

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

#### Additional Software

More software packages can be installed as needed, either by adding to the
Dockerfile and rebuilding the image, or by directly installing the software
inside the container and then commiting the image.

## TODO items

* ~~Setup the VNC connection over ssh channel to provide secure communication~~
* Add more desktop tools
* Customize the user interface

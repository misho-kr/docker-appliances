Basic setup
===========

This server has the simplest setup:

* The top level processes -- X server and VNC server processes, are started by the
  Docker daemon when the container boots up
* If any of them terminates (for whatever reason) the container has to be restarted
* Termination of the window manager (openbox) will cause the X server to exit, which
  too will render the container useless
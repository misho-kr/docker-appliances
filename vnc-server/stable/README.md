Stable setup
============

Improved version of the [VNC Server in Docker container](https://github.com/misho-kr/docker-appliances/tree/master/vnc-server).

* All important process are under the monitoring and control of [Supervisord](http://supervisord.org)
* If a process terminates prematurely (due to bug or other reason) it will be restarted immediately

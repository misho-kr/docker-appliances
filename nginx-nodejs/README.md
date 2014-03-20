NodeJS Server with Nginx Frontend
=================================

Run NodeJS applications with this Docker container. Incoming connections
are handled by nginx server, and the node server takes care of processing
the requests and generating the responses.

The following components are installed in the container:

* Nginx server set up as reverse proxy
* Node server to run your NodeJS application
* SSH server to enable secure remote login with public key authentication
* [Supervisord](http://supervisord.org) to managing the processes
* Logrotate is run periodically to check and rotate nginx access logfile

#### Startint the Docker Container

Use command below. Note the (optional) explicit mapping of container ports.
Without this explicit port mapping Docker will pick randon port numbers.

```
$ docker run -d -p 2020:22 -p 80:80 -p 8080:8080 -name=nginx-nodejs -h=nginx-nodejs misho1kr/nginx-nodejs
```

### Nginx Frontend for the Node Server

The Node server is great for running web applications while Nginx excels at
handling tasks like terminating SSL connections and load-balancing traffic
between multiple backend servers. For more detailed explanation of the
advantages of running Nginx in front of Node server search the Internet.

### SSH Login

The public RSA key is built in the Docker container. To pass the
authentication you need the corresponding private RSA which can be obtained
from the [GitHub repo](https://github.com/misho-kr/docker-appliances/blob/master/nginx-nodejs/nginx-nodejs-server.key)
to be used with the _ssh_ command:

```
$ ssh -p 2020 -i nginx-nodejs-server.key root@docker-container-hostname
```

Needless to say, this pre-built public RSA key should be replaced. Replace
the RSA keypair with your keys and build the container with the _Dockerfile_,
or use the [_ssh-copy-id_](http://www.manpager.com/linux/man1/ssh-copy-id.1.html)
command to override the key of existing Docker container.

### Logfile rotation

Most of the components in the Docker container are set up to log to stdout and/or
stderr which are handled by supervisord. However nginx does not allow to direct
the access log to stdout, the only options are plain file or syslog.

Logrotate runs at regular inervals to check the nginx access logfile and rotate
it when necessary.

## TODO items

* Setup nginx to accept HTTPS connections
* ~Add logrotate to keep the logfiles in check~
* Have the html page display something ... better
* Finish this README

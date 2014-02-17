Secure setup
============

Improved implementation of 
[stable Docker container running VNC server](https://github.com/misho-kr/docker-appliances/tree/master/vnc-server/stable)
with enhanced security features.

## SSH server

This Docker container provides SSH service that is used to create
secure encrypted channel between the client and server, and to allow
passwordless login with RSA key. Of course, it can be used to simply
login to running Docker container with _ssh_.

## Encrypted traffic

The integrity and confidentiality of the traffic between the VNC viewer
and the server is protected with encryption. The communication channel is
established in two steps:

1. SSH tunnel is created between the host where the viewer is started
and the Docker container running the secure VNC server
1. The VNC viewer connects to the VNC server through the SSH tunnel

## Public key authentication

The secure vnc server can be accessed only if the caller has its public
RSA key uploaded to the Docker server.

## How to upload the public RSA key

There several ways to execute this operation:

* If you are building Docker image using the _Dockefile_ in this folder,
first copy your public RSA key to file named __vnc-server-key.pub__,
then run the _docker build_ command. The publuc key will be "baked" into
the image.

* Assuming you have downloaded the
[trusted Docker image](https://index.docker.io/u/misho1kr/vnc-secure)
from the [Docker Registry](https://index.docker.io), first you have to acquire
the private RSA key that was preloaded into the image. Download the file
[__vnc-server-key__](https://raw2.github.com/misho-kr/docker-appliances/master/vnc-server/secure/vnc-server-key)
from the
[source GitHub repository](https://github.com/misho-kr/docker-appliances/tree/master/vnc-server/secure).
The next step is to replace the existing public RSA key in the Docker container
with your own key.
  * You could edit the file containing the authorized public keys by hand.
    Login to the Docker container with key that was just downloaded, then
    edit the file *.ssh/authorized_keys*. Delete the existing key, and paste
    your public RSA key inside.
  * Or just override the file containing the authorized public keys with
    your public RSA key. Use the _scp_ command and the private key from the
    GitHub repository to authenticate, and copy over your key.

```
$ wget https://raw2.github.com/misho-kr/docker-appliances/master/vnc-server/secure/vnc-server-key
...
2014-02-17 02:31:13 (18.3 MB/s) - ‘vnc-server-key’ saved [1679/1679]

$ docker run -d -p 2020:22 -name="vnc-secure" -h="vnc-secure" misho1kr/vnc-secure
9f06514c19a23fa85201203c893d4dac1affa15dd98b4b513d54b898fb6bfc7b
$ scp -P 2020 $HOME/.ssh/id_rsa.pub root@docker-host:.ssh/authorized_keys 
id_rsa.pub                                            100%  228     0.2KB/s   00:00    
$ ssh -p 2020 root@localhost 
Last login: ... from ...
[root@vnc-secure ~]#
```

## How to connect to the secure VNC server

Create SSH tunnel then point the vnc viewer to it. If the Docker container
is running on host _docker-host_, and the firewall is configured to allow
incoming connections on port 5900/tcp, then the following commands will do:

```
$ ssh -L 5900:localhost:5900 docker-host
Last login: ... from ...

# open new terminal and run
$ vinagre localhost:0
```

If you are using _vinagre_ as vnc viewer, it supports SSH tunneling so you
don't have to create the tunnel in separate step. Make sure to check the box
_Use host ... as a SSH tunnel_.

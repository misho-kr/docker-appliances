Containerized Skype Client
==========================

[Skype](http://skype.com) is a popular IM program that provides secure (as secure as it can get in today's world) chat, phone and video communication. It offers free and/or low-cost calls between computers and regular phones, and it is available on Mac, Windows and Lunux.

Running Skype on Lunux a bit annoying because the native version is significantly behind the Mac and Windows versions in terms of features. But the worse part is that Skype offers only 32-bit version of the binaries. So on most Linux machines, which are predominanlty 64-bit, one has to install a significant number of 32-bit supporting libraries and tools just for the privilege to install the Skype client.

This project is an attempt to lessen the pain of running the Skype client on Linux by wrapping it in Docker container. Everything required to run Skype is installed inside the container while the host OS is not burdened with unnecessary packages.

## Implementation

* The Docker container runs SSH server
* Public key authentication is used to verify incoming connections
* Remote logins should have X11 tunneling activated 
* Upon login user will start the Skype client

The method implement here to run Skype client in Docker container is just an experiment. There may be better ways to achive the same goal. At present video and audio are not enabled, only IM with text messages.

## SSH server

This Docker container runs SSH server that is used to create secure channel between the client and server, and to allow passwordless login with RSA key.

## Public key authentication

Logins to the Docker container to start the Skype client are possible only if the caller has its public RSA key uploaded to the Docker server. Here are two different ways to get this done.

* If you are building Docker image using the _Dockefile_ in this folder, first copy your public RSA key to a file named __skype-client-key.pub__, then run the _docker build_ command. The publuc key will be "baked" into the image.

* If you have downloaded the [trusted Docker image](https://index.docker.io/u/misho1kr/skype-client) first you have to acquire the private RSA key that was preloaded into the image. Download the file [__skype-client-key__](https://raw2.github.com/misho-kr/docker-appliances/master/skype-client/secure/skype-client-key) from this GitHub repository and use it replace the public RSA key in the Docker container with your own key. 

<br/>
    
    $ wget https://raw2.github.com/misho-kr/docker-appliances/master/skype-client/secure/skype-client-key
    ...
    2014-04-15 02:31:13 (18.3 MB/s) - ‘vnc-server-key’ saved [1679/1679]
    
    $ docker run -d -p 2020:22 -name="skype-client" -h="skype-client" misho1kr/skype-client
    9f06514c19a23fa85201203c893d4dac1affa15dd98b4b513d54b898fb6bfc7b
    $ scp -P 2020 $HOME/.ssh/id_rsa.pub root@docker-host:.ssh/authorized_keys
    id_rsa.pub                                            100%  228     0.2KB/s   00:00
    $ rm skype-client-key
    $ ssh -p 2020 root@localhost
    Last login: ... from ...
    [root@skype-client ~]#

## Starting Skype Client

First make sure that the public key for login to the container is available (either your own of the one from the GitHub repo -- see above). The execute the following simple steps:

1. Run or start the Docker container
1. Login with SSH and invoke "skype"

It takes a bit of typing on the keyboard but that can be alleviated with aliases:

    $ alias "skype-start=docker run -d -p 2020:22 -name=skype-client -h=skype-client misho1kr/skype-client"
    $ alias "skype=ssh -p 2020 root@localhost skype"
    $
    $ skype-start && skype
    $ 9f06514c19a23fa85201203c893d4dac1affa15dd98b4b513d54b898fb6bfc7b




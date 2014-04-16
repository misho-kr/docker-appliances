Containerized Skype Client
==========================

[Skype](http://skype.com) is a popular IM program that provides secure (as secure as it can get in today's world) chat, phone and video communication. It offers free and/or low-cost calls between computers and regular phones, and it is available on Mac, Windows and Lunux.

Running Skype on Lunux a bit annoying because the native version is significantly behind the Mac and Windows versions in terms of features. But the worse part is that Skype offers only 32-bit version of the binaries. So on most Linux machines, which are predominanlty 64-bit, one has to install a significant number of 32-bit supporting libraries and tools just for the privilege to install the Skype client.

This project is an attempt to lessen the pain of running the Skype client on Linux by wrapping it in Docker container. Everything required to run Skype is installed inside the container while the host OS is not burdened with unnecessary packages.

## Implementation

* The Docker container runs a SSH server
* Public key authentication is used to verify incoming connections
* Remote logins should have X11 tunneling activated 
* Upon login user has to start the Skype client

The method implement here to run Skype client in Docker container is just an experiment. There may be better ways to achive the same goal. At present video and audio are not enabled, only IM with text messages.

## SSH server

This Docker container runs SSH server that is used to create secure channel between the client and server, and to allow passwordless login with RSA key.

## Public key authentication

Logins to the Docker container to start the Skype client are possible only if the caller has its public RSA key uploaded to the Docker server. Here are two different ways to get this done.

* If you are building Docker image using the _Dockefile_ in this folder, first copy your public RSA key to a file named __skype-client-key.pub__, then run the _docker build_ command. The publuc key will be "baked" into the image.

* If you have downloaded the [trusted Docker image](https://index.docker.io/u/misho1kr/skype-client) first you have to acquire the private RSA key that was preloaded into the image. Download the file [__skype-client-key__](https://raw2.github.com/misho-kr/docker-appliances/master/skype-client/secure/skype-client-key) from this GitHub repository and use it replace the public RSA key in the Docker container with your own key. 

<br/>
    
    $ docker run -d -t -p 2022:22 --name=skype-client --hostname=skype-client misho1kr/skype-client
    c9552724200ce50e80e57820ce36e850eacfc2ae86e295a24a96591b9443b675

    $ wget https://raw2.github.com/misho-kr/docker-appliances/master/skype-client/secure/skype-client-key
    ...
    2014-04-15 02:31:13 (18.3 MB/s) - ‘vnc-server-key’ saved [1679/1679]
    
    $ scp -P 2022 -i skype-client-key $HOME/.ssh/id_rsa.pub root@localhost:.ssh/authorized_keys
    id_rsa.pub                                            100%  228     0.2KB/s   00:00
    $ rm skype-client-key

    $ ssh -p 2022 -X root@localhost skype

* The above procedures assumes the public RSA key is in your home directory. If that is not the case and instead [ssh agnet forwarding](https://help.github.com/articles/using-ssh-agent-forwarding) is used then _ssh-copy-id_ command can install your public key. But it requires a little bit of help to enable it to login to the container, and it has the effect that it _adds_ your public key but it _does not _replace_ the re-loaded key.

    $ ssh-add skype-client-key
    Identity added: skype-client-key (skype-client-key)
    $ ssh-copy-id -p 2022 root@localhost
    /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

    Number of key(s) added: 1

    Now try logging into the machine, with:   "ssh -p '2022' 'root@localhost'"
    and check to make sure that only the key(s) you wanted were added.

    $ ssh-add -d skype-client-key
    Identity removed: skype-client-key ( RSA key for passwordless login to Skype client)
    $ ssh -p 2022 -X root@localhost skype

## Skype Client

To start the Skype client execute these two simple steps:

1. Run or resume the Docker container
1. Login with SSH and invoke "skype"

It takes a bit of typing but that can be alleviated with aliases that cab be placed in _HOME/.bashrc_.

    $ alias "skype-run=docker run -d -t -p 2022:22 --name=skype-client --hostname=skype-client misho1kr/skype-client"
    $ alias "skype-stop=docker stop skype-client"
    $ alias "skype-delete=docker rm skype-client"
    $ alias "skype=ssh -p 2022 -X root@localhost skype"
    $
    $ skype-run && skype
    $ 9f06514c19a23fa85201203c893d4dac1affa15dd98b4b513d54b898fb6bfc7b

## TODO

* Take care of the error messages related to missing sound card emitted by the Skype client
* Enable access the sound card on the host machine so the Skype clinent can make calls
* What would it take to enable video calls?
* Is there better way to start a Skype client in Docker container and access it w/o ssh login and X11 forwarding?

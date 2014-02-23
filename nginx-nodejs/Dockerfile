# --------------------------------------------------------------------
#  Nginx + NodeJS server, and SSHD, with supervisord
#
# * Nginx server is listening to port 80
# * Node server is accessible at port 8080
# * All servers are started and controlled by supervisord
# * Login authentication by public-key (my-ssh-key.pub)
# --------------------------------------------------------------------

FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>

# Install ---------------------------------

RUN yum install -y nodejs npm nginx openssh-server supervisor

# Configure SSH ---------------------------

RUN ssh-keygen -t rsa   -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ""
RUN ssh-keygen -t ecdsa -b  521 -f /etc/ssh/ssh_host_ecdsa_key -N ""

ADD nginx-nodejs-server.pubkey  /root/.ssh/authorized_keys
RUN chown root:root             /root/.ssh/authorized_keys
RUN chmod 600		            /root/.ssh/authorized_keys

# Configure NodeJS app --------------------

ADD app /src
RUN cd /src && npm install

# Configure Nginx -------------------------

RUN cp /etc/nginx/nginx.conf{,.original}
ADD nginx.conf          /etc/nginx/

# Configure Supervisord -------------------

ADD supervisord.conf          	/etc/supervisord.conf
ADD supervisord.sshd.conf       /etc/supervisord.d/
ADD supervisord.nodejs.conf     /etc/supervisord.d/
ADD supervisord.nginx.conf      /etc/supervisord.d/

# Run -------------------------------------

ENV PORT	8080

EXPOSE 22 80 8080

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]

# --------------------------------------------------------------------
# EOF

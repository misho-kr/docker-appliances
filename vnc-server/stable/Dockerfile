# Docker image of simple VNC server
# ---------------------------------------------------
 
FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>

# Install vnc and X server packages
RUN yum install -y supervisor x11vnc openbox fbpanel xorg-x11-server-utils xterm dejavu-sans-fonts dejavu-serif-fonts

# Create vnc password
RUN mkdir /.vnc && x11vnc -storepasswd vnc-passwd ~/.vnc/passwd
 
# Setup minimal X server
ADD openbox.autostart /.config/openbox/autostart
ADD openbox.rc.xml /.config/openbox/rc.xml

RUN mkdir /.config/fbpanel && cp /usr/share/fbpanel/default /.config/fbpanel/default

# Configure supervisord
ADD supervisor.conf /etc/
 
# VNC port for display :1
EXPOSE 5900

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor.conf" ]

# ENV LC_ALL      en_US.UTF-8

# ---------------------------------------------------
# eof

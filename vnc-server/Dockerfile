# Docker image of simple VNC server
# ---------------------------------------------------
 
FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>
 
RUN yum install -y x11vnc openbox fbpanel xterm dejavu-sans-fonts dejavu-serif-fonts
 
# Setup vnc password
RUN mkdir /.vnc && x11vnc -storepasswd vnc-password ~/.vnc/passwd
 
# Prepare minimal X server
ADD startXvfb.sh startXvfb.sh
ADD openbox.autostart /.config/openbox/autostart
ADD openbox.rc.xml /.config/openbox/rc.xml

RUN mkdir /.config/fbpanel && cp /usr/share/fbpanel/default /.config/fbpanel/default

# Expose vnc port of display :1 and run
EXPOSE 5900
 
CMD [ "/startXvfb.sh" ]

# ---------------------------------------------------
# eof

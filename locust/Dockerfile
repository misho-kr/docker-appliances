# --------------------------------------------------------------------
#  Locust -- user load testing tool.
#
# * Locust Web-based UI is listening to port 80
# --------------------------------------------------------------------

FROM            fedora
MAINTAINER      Misho Krastev <misho.kr@gmail.com>

# Install ---------------------------------

RUN yum install -y python python-devel python-pip python-flask \
    python-msgpack python-jinja2 python-gevent python-requests \
    python-greenlet python-zmq \
    libevent gcc gcc-c++ file which

RUN pip install locustio

# Run -------------------------------------

EXPOSE 8089

VOLUME  /tests
WORKDIR /tests

ENTRYPOINT  [ "/usr/bin/locust", "--host" ]
# CMD [ "--host" ]

# --------------------------------------------------------------------
# EOF

FROM caioquirino/docker-cloudera-quickstart

COPY setup.sh /tmp/context/
COPY startup.sh /usr/bin/

WORKDIR /tmp/context

RUN ./setup.sh

WORKDIR /

CMD startup.sh; cdh_startup_script.sh
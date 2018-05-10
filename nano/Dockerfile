FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV NANO_VERSION=2.9.6
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install \
  ncurses-devel

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

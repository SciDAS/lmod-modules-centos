FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV GIT_VERSION=2.17.0
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install \
  zlib-devel \
  libcurl-devel \
  perl-devel

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

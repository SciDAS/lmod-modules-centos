FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV TRIMMOMATIC_VERSION=0.36
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install java-1.8.0-openjdk-headless

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

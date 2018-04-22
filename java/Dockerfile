FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV JAVA_VERSION=1.8.0_171
ENV LMOD_MODULE_DIR=/opt/apps/Linux

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

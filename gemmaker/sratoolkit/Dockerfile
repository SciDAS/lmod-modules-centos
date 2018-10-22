FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV TOOLKIT_VERSION=2.8.2
ENV LMOD_MODULE_DIR=/opt/apps/Linux

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

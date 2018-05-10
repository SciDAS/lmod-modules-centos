FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV HISAT2_VERSION=2.1.0
ENV LMOD_MODULE_DIR=/opt/apps/Linux

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

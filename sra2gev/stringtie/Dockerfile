FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV STRINGTIE_VERSION=1.3.3b
ENV LMOD_MODULE_DIR=/opt/apps/Linux

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

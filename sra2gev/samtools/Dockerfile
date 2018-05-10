FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV SAMTOOLS_VERSION=1.6
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install zlib-devel bzip2-devel xz-devel

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

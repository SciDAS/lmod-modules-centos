FROM lmod.base
MAINTAINER Cole McKnight<cbmckni@clemson.edu>

ENV SCREEN_VERSION=4.2.0
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install make autoconf automake ncurses-devel

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

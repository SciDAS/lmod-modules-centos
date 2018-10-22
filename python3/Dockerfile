FROM lmod.base
MAINTAINER Cole McKnight <cbmckni@clemson.edu>

ENV PYTHON3_VERSION=3.7.0
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install yum-utils make wget

RUN yum-builddep -y python

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

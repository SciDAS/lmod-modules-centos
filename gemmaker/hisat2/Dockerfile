FROM lmod.base
MAINTAINER Cole McKnight <cbmckni@clemson.edu>

ENV HISAT2_VERSION=2.1.0
ENV LMOD_MODULE_DIR=/opt/apps/Linux

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

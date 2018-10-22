FROM lmod.base
MAINTAINER Cole McKnight <cbmckni@clemson.edu>

ENV FASTQC_VERSION=0.11.7
ENV JAVA_VERSION=1.8.0_181
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN yum -y install java-1.8.0-openjdk-headless

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

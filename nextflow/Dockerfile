FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV NEXTFLOW_VERSION=0.31.0
ENV JAVA_VERSION=1.8.0_181
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN URL=$(curl -s https://lv.binarybabel.org/catalog-api/java/jdk8.txt?p=downloads.tgz) \
  && TAR_GZ_FILE=$(echo $URL | rev | cut -d '/' -f 1 | rev) \
  && curl -k -LOH 'Cookie: oraclelicense=accept-securebackup-cookie' "${URL}" \
  && tar -xzf $TAR_GZ_FILE \
  && echo "export JAVA_HOME=/$JAVA_VERSION" > /etc/profile.d/java.sh \
  && echo "export JRE_HOME=/jdk$JAVA_VERSION/jre" >> /etc/profile.d/java.sh \
  && echo "export PATH=$PATH:/jdk$JAVA_VERSION/bin:/jdk$JAVA_VERSION/jre/bin" >> /etc/profile.d/java.sh

RUN ls /jdk$JAVA_VERSION/bin

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

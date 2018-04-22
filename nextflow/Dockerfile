FROM lmod.base
MAINTAINER Michael J. Stealey <stealey@renci.org>

ENV NEXTFLOW_VERSION=0.28.0
ENV LMOD_MODULE_DIR=/opt/apps/Linux

RUN URL=$(curl -s https://lv.binarybabel.org/catalog-api/java/jdk8.txt?p=downloads.tgz) \
  && TAR_GZ_FILE=$(echo $URL | rev | cut -d '/' -f 1 | rev) \
  && curl -LOH 'Cookie: oraclelicense=accept-securebackup-cookie' "${URL}" \
  && tar -xzf $TAR_GZ_FILE \
  && echo "export JAVA_HOME=/jdk1.8.0_171" > /etc/profile.d/java.sh \
  && echo "export JRE_HOME=/jdk1.8.0_171/jre" >> /etc/profile.d/java.sh \
  && echo "export PATH=$PATH:/jdk1.8.0_171/bin:/jdk1.8.0_171/jre/bin" >> /etc/profile.d/java.sh

COPY lmod-build.sh /lmod-build.sh

ENTRYPOINT ["/lmod-build.sh"]

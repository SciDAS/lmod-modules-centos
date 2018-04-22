FROM centos:7
MAINTAINER Michael J. Stealey <stealey@renci.org>

RUN yum -y group install "Development Tools" \
  && yum -y install \
    wget \
    which \
    sudo \
    tree

VOLUME ["/input", "/output"]

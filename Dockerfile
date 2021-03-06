# Docker file to create Arachni container
# Created by Vilius

FROM ubuntu:latest
MAINTAINER vilius

ENV VERSION_FRAMEWORK 1.4
ENV VERSION_ARACHNI $VERSION_FRAMEWORK-0.5.10
# ENV IPAddress 0.0.0.0

RUN apt-get -qq update && \
apt-get install -yq  wget ruby bash && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
cd /opt && \
wget https://github.com/Arachni/arachni/releases/download/v$VERSION_FRAMEWORK/arachni-$VERSION_ARACHNI-linux-x86_64.tar.gz && \
tar xvzf arachni-$VERSION_ARACHNI-linux-x86_64.tar.gz && \
rm -f arachni-$VERSION_ARACHNI-linux-x86_64.tar.gz && \
ln -sf /opt/arachni-$VERSION_ARACHNI /opt/arachni && \
useradd -m -s /bin/sh user && \
mkdir /work && \
chown -R user /work /opt/arachni-$VERSION_ARACHNI && \
echo “Success”

USER user

ENV PATH /opt/arachni/bin:$PATH

VOLUME [“/work”]
EXPOSE 7331
# WORKDIR /
CMD /bin/bash
# CMD [“/opt/arachni/bin/arachni_rpcd”,“–address”,“0.0.0.0”]


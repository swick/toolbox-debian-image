FROM docker.io/library/debian:testing

ENV NAME=debian-toolbox VERSION=unstable
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Base image for creating Debian sid toolbox containers" \
      maintainer="Debarshi Ray <rishi@fedoraproject.org>"

RUN apt update

RUN apt -y upgrade

COPY extra-packages /
RUN apt -y install $(cat extra-packages | xargs)
RUN rm /extra-packages

RUN sed -i "s/nullok_secure/nullok/" /etc/pam.d/common-auth

RUN apt clean

RUN echo VARIANT_ID=container >> /etc/os-release
RUN touch /etc/localtime

CMD /bin/sh

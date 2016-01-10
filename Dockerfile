FROM mndrix/swipl:7.3.14

MAINTAINER Raivo Laanemets version: 0.1

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -o Dpkg::Options::="--force-confold" install -y git make

ADD Makefile /tests/Makefile

WORKDIR /tests

CMD ["make", "test"]

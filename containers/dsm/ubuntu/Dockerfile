FROM ubuntu:18.04
RUN mkdir /app

ENV LANG C.UTF-8

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get -y install apt-utils

RUN apt-get -y install \
  curl \
  unzip

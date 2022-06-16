FROM ubuntu:latest
COPY . /opt/cccedict2json

RUN \

  #install java
  apt-get update \
    && \
  apt-get install -y --no-install-recommends apt-utils software-properties-common \
    && \
  apt-get install -y -qq --no-install-recommends \
    wget \
    unzip \
    default-jdk \
    default-jre \
    && \
  java -version \
    && \
  echo "installed java" \
    && \
  
  #download and extract cedict_ts.u8
  cd /opt/cccedict2json \
    && \
  wget -O cedict_ts.u8.zip https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.zip \
    && \
  unzip cedict_ts.u8.zip cedict_ts.u8 \
    && \
  
  #run cccedict2json.jar
  mkdir /opt/cccedict2json/output \
    && \
  java -jar cccedict2json.jar /opt/cccedict2json/cedict_ts.u8 /opt/cccedict2json/output

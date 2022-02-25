FROM ubuntu:latest
RUN apt update
RUN apt upgrade -y
RUN apt install apt-transport-https curl wget gnupg -yqq
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
RUN apt update

RUN apt install openjdk-8-jdk -y
RUN apt install maven -y
RUN apt install sbt -y

RUN wget https://dlcdn.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
RUN tar zxvf spark-3.2.1-bin-hadoop3.2.tgz
RUN mv spark-3.2.1-bin-hadoop3.2 /opt/spark
RUN rm -rf ./spark-3.2.1-bin-hadoop3.2.tgz
RUN echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
RUN echo "export PATH=$PATH:/opt/spark/bin:/opt/spark/sbin" >> ~/.bashrc
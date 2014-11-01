#!/usr/bin/env bash

apt-get update
apt-get install -y python-software-properties
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y install oracle-java8-installer
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
apt-get -y install wget
apt-get -y install erlang-nox

# Install curl
apt-get -y install curl

# Install Hadoop 2.4.1
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.4.1/hadoop-2.4.1.tar.gz
tar -xzf hadoop-2.4.1.tar.gz

# Configure Hadoop
yes y | ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

# Copy configurations for HDFS
cp /vagrant/conf/* hadoop-2.4.1/etc/hadoop/

# Format namenode
hadoop-2.4.1/bin/hadoop namenode -format

# Start dfs
yes Yes | hadoop-2.4.1/sbin/start-dfs.sh

# Install and start RabbitMQ
echo "deb http://www.rabbitmq.com/debian/ testing main" >/etc/apt/sources.list.d/rabbitmq.list

curl -L -o ~/rabbitmq-signing-key-public.asc http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add ~/rabbitmq-signing-key-public.asc

apt-get update
apt-get -y --allow-unauthenticated --force-yes install rabbitmq-server

apt-get upgrade
apt-get -y install aptitude

# Install Neo4j
wget -O - http://debian.neo4j.org/neotechnology.gpg.key| apt-key add - # Import our signing key
echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list # Create an Apt sources.list file
aptitude update -y # Find out about the files in our repository
aptitude install neo4j -y # Install Neo4j, community edition

apt-get -y install git

# Install Maven
apt-get -y install maven

# Install Scala
apt-get -y remove scala-library scala
wget http://www.scala-lang.org/files/archive/scala-2.11.1.deb
dpkg -i scala-2.11.1.deb
apt-get update
apt-get -y install scala

# sbt installation
# remove sbt:> sudo apt-get purge sbt.

wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb
dpkg -i sbt-0.13.5.deb
apt-get update
apt-get -y install sbt

# Copy mazerunner source

# Configure mazerunner/extension/src/main/resources/mazerunner.properties

# Maven package mazerunner/extension with assemblies

# Copy the mazerunner/extension jar file from mazerunner/extension/target to neo4j/plugins

# Modify neo4j-server.properties to declare mazerunner as an extension

# Start mazerunner/spark in background

# Start RabbitMQ server

# Start Neo4j server

# Import sample dataset to Neo4j

# curl to http://localhost:7474/service/mazerunner/warmup

# curl to http://localhost:7474/service/mazerunner/pagerank

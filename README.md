# Nameles-streaming

 The real-time version of highly scalable IVT detection and filtering solution. This repository holds documentation and example files.


Nameles consists of two modules: the [scoring-module](https://github.com/Nameles-Org/scoring-module) and the [data-processing-module](https://github.com/Nameles-Org/data-processing-module). The scoring-module replies to the query messages sent by DSP with the confidence score of the domain and the category in which the domain falls, based on the statistical thresholds of outlierness. In addition, the scoring-module forwards the messages to the data-processing-module for updating the scores at the end of the day. Both modules intercommunicate with between them using [zeromq](http://zeromq.org).

## 1. Before deployment

The [scoring-module](https://github.com/Nameles-Org/scoring-module) runs several worker threads that pull the queries from the DSP end and push the reply messages. The workers perform a single lookup in a shared hash table for each message. Therefore, the host running the scoring-module module requires minimal memory and drive. We recommend setting a worker per CPU and running latency tests with your expected throughtput load in order to dimensionate an appropriate number of processors for the host. Note that you can run several scoring modules in your system communicating with the same data processing module.

The data-processing-module performs precomputations with the stream of data received from the scoring module. The data is periodically serialized to a [PostgreSQL](https://www.postgresql.org) database. The scores are computed at the end of each day. The host of this module would benefit from having a high amount of RAM and a certain number of processors in order to reduce the score computation times. We recommend at least 64GB of RAM and 4 cores.

### 1.1. Install docker

Docker is needed for deploying Nameles from the [pre-built docker images](https://hub.docker.com/u/apastor). We recommend using docker-compose for configuring the variables for each module as the messaging ports and number of workers.

1.1.1. Install [docker-ce](https://docs.docker.com/engine/installation/#server) for your linux distribution following the instructions of the official documentantion. Then, add your linux user to the docker group for being able to run docker commands without root privileges.

```bash
sudo usermod -aG docker $USER
```
Test the installation running the hello-world docker image.
```bash
docker run hello-world
```
1.1.2. Install [docker-compose](https://docs.docker.com/compose/install)
```bash
docker-compose --version
```

### 1.2. Install PSQL 

In Debian/Ubuntu systems you need the postgresql-client package:
```bash
sudo apt-get install postgresql-client
```


## 2. Install Nameles Using Docker Compose

There are two options provided for deployment: 

- 2.1. single machine deployment
- 2.2. multiple machine deployment (recommended for high performance)

### 2.1 Single Machine System

For running the complete nameles system from the same `docker-compose.yml` file.
Use as a template the `nameles-docker-compose.yml` file:
```bash
# get the docker compose file 
wget https://raw.githubusercontent.com/Nameles-Org/Nameles-streaming/master/nameles-docker-compose.yml

# execute compose
sudo docker-compose -f nameles-docker-compose.yml up
```

## 2.2 Multiple Machine System

2.2.1. Create the nameles-net network in docker:
  ```bash
  docker network create --subnet 172.20.0.0/24 --gateway 172.20.0.1 nameles-net
  ```

2.2.2. Run docker-compose for the three nameles modules in the following order:
  1. data-processing-module
  2. scoring-module
  3. dsp-emulator

  ```bash
  sudo docker-compose -f <module-path>/docker-compose.yml up --force-recreate
```

2.2.3. Check the proper working of the system accessing to the database from the host

  ```bash
  psql -h 127.0.0.1 -p 5430 -U nameles
  ```

NOTE: you need to have installed the postgreSQL client as detailed in section 1.2

## 3. Using Nameles

The [dsp-emulator module](https://github.com/Nameles-Org/dsp-emulator) can be used as an example for interfacing Nameles from your infrastructure, i.e. message formatting and zeromq port bindings. The [latency test](https://github.com/Nameles-Org/dsp-emulator/blob/master/src/dsp_latency_test.cpp) source code is implemented in C++ but a different language for which zeromq is available could be used.

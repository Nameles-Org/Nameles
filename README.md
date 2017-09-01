# Nameles-streaming

 The real-time version of highly scalable IVT detection and filtering solution. This repository holds documentation and example files.

## Running nameles with docker-compose

### The complete system in the same compose

For running the complete nameles system from the same `docker-compose.yml` file.
Use as a template the `nameles-docker-compose.yml` file:
```bash
sudo docker-compose -f nameles-docker-compose.yml up
```

## Each container from different compose files

1. Create the nameles-net network in docker:
  ```bash
  sudo docker network create --subnet 172.20.0.0/24 --gateway 172.20.0.1 nameles-net
  ```

2. Run docker-compose for the three nameles modules in the following order:
  1. data-processing-module
  2. scoring-module
  3. dsp-emulator

  ```bash
  sudo docker-compose -f <module-path>/docker-compose.yml up --force-recreate
```

3. Check the proper working of the system accessing to the database from the host

  ```bash
  psql -h 127.0.0.1 -p 5430 -U nameles
  ```

  Note that for this last step you need to have installed the postgreSQL client.
  In Debian/Ubuntu systems you need the postgresql-client package:
  ```bash
  sudo apt-get install postgresql-client
  ```

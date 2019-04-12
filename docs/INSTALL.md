## 2. Install Nameles

You can install Nameless on a single machine or a cluster of multiple machines following the instructions on section 2.1 below. There are two options:

- single configuration deployment
- multiple configuration deployment

If you install Nameles on a multiple machine docker cluster/swarm, then you have two options: a) where you let docker allocate resources per service b) where you allocate reseources yourself.

### 2.1. Depedencies 

Depencies will be taken care by the setup script, so you should not have to worry about anything more than running ./setup as shown in the section 2.1. and 2.2. depending on your system configuration. The main depencies are: 

- docker-ce
- psql

### 2.2 Installation with Setup Script <a name="single"></a>

For running Nameles on a single server on an Ubuntu or Debian system:

    # download the setup script
    wget https://raw.githubusercontent.com/Nameles-Org/Nameles/master/setup
    
    # change the permissions
    chmod +x setup
    
    # run the setup script
    ./setup


## 2.3. Test Installation

You will have to create another shell, as in the shell where you run the setup now you will have a running docker instance.

  ```bash
  psql -h 127.0.0.1 -p 5430 -U nameles
  ```

NOTE: you need to have installed the postgreSQL client as detailed in section 1.2
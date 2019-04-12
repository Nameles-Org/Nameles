## 3. Using Nameles <a name="using"></a>

The [dsp-emulator module](https://github.com/Nameles-Org/dsp-emulator) can be used as an example for interfacing Nameles from your infrastructure, i.e. message formatting and zeromq port bindings. The [latency test](https://github.com/Nameles-Org/dsp-emulator/blob/master/src/dsp_latency_test.cpp) source code is implemented in C++ but a different language for which zeromq is available could be used.

### 3.1. Restarting 

#### 3.1.1. Single Configuration Install

If the machine where Nameles is running reboots or is interrupted for another reason, you can restart with: 

  ```bash
  sudo docker-compose -f ~/Nameles/nameles-docker-compose.yml up
  ```

#### 3.1.2. Multiple Configuration Install

Note that after each command you have to start a new shell, as the current shell has a container running in it. 

  ```bash
    sudo docker-compose -f ~/Nameles/data-docker-compose.yml up
    sudo docker-compose -f ~/Nameles/scoring-docker-compose.yml up
    sudo docker-compose -f ~/Nameles/emulator-docker-compose.yml up
  ```
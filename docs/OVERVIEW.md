## System Overview <a name="system"></a>

Nameles consist of two separate modules 

- the [scoring-module](https://github.com/Nameles-Org/scoring-module)
- the [data-processing-module](https://github.com/Nameles-Org/data-processing-module)

The scoring-module replies to the query messages sent by DSP with the confidence score of the domain and the category in which the domain falls, based on the statistical thresholds of outlierness. In addition, the scoring-module forwards the messages to the data-processing-module for updating the scores at the end of the day. Modules communicate using [zeromq](http://zeromq.org).

*Figure 1: An example deployment with a DSP*

<img src='https://i.imgur.com/jetJFL3.png'>

Figure 1 presents a high level representation of Nameles functional blocks. Moreover, the figure shows how Nameles could be integrated in the programmatic ad delivery chain as an auxiliary service for the DSPs. The only difference with respect to the current operation of a DSP would be that, as part of the pre-bid phase, the DSP makes a request to Nameles to provide a Confidence Score per bid request. To this end, the DSP sends a scoring request to Nameles (step 2 in Figure 3). The scoring request includes the following fields: bid request id (mapping Nameles result to the corresponding bid request), IP address of the device associated with the bid event and the domain offering the ad space. This information is included in the bid requests as defined in the openRTB protocol standard. The scoring request is delivered to two independent modules of Nameles: the Scoring module and the Filtering module.
 
### Scoring Module

The [scoring-module](https://github.com/Nameles-Org/scoring-module) runs several worker threads that pull the queries from the DSP end and push the reply messages. The workers perform a single lookup in a shared hash table for each message. Therefore, the host running the scoring-module module requires minimal memory and drive. We recommend setting a worker per CPU and running latency tests with your expected throughtput load in order to dimensionate an appropriate number of processors for the host. Note that you can run several scoring modules in your system communicating with the same data processing module.

### Data Processing Module

The data-processing-module performs precomputations with the stream of data received from the scoring module. The data is periodically serialized to a [PostgreSQL](https://www.postgresql.org) database. The scores are computed at the end of each day. The host of this module would benefit from having a high amount of RAM and a certain number of processors in order to reduce the score computation times. We recommend at least 64GB of RAM and 4 cores.

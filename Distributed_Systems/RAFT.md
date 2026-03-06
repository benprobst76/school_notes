Consensus in the presence of failures  
• In a fault tolerant process group, each non faulty component executes the  
same updates, in the same order as every other non faulty component  
• Need to reach a consensus on the order to execute command  
• Raft  
• Onagaro, D., Ousterhout, J., In Search of an Understandable Consensus  
Algorithm (Extended Version), Stanford University. 2014

State Based Replicas  
• State based replicas is based on an operation that changes the system state  
• KV - commands to update part of the replica state (i.e. the value associated with a particular  
key)  
• examples: Databases, Lock servers, System monitors, telephone switches, routing tables.  
• Important that updates be applied at all replicas in the same order  
• Paxos is a complex state based replication system  
• Real world use of Raft (non exclusive list):  
• etc (naming service used in kerbunetes)  
• Neo4j (graph datase)  
• MongoDB (no sql database)  
• RabbitM (Message Queue Middleware)

Split Brain  
• Two servers  
• Two clients  
• Fail-silent  
• C1/S1 and C2/S2 proceed  
independently, replicas are no  
longer consistent

Majority Vote  
• Odd Number of servers  
• each operation requires a  
majority of all servers (not just  
the alive servers)  
• C2 cannot proceed - cannot  
contact majority of servers.  
• when network is restored, S3  
can catch up by applying  
operations from S1 and S2

Raft  
Server Structure  
• replicated state  
• user provided  
• e.g. KV values  
• could be other state  
representations  
• Raft Library  
• State (volatile and persistent)  
• Log

RAFT  
Messages  
• Three types of messages  
• Client messages - instructions to client state machine  
• e.g. store a value, increment a value, read a value  
• Vote message  
• e.g. request a vote, reply grants or denies a vote  
• AppendEntry  
• e.g. append an operation to a follower's log, positive reply means in log,  
majority reply means safe to commit and execute the operation

Raft Terms  
• Term is a period of time of arbitrary length  
• Terms are numbered with consecutive integers  
• Each term begins with an election (initial election discussed in week 5)  
• Server can be in one of three states (leader, follower, candidate)  
• A most one leader in a given term  
• Election timer  
• A follower resets the timer each time it receives an append entries message from the leader  
• Randomized (with a minimum length)  
• If a client hasn't submitted an operation in a while, leader sends a heartbeat message to reset the  
followers election timers.  
• if the timer runs out, then a failure of some sort has occurred and a new term begins with a new election

Initial Startup Election Review  
• Each server starts up in follower mode  
• Term is 0  
• Logs are empty  
• No leader yet, so wait for election timers to expire  
• First one to expire starts the first election

Raft Initial Election Example  
Initial Startup
![[Pasted image 20260305110439.png]]

Raft Logs  
• Logs are key to the functionality of Raft  
• The mechanism by which the leader sequences the operations and the replicas agree on the order.  
• Followers must track tentative operations that have been sent by the leader, but not yet committed  
(leader may not yet have a majority vote on the op.  
• Each log has two numbers, last committed (e.g. 6) and last applied (e.g. 4)  
• Both are volatile and lost if server crashes  
• log entries are persistent (on disk) and if the server crashes and recovers the log is preserved.  
• Logs may not be identical since there may be network failures, or server crashes.  
• Raft will force the logs to be eventually identical

![[Pasted image 20260305110505.png]]
Raft Gurantees  
• Election Safety - At most one leader can be elected in a given term  
• Leader Append Only - A leader never overwrites or deletes entries in its log  
• only appends new entries  
• Log Matching - if two logs contain an entry with the same index and term  
number, then the logs are identical in all entries up to the given index  
• Leader Completeness - if a log entry is committed in a given term, than that  
entry will be present in the logs of any future leader for a higher number term  
• State Machine Safety - If a server has applied a log entry at a given index to its  
state machine, no other serve will apply a different operation for the same index.

Raft Failures  
• A follower crashes  
• one fewer followers to vote  
• must catch up once it restarts  
• The leader crashes  
• one of the follower's election timer expires,  
starts a new term and a new election  
• Network fails splitting the group  
• Minority group (S1,S2) start an election, but  
cannot achieve majority vote for a new leader  
• Must catch up when network is restored.

Raft Log Replication  
• A follower crashes and then recovers  
• The log must be brought up to date  
• The leader continues to retry indefinitely  
• Operations are idempotent, since they are adding the operation to a  
particular index in the log.  
• If the entry is already in the log, then the follower will just  
acknowledge the request.  
• However if a server has crashed, but not all logs are consistent, then  
more complicated -> next week.

Consensus in the presence of failures  
• In a fault tolerant process group, each non faulty component executes the  
same updates, in the same order as every other non faulty component  
• Need to reach a consensus on the order to execute command  
• Raft  
• Onagaro, D., Ousterhout, J., In Search of an Understandable Consensus  
Algorithm (Extended Version), Stanford University. 2014

State Based Replicas  
• State based replicas is based on an operation that changes the system state  
• KV - commands to update part of the replica state (i.e. the value associated with a particular  
key)  
• examples: Databases, Lock servers, System monitors, telephone switches, routing tables.  
• Important that updates be applied at all replicas in the same order  
• Paxos is a complex state based replication system  
• Real world use of Raft (non exclusive list):  
• etcd (naming service used in kerbunetes)  
• Neo4j (graph datase)  
• MongoDB (no sql database)  
• RabbitM (Message Queue Middleware)

Raft Server State  
• Not the same as the client state engine (KV, Database, etc).  
• Three states Follower, Candidate and Leader  
![[Pasted image 20260305111002.png]]

Raft Gurantees  
• Election Safety - At most one leader can be elected in a given term  
• Leader Append Only - A leader never overwrites or deletes entries in its log  
• only appends new entries  
• Log Matching - if two logs contain an entry with the same index and term  
number, then the logs are identical in all entries up to the given index  
• Leader Completeness - if a log entry is committed in a given term, than that  
entry will be present in the logs of any future leader for a higher number term  
• State Machine Safety - If a server has applied a log entry at a given index to its  
state machine, no other serve will apply a different operation for the same index.

Raft State  
• Persistent State for All Servers  
• currentTerm - last term server has seen (initially zero)  
• votedFor - candidate that received the vote in current term  
• log[] - the log entries (init empty, first index is 1)  
• Volatile State on All Servers  
• commitIndex - index of highest log entry known to be committed (init 0)  
• lastApplied - index of highest entry applied to state machine  
• Volatile state on leaders (reinitialized after election)  
• nextIndex[] - for each server, the index of the next log entry to send to that server  
(initialized to leaders last log index + 1)  
• matchIndex (for each server, index of highest log entry known to be replicated on that  
server) init 0

Raft RPCs  
Request Vote RPC  
• Argument  
• Term - candidate's term  
• candidateId - candidate requesting vote  
• lastLogIndex -index of candidate's last log entry  
• lastLogTerm - term of candidate's log entry  
• Results  
• currentTerm - for candidate to update itself  
• voteGranted - true → candidate received vote  
• Receiver Actions  
• reply false if term < currentTerm (include currentTerm for candidate to update)  
• if votedFor is null or candateId, and Candidate's log is at least up to date as receivers log,  
then vote yes.

Raft RPCs  
Append Entry RPC  
• Arguments  
• Term - leader's term  
• leaderId - so followers know who the leader is  
• prevLogIndex - log entry of the entry previous to the contents of the message  
• prevLogTerm - term associated with previous log entry  
• entries[] - log entries to append (empty for heartbeat, may be more than one)  
• leaderCommit - leaders commit Index  
• Receiver Actions  
• reply false if term < currentTerm (supposed leader is behind current Term)  
• reply false if log doesn't contain an entry at prevLogIndex (we are behind)  
• if there is an existing entry at the current index that conflicts, delete it and use the new one  
• Append any entry not already in the log  
• if leaderCommitIndex > commitIndex, update commitIndex

Possible Log Configurations
![[Pasted image 20260305111047.png]]

Raft Election Restrictions  
Election Safety - Case 1 Why not longest log?  
• Only vote yes only if  
• candidate has higher term in last log entry than receiver,  
• candidate has same last term in last log entry & candidate log length >=  
receiver log length.  
• In previous example,  
• S1 does not have higher term in last log entry(8) than S2 or S3 (9) so S2  
and S3 cannot vote for S1  
• S2 and S3 can vote for each other, so one of them will become the leader.

Raft Persistence  
Safety after Crashes  
• Allow servers to pick up where they left off  
• Can't simply replace server in all cases (some cases),  
• Have to save the state somewhere.  
• Persistent  
• currentTerm  
• votedFor  
• log  
• On reboot, server has to check the values are consistent in some way before rejoining the cluster.  
• Server state engine is not persistent (in the paper), so replay log to get back state.

Raft Persistence  
Snapshots  
• After Crash, have to replay the log  
• May be a long log -> expensive  
• Application state is likely to be smaller than log  
• log has may have multiple overwrites (e.g. set the value for key 5 multiple times).  
• Take a snapshot of the state at a specific point in the log.  
• discard log before the snapshot point.  
• If follower is too far behind, the leader can send a snapshot to the follower to speed the  
catchup (expensive in network traffic).  
• Followers can take snapshots without knowledge of leader (may become leader in future term)  
• Server must be able to find snapshot and hand back to client level state machine on restart.

Raft Rules  
All Servers  
• If commitIndex > lastApplied, apply the entries to the state machine  
• if RPC request or response contains a term > currentTerm, then date to term  
and become a follower

Raft Rules  
Followers  
• Respond to RPCs from candidates and leaders  
• If election timeout without an AppendEntry RPC from current leader, or  
granting vote to candidate → covert to candidate

Raft Rules  
Candidates  
• On conversion to candidate, start election  
• increment current vote term  
• vote for self  
• reset election time  
• send RequestVote to all servers  
• If majority received become leader  
• If AppendEntry RPC received from new leader (i.e. current term number) then  
become follower  
• If election timeout elapses (no successful election) then start new election

Raft Rules  
Leaders  
• On election send empty AppendEntry RPC (heartbeat)  
• repeat during idle periods (heartbeat timer < election timer)  
• On command received from client:  
• append entry to log, respond after entry applied to state machine  
• if lastLogIndex > next Index for a follower, send AppendEntry to that follower  
• if successfully, update nextindex and match index for the follower  
• If failed, decrement nextIndex for that follower and retry  
• If there exists N such that  
• N > commitIndex (represents entries that have not been committed)  
• log[N].term == currentTerm (the entry at N is from the current term)  
• a majority of matchIndex[i] >=N (a majority of followers have replied yes)  
• update commitIndex to N (will be sent in next appendLog entry so that followers will commit)

Raft Rules  
Write vs Read Requests  
• Write requests must be synchronized with followers  
• Read requests are answered by the leader,  
• A write request that affects the read request may be in the log and not yet  
applied to the state machine  
• Leader must use a heartbeat message to ensure the log is committed by a  
majority of followers and apply the operations to the leader state machine  
before responding to a read request.
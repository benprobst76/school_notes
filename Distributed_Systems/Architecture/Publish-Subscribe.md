## Publish and Subscribe
- Components can publish events, and subscribe to events.
- An event published by one component can be received by multiple subscribers.
- A subscriber can receive events from multiple publishers.
### How are events matched and Data sent?
- Some set of attributes for each event.
    - **Topic based subscription** ($attribute = value$)
    - **Content based subscription** ($attribute \in set$)
    - Possibly both.
- If an event is matched:
    - Notification and subscriber must request the data.
    - Data is sent directly to the subscriber.
- Choice between **persistent** (message buffered to allow late subscribers to get historical data) and **transient** (no subscriber means that the event is lost).

### RTPS ([[Real-Time]] Publish-Subscribe)
- Topics are a triple of `(name, data-type, quality of service)`.
- Data type is an arbitrary record, expressed in IDL (see [[Marshaling-&-Serialization|Marshalling]]).
- IDL compiler generates reader and write for the type (uses CDR).
- Publishers publish topics by name.
- Subscribers subscribe to topics by name.
- Can also filter events by values in the data type (SQL like notation).

Events represent the status of an entity in the system (note not a component).
- Examples: an aircraft position, a flight plan, the current reading of a sensor.
- Events can be singletons that represent just a data item (e.g., current reading of a sensor).
- Entities can have identity, represented by a key.
- Events represent updates to the value of an entity (e.g., aircraft position).
- Typically last update is cached so new subscribers get the last value for a given key.
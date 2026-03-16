Names are essential in computer systems for identifying resources. A name can refer to a file (an inode on a device), a shared mutex, or various entities within a distributed system.

## Distributed Naming
In a distributed system, names are spread across multiple nodes and can refer to remote files, locks, devices, processes, or [[System-Architectures#Overlay-Networks|overlay networks]].
*   **Location Transparency**: Names may include a location (e.g., `https://192.168.0.1/login`) or hide it entirely to provide [[Introduction#Transparency|location transparency]].
*   **Network Names**: Examples include DNS names like `www.google.ca`.

## Entities and Addresses
Names refer to **entities**. To interact with an entity, we use an **access point**.
*   An entity may have multiple access points.
*   Access points are themselves entities named by an **address**.
*   **Location Independence**: A name is location-independent if it remains valid even if the entity's address changes (e.g., moving a service to a different machine). This requires updating the name resolution system.

## Identifiers
An identifier is a unique name that has no inherent meaning, often used for machine-level comparisons.
*   **Properties**:
    1.  Refers to at most one entity.
    2.  An entity has exactly one identifier.
    3.  An identifier is never reused (it always refers to the same entity).
*   **Example**: A partition UUID like `08581f60-92a1-4685-a070-79b7a3d79d9c`.

## Human-Friendly Names
These are readable strings (sometimes including glyphs like "K♣") that humans can easily remember.
*   Examples: File names, DNS names (`perseus.ece.queensu.ca`).
*   **Resolution**: These must be resolved to an address using a mapping table, which may be distributed.

## Flat Namespace
In a flat namespace, names have no internal structure or location information (e.g., "Tom's iPhone"). Finding the address of such an entity requires specific mechanisms:

### Broadcast and Multicast
*   **Mechanism**: Broadcast a request with the entity's name; the machine owning the entity replies with its address.
*   **ARP (Address Resolution Protocol)**: Used to find the MAC address associated with an IP address.
*   **Scalability**: Does not scale well; suitable only for local networks.

### Forwarding Pointers
*   **Mechanism**: When an entity moves, its old address maintains a pointer to the new one.
*   **HTTP Redirection**: Uses status codes in the $300-399$ range.
    *   **301**: Moved Permanently.
    *   **302**: Temporary Redirect.
*   **Drawback**: Highly mobile entities can create long redirection chains, leading to "too many redirects" errors.

### Home-Based Approaches
*   **Mechanism**: A "home address" tracks the current "mobile address" of an entity.
*   **Process**:
    1.  Entity updates the home address with its current location.
    2.  Client contacts the home address.
    3.  Home address either redirects the client or tunnels the communication.
*   **Example**: Cell phone roaming.
*   **Problems**: The home address must exist for the entity's lifetime, and geographical distance can cause latency even if the mobile entity is near the client.

## Structured Naming
Names contain components that indicate their position within a namespace, typically represented as a labeled directed graph.
*   **Leaf Nodes**: Represent entities.
*   **Directory Nodes**: Internal nodes that label outgoing edges.
*   **Pathnames**: Absolute (from root) or relative paths through the graph.

### Unix/macOS File Systems
*   Root node is the system root (`/`).
*   Directory nodes are folders; leaf nodes are files (containing data, permissions, etc.).
*   Files are uniquely identified by an **inode**, while the human-readable name is just a path to that inode.
![[Pasted image 20260214090202.png]]

### Name Resolution and Closure
*   **Name Resolution**: The process of translating a name into an entity.
*   **Closure Mechanism**: Defines where resolution begins. For example, absolute paths start at the root, while relative paths start at the current working directory.

### Foreign Namespaces
Namespaces can be linked via mount points.
*   Example: Mounting a partition at `/boot` links the root namespace to the boot partition's namespace.
*   **NFS (Network File System)**: Accesses a remote file system. Inode numbers are local to the foreign file system, but they appear integrated into the local namespace.

## Namespace Implementation
Distributed name resolution is typically organized into three logical layers:
1.  **Global Layer**: The top level, often jointly managed (e.g., TLDs like `.com`, `.ca`).
2.  **Administrational Layer**: Middle level nodes representing specific organizations or groups.
3.  **Managerial Layer**: Low-level nodes managed by a single administrator, often representing local resources.

### DNS Root Servers
*   There are **13 logical root servers** (named `a.root-servers.net` through `m.root-servers.net`).
*   In reality, there are hundreds of physical servers using anycast routing to map these 13 addresses to the nearest geographical instance.
*   **Replication**: Each domain (e.g., `queensu.ca`) is implemented by a primary and secondary name server. Updates occur on the primary, and secondaries perform **zone transfers** to synchronize.

### Name Resolution Strategies
In a distributed namespace, clients use a **local name resolver** (often provided by the ISP or organization).

#### Iterative Name Resolution
1.  Resolver sends the full name to a root server.
2.  Root server resolves the TLD (e.g., `.ca`) and returns the address of the next name server in the chain.
3.  Resolver repeats the process with the child server until the full name is resolved.
4.  **Pro**: Reduces the burden on high-level name servers.

#### Recursive Name Resolution
1.  Resolver sends the full name to the root server.
2.  Root server takes responsibility for the resolution and queries the child server itself.
3.  The child server queries its child, and so on.
4.  The result bubbles back up the chain to the client.
5.  **Pro**: Allows for effective caching at every level of the hierarchy.

### Example: DNS
DNS (Domain Name System) is the most prominent implementation of a structured, distributed naming system.
![[Pasted image 20260214090247.png]]
*   **Function**: Converts human-readable names to IP addresses (forward lookup) and vice versa (reverse lookup using `PTR` records).
*   **Constraints**: Components are limited to 63 characters; the total name length is limited to 255 characters.

#### Common DNS Record Types
| Type | Refers To | Description | Example |
| :--- | :--- | :--- | :--- |
| **SOA** | Zone | Start of Authority: Info on the represented zone. | `@ 3425 IN SOA queensu.ca(...)` |
| **A** | Host | IPv4 address of the host. | `perseus.ece.queensu.ca 60 IN A 130.15.115.43` |
| **AAAA** | Host | IPv6 address of the host. | |
| **MX** | Domain | Mail server for the domain. | `example.com 202 IN MX mail.example.com` |
| **NS** | Zone | Authoritative name server for the zone. | `example.com 156447 IN NS ns.example.com` |
| **CNAME** | Node | Canonical Name: An alias for another node. | `blog.example.com 60 IN CNAME b1.example.com` |
| **PTR** | Host | Pointer: Maps an IP to a canonical name. | `43.115.15.130.in-addr.arpa 30 IN PTR ...` |
| **SRV** | Domain | Service record: Identifies servers for specific services. | |
| **TXT** | Any | Descriptive text; used for verification (SPF, DKIM). | |

## Directory Services
While naming services map a specific name to an entity, **Directory Services** allow searching for entities based on their **attributes**.
*   **Query**: A set of desired attribute values (e.g., "Find all printers in building WLH with color support").
*   **Return**: One or more entities meeting the criteria.
*   **Examples**: Email systems (searching by subject/sender), Yellow Pages, and LDAP.

### LDAP (Lightweight Directory Access Protocol)
LDAP is a combined database and structured naming system, commonly used in **Microsoft Active Directory (AD)**.
*   **Records**: Directory entries consisting of attribute-value pairs.
*   **Attributes**: Typed and can be multi-valued.

#### Common LDAP Attribute Abbreviations
| Abbr.   | Attribute Name      | Example                               |
| :------ | :------------------ | :------------------------------------ |
| **C**   | Country             | `CA`                                  |
| **ST**  | State/Province      | `Ontario`                             |
| **L**   | Locality            | `Kingston`                            |
| **O**   | Organization        | `Queens University`                   |
| **OU**  | Organizational Unit | `Electrical and Computer Engineering` |
| **CN**  | Common Name         | `Thomas Dean`                         |
| **UID** | User ID             | `trd`                                 |
| **DC**  | Domain Component    | `queensu`, `ca`                       |

### Directory Information Base (DIB) and Tree (DIT)
*   **DIB**: The collection of all entries in the service.
*   **DIT**: The hierarchical structure where entries are organized.
*   **Relative Distinguished Name (RDN)**: The unique name of an entry relative to its parent in the tree.
*   **Distinguished Name (DN)**: The full path from the root to the entry (e.g., `UID=trd, OU=ECE, O=QueensU, C=CA`).

### LDAP Queries and Implementation
Queries use pattern matching:
*   `Search("(C=CA)(O=Queen's University)(OU=ECE)(UID=*)")`: Finds all User IDs in the ECE department.
*   `Search("(C=CA)(O=Queen's University)(OU=*)(UID=trd)")`: Finds which department `trd` belongs to.

**Implementation**:
*   The DIT is typically partitioned across multiple **Directory Service Agents (DSA)**.
*   Unlike DNS, queries may hit multiple servers because components of the path can be omitted in the search.
*   In Active Directory, the root of the tree is the **Domain Controller**.

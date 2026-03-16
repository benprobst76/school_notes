## RESTful Architectures
Resource-based architecture. Collection of resources, managed by components.
- Resources may be added, removed, retrieved, or modified by remote applications.
- Identified using a single naming scheme.
- All services use the same interface.
- Messages are self-described.
- **Stateless**: Once a service executes the operation on behalf of a client component, the service forgets everything about the client component.
### Operations
Derived from HTTP protocol:
- `POST`: Create a new resource.
- `GET`: Retrieve the state of a resource.
- `DELETE`: Delete a resource.
- `PUT`/`PATCH`: Modify a resource.
- Typically run over HTTP.
- **Catch**: Have to do a lot with parameters.
### Blog Service Example
Assume one blog per username (if you want two blogs you need two usernames).
**Resources:**
- **Author Profile**: Only one, cannot be created, only modified.
- **Article**: Main resource, multiple articles per blog.
- **Topics**: Identifiers attached to an article to aid in searching for related articles.
- **Comments**: Other users can attach comments to articles.
**API Examples:**
- `GET https://myblog.server.ca/user/articles`
    - Responds with a list of ids.
    - Parameters: `topic` (a topic name), `sort` (date created, date updated, topic), `dir` (asc, desc).
- `GET https://myblog.server.ca/user/articles?topic=RTPS&sort=created&dir=asc`
- `GET https://myblog.server.ca/user/topics`
    - Responds with a list of topics used to tag articles in this blog.
- `POST https://myblog.server.ca/user/articles` (Create new article)
    - Contents of the put request contains article title, topics, content, description, etc.
    - Returns resource id (e.g., say 45873, or self assigned in contents of PUT, e.g., NewDogsName).
- `PUT https://myblog.server.ca/user/articles/NewDogsName`
    - Update content such as add another topic tag.

So far the architectures require that the client/sender know (or find out) the identity of the server or resource.
- Invoke a procedure or method, access a resource.
- *What about a looser organization of components that cooperate to solve some problem?*
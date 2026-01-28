Marshalling and serialization are critical components of any network protocol. They involve converting complex data structures into a sequence of bytes that can be transmitted across a network and reconstructed at the destination. This is especially important in the context of [[Threads-&-RPC]] and general [[Network-Programming]].
### Core Terminology
* **Serialization**: The process of converting a single data type or object into a serial representation (a byte stream).
* **Marshalling**: The process of serializing multiple parameters or complex data structures into a single message representation.
### Considerations in Serialization
When choosing a serialization method, several factors must be considered:
* **Text vs. Binary**:
	* **Textual Formats** (e.g., JSON, XML): Convert values to human-readable strings. While portable and easy to debug, they are less efficient.
	* **Binary Formats**: More compact and faster because they avoid the overhead of string conversion.
* **Numeric Representation**:
	* **Integers**: 8-bit to 64-bit integers can usually be precisely represented if endianness is handled.
	* **Floating Point Values**: These are problematic due to potential precision loss or "Butterfly Effect" divergences between different architectures. To avoid this, they are sometimes serialized as hex values or specific bit-patterns.
```json
{
	"x": "5",
	"y": "45",
	"dist": "F320004B"
}
```
### Manual Serialization
Manual serialization is still used for many low-level protocol implementations where performance is critical or the protocol is simple. The developer manually writes data to a byte buffer using functions like `memcpy`.
```cpp
class annotated_point {
private:
	int32_t x;
	int32_t y;
	string label;
public:
	// ...
};
```
![[Pasted image 20260115123748.png]]
Fields are copied directly: `memcpy(&buffer[4], &theVar.y, sizeof(int32_t));`. This requires careful management of buffer offsets and awareness of [[Network-Programming#Byte-Ordering|Endianness]].
### Abstract Syntax Notation One (ASN.1)
ASN.1 is an older but widely used standard for describing message layouts via a Domain Specific Language (DSL). It is common in telecommunications and infrastructure protocols.
* **Usage**: SNMP, LDAP, Kerberos, X.509 certificates, and 4G/5G cellular signalling.
* **Type System**: Includes primitives like `INTEGER`, `BOOLEAN`, `BIT STRING`, `OCTET STRING`, `REAL`, and various string types (`UTF8String`, `IA5String`).
* **Constructors**: Uses `SEQUENCE` for structures and `SEQUENCE OF` for arrays.
```asn1
POINT ::= SEQUENCE {
	X INTEGER,
	Y INTEGER
}
RECT ::= SEQUENCE {
	TopLeft POINT,
	BotRight POINT
}
INTERFACE ::= SEQUENCE (SIZE (1..20)) OF RECT
```
#### ASN.1 Encoding Rules
ASN.1 data is often encoded using a **Tag-Length-Value (TLV)** format, making it self-describing.
* **BER (Basic Encoding Rules)**: Uses tags for each primitive (e.g., INTEGER=2, SEQUENCE=16).
* **DER (Distinguished Encoding Rules)**: A subset of BER that ensures a unique encoding for any value (critical for digital signatures).
* **PER (Packed Encoding Rules)**: More compact, used in bandwidth-constrained environments like cellular networks.
![[Pasted image 20260115124149.png]]
### Google Protocol Buffers (Protobuf)
Introduced by Google in 2001, Protobuf is a popular DSL and library for cross-language serialization. It generates code for multiple languages (C++, Go, Python, etc.), allowing a message written in one to be read by another.
* **Features**: Compact binary format, versioning support, and efficient generated code.
* **C++ Usage**: Uses a `protoc` compiler to generate classes from `.proto` files.
![[Pasted image 20260115125259.png]]
#### Protobuf Example
```protobuf
syntax = "proto3";
package E377Example;
message annotated_point {
	int32 x = 1;
	int32 y = 2;
	string label = 3;
};
```
* **Field Labels**: Each field has a unique number (e.g., `x = 1`). These numbers identify fields in the binary format and should never be changed once established.
* **C++ Implementation**:
```cpp
#include "ex1.pb.h"
int main() {
	E477Ex1::annotated_point msg;
	msg.set_x(3);
	msg.set_y(4);
	msg.set_label("This is a test");
	uint32_t blen = msg.ByteSizeLong();
	uint8_t buffer[1024];
	msg.SerializeToArray(buffer, blen);
	E477Ex1::annotated_point msg2;
	msg2.ParseFromArray(buffer, blen);
	cout << "x = " << msg2.x() << " label = " << msg2.label() << endl;
	return 0;
}
```
#### Advanced Protobuf Features
* **Enums**: Must have a value mapping to 0 for the default/uninitialized state.
* **User Defined Types**: Messages can be nested or imported from other files.
* **Mutable Fields**: Complex fields (like strings or sub-messages) can be modified directly via `mutable_fieldname()`, which returns a raw pointer. Note that Protobuf does not use [[Cpp-Overview#Smart-Pointers|Smart Pointers]].
* **Optional**: The `optional` keyword allows checking if a field is set via `has_fieldname()`.
* **Repeated**: Used for lists/arrays. Uses `google::protobuf::RepeatedField<T>`.
* **Oneof**: Indicates a choice where only one field will be serialized at a time.
* **Compatibility**: Protobuf allows adding new fields without breaking older binaries, provided label numbers are preserved.
### IDL / CDR (CORBA & RTPS)
The **Interface Definition Language (IDL)** and **Common Data Representation (CDR)** were originally designed for CORBA to enable interoperability between diverse languages like COBOL, Ada, C++, and Java.
* **Module**: Acts as a namespace, similar to C++ namespaces or Protobuf packages.
* **Annotations**: `@key` marks a field as a unique identifier for an entity (e.g., an aircraft ID in a tracking system), indicating that subsequent messages are updates to that specific instance.
```idl
module HelloWorldData {
	struct Msg {
		@key long userID;
		string message;
	};
};
```
* **CDR Generation**: The IDL compiler generates "Writers" and "Readers" (e.g., `PointWriter`).
* **Endianness**: CDR supports both Little Endian and Big Endian; the generated classes handle conversion automatically based on the machine architecture.

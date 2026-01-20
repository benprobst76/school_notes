- Important for any network protocol communications  
• need to convert a data structure to some sequence of bytes that the other end can convert back to a data structure.  
• A wide variety of existing serializers, mostly for storing data in in files/databases  
• We will be covering for networks in general, and in the context of RPC.  
• Terminology  
• Serialize when converting a given type to a serial representation  
• Marshalling when serializing multiple parameters into a single representation.
A wide variety of ways, and multiple  
standards  
• Manual  
• ASN.1  
• Protobuf  
• CDR  
• JSON/XML
### Considerations  
• Text/Binary  
• Text is converting all values to a textual form with  
something similar to json  
• Integer based types (8bit - 64 bits) can be  
precisely represented  
• Floating point values are problematic -  
Butterfly Effect  
• Can serialize as a hex value  
• Binary is more compact and faster as you don't  
have to convert representations.  
```json
{  
	x: "5",
	y: "45",  
	dist: "F320004B"  
}
```
### Manual  
• Still used for many protocol implementations  
• Decide on serial representation and write the data to the byte buffer manually  
```
class annotated_point{  
	private:  
		int32_t x;  
		int32_t y;  
		string label;  
	public:  
		...  
};
```
![[Pasted image 20260115123748.png]]
copy the bytes for each field: e.g memcpy(&buffer[4], &theVar.y, sizeof(int32_t);
### Abstract Synax Notation One (ASN.1)  
Old but still used.  
• Domains Specific Language(DSL) used to describe message layout  
• Used some IP and many telephone protocols  
• Simple Network Management Protocol (SNMP)  
• Directory and Authentication Services (LDAP, Kerberos, X.509 Public Key  
Certificates)  
• Signalling System No. 7 (Public Switch Telephone Network)  
• Voice Over IP Protocols  
• 4G and 5G Cellular
Language  
• A set of primitive types  
• INTEGER, BOOLEAN, BIT STRING, OCTET STRING, DATE TIME-OF0-DAY,  
DATE-TIME, REAL, ENUMERATED, IA5String, VisibleString, UTF8String,  
NULL  
• Structure description
POINT ::= SEQUENCE { RECT ::= SEQUENCE{  
X INTEGER TopLeft POINT  
Y INTEGER BotRight POINT  
}
Array Constructor  
• INTERFACE ::= SEQUENCE OF RECT  
• Definitions can constrain values  
INTERFACE ::= SEQUENCE (SIZE (1..20)) OF RECT  
STUDENT ::= SEQUENCE {  
NAME VisibleString (SIZE (10..20))  
PROGRAM VisibleString ("UGrad" | "Grad")  
STUDENTNO INTEGER (10000000 .. 99999999)  
}
Encoding  
• Binary Encodings self scribe the structure  
• Tag, length, value  
• Basic Encoding Rules(BER), Distinguished Encoding Rules (DER),  
Packed Encoding Rules(PER), Extended Encoding Rules(XER)  
• Also can be encoded in JSON or XML
BER Encoding  
• Tags for each of the primitive values  
• End-ofContent (0), INTEGER(2), VisibleString (1A)  
• Basic Encoding Rules(BER), Distinguished Encoding Rules (DER),  
Packed Encoding Rules(PER), Extended Encoding Rules(XER)  
• Constructor Tags  
• SEQUENCE (10)
![[Pasted image 20260115124149.png]]
### Protobuf  
Google 2001  
• DSL for specifying serialization, includes compiler and library.  
• Compiler generates the data structure for the programmer to use.  
• C++, C#, Java, Kotlin, Dart, Go, Php, Python, Rust  
• Message written by one language can be parsed by others.  
• Uses its own internal encoding  
• messages are not compressed, same data can be serialized several ways  
• Today is overview. Full details at https://protobuf.dev
![[Pasted image 20260115125259.png]]
#### Example
```cpp
syntax="proto3";  
package E377Example;  
message annotated_point {  
	int32 x = 1;  
	int32 y = 2;  
	string label = 3;  
};
```
Two versions of the language  
proto2 and proto3  
Modules for encapsulating message  
types -> turns into namespaces in C++  
Each field in a message must have a  
unique label number, used the binary  
format when encoding the fields.  
- Does not specify order of encoding.  
`protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/annotatedPoint.proto`
```cpp
#include <ostream>  
#include "ex1.pb.h"  
using namespace std::string_literals;  
using namespace std;  
int main(int argc, char * arg[]){  
	uint8_t buffer[1024];  
	E477Ex1::annotated_point msg;  
	msg.set_x(3);  
	msg.set_y(4);  
	msg.set_label("This is a test"s);  
	uint32_t blen = msg.ByteSizeLong();  
	if (blen > 1024) {...}  
	msg.SerializeToArray(buffer, blen);  
	E477Ex1::annotated_point msg2;  
	if (!msg2.ParseFromArray(buffer,blen)){  
		cerr << "Could not parse message" << endl;  
		exit(1);  
}  
cout << "x = " << msg2.x() << endl;  
cout << "y = " << msg2.y() << endl;  
cout << "label = " << msg2.label() << endl;  
return 0;  
}
```
Primitive data types  
• double, float, int32, int64, uint32, uint64, sint32, sint64, fixed32, fixed64, bool,  
float, double  
• Unlike ASN, you must specify the size of integer types.  
• string, bytes  
• variable length up to 232  
• C++ style comments (`/* .... */ and //`) are used
Enums  
• Like C++ enumerations, gives  
a set of possible values  
• numbers are not field  
encodings but values  
• must have one that maps to  
zero for default value  
• should not to be a  
meaningful element to check  
for uninitialized fields.  
```
enum ValueType {  
	ValueTypeUknown = 0;  
	ValueTypeAddress = 1;  
	ValueTypeName = 2;  
}  
message ValueMessage {  
	...  
	ValueType routine = 3;  
	...  
}
```
User Defined Types  
• You can use one type in the  
definition of another type  
• label numbers are local to  
message type  
• you can import definitions from  
other files with an import  
statement  
```
message Point {  
	int32 x = 1;  
	int32 y = 2;  
}  
message Rect {  
	Point upperLeft = 1;  
	Point upperRight = 2;  
}
```
Mutable fields  
• Most fields can be set with  `set_fieldname();`
• If you want to modify a complex  
field such as bytes or a user  
defined message directly, you need  
to get a mutable version.  
• returns a pointer.  
• Unfortunately protobuf does not  
support smart pointers.  
```
Rect rect;  
Point * pt = rect.mutable_upperleft();  
pt-> set_x(4);  
pt -> set_y(5);
```
Optional  
• A field might be optional  
• C++ interface allows you to  
set or erase the fields, and  
check if it has a value  
```
message Foo{  
	int32 a = 1;  
	optional int32 b = 2;  
}  
...  
if (msg.has_b()) { ... }  
msg.erase_b();
```
Repeated  
• repeated keyword used for list  
of items  
• use bytes type for array of  
bytes  
• Template  
`type ::google::protobuf::RepeatedField<T>` is used for the  
array itself.  
```cpp
message INTERFACE {  
repeated Rect rects = 1;  
}  
size = msg.rects_size();  
Rect& forthRect = msg.rects(3);  
Rect* fifthRect = msg.mutable_rects(4);  
// add a Rect and allow the developer  
// to modify it. Add returns a mutable instance  
Rect * r = msg.add_rects();  
Point * p = r-> mutable_topLeft();  
p->set_x(4);  
p->set_y(5);
```
Choices  
• the keyword oneof is used to  
indicate alternative forms of  
messages  
• only one will be serialized  
• in the C++ code setting one  
options erases the other one  
• When receiving, you check if it  
is there.  
• `oneof` cannot be repeated  
```
message rpcMessage {  
...  
oneof rpcFcn{  
PutMessage put = 4;  
GetMessage get = 5;  
}  
...  
}  
if (msg.has_putmesssage()){  
}
```
Maintenance  
• You can produce new versions of the messages that will remain  
compatible with old versions, as long as you keep the same label  
numbers.  
• Additional fields need distinct numbers  
• Note compatibility only means with the serializer/deserializer. Your  
client and server will have to deal with different versions  
appropriately
### DL/CDR  
#### CORBA/RTPS  
• Interface Definition Language (IDL)  
• Originally produced for CORBA.  
• Like ASN.1 and Protobuf, the goal is for multi language interoperability  
• The client and server might be in different organizations and written  
in different languages. COBOL, PL/I in business. C++, Java, Ada in  
Aerospace and Defence.  
• Like Protobuf, generates a class that can be manipulated and serialized.
#### IDL
Top level is module  
• similar to package or  
namespace  
• Can have multiple structures  
or classes in a module  
• can be independent or  
related  
```
module HelloWorldData  
{  
struct Msg  
{  
@key long userID;  
string message;  
};  
struct Point {  
x int;  
y int;  
};  
struct Rect {  
topLeft Point;  
botRight Point;  
};  
};
```
Types  
• similar to Protobuf, types have specific sizes  
• also has strings (bound and unbound), repetitions (bound and unbound)  
• Support inheritance, unions, enums, and choices  
• Annotations attach specific meaning to some fields  
• @key means that this represents a unique entity and that subsequent  
messages are updates to that entity. For example an aircraft position. The  
id would give the id of the aircraft whose position is being updated.
IDL/CDR
Generation  
• Compiler generates implementation files in the chosen language  
• Called writers and readers.  
• e.g. PointWriter, RectReader  
• The serialized representation is called Common Data Representation  
• Standardized representation  
• Both Little Endian and Big Endian versions. Generated classes automatically choose and convert between representations.
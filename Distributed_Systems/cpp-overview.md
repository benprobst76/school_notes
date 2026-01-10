### Threads and Concurrency  
In C, threads are provided by a library (e.g. pthreads)  
• generic interface  
• In C++ provided by the language like smart pointers.  
• `#include <thread>`
• Use -pthread as a flag both to the compiler and to the linker.  
• not just the linker as in C.  
• Implemented as the class std::thread.  
• Like C, threads are started with a thread function  =
#### C threads  
```
#include <pthread.h>  
void * thread_func(void*){  
...  
}  
int main(int argc, char * argv[]){  
pthread_t t;  
pthread_attr_t attr;  
...  
pthread_create(&t,&attr,  
thread_func, dataPtr);  
...  
pthread_join(&t,&retValPtr);  
}  
```
• Limited interface for the thread func  
• takes one parameter, returns a pointer  
• To pass more than one parameter,  
must create a structure, malloc and  
pass the pointer to the create function  
• pthread_join passes a pointer to a  
pointer to get the return value when the  
thread exits.
### C++ threads

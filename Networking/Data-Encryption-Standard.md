In [[Network-Security]] the Data Encryption Standard (DES) is an outdated, symmetric-key encryption algorithm developed by IBM and adopted as a U.S. federal standard in 1977. It encrypts data by operating on 64-bit blocks using a 56-bit key through a series of substitution and permutation operations. While influential, DES is no longer considered secure due to its short 56-bit key, which is vulnerable to modern brute-force attacks and has been replaced by more secure algorithms like [[Advanced-Encryption-Standard]].

### Feistel Network
![[Pasted image 20251002131343.png]]
The Feistel structure used in the DES involves splitting a data block into two halves, applying a function (f) to the right half with a subkey, XORing the result with the left half, and then swapping the halves for each round. This iterative process provides confusion and diffusion through the mixing of data and keys, with decryption using the same logic but in reverse key order, even if the round function isn't invertible. 

**16 Round Feistel Network**
![[Pasted image 20251002131621.png]]
16 subkeys are generated from the secret key and used in each round. Add the parity bit to extend the 56bit key to a 64bit key (Odd number of 1s in a byte); Initial permutation go the key PC1 which selects 56bits in two 28bit halves. Perform 16 stages consisting of: 
1. Rotating each half separately either 1 or 2 places depending on the key rotation schedule K (left circular shift) 
2.  The output of the function F is then XORed with the left half (L) of the data.
3. The original right half (R) becomes the new left half (L) for the next round, and the result of the XOR operation becomes the new right half (R).

Given a few input output pairs find the key using Brute Force. In 2006 it took 7 hours and $10,000 to break a 56bit key whereas a 128bit key would take 227 days

|i|a|a2|a2 mod p|
|---|---|---|---|
|0|474|474|474 mod 2003 = 474|
|1|474|224676|224676 mod 2003 = 340|
|2|340|115600|115600 mod 2003 = 1429|
|3|1429|2042041|2042041 mod 2003 = 984|
|4|984|968256|968256 mod 2003 = 807|
|5|807|651249|651249 mod 2003 = 274|
|6|274|75076|75076 mod 2003 = 965|
|7|965|931225|931225 mod 2003 = 1833|
|8|1833|3359889|3359889 mod 2003 = 858|
|9|858|736164|736164 mod 2003 = 1063|
|10|1063|1129969|1129969 mod 2003 = 277|

##### Final Answer

277 x 858 x 965 x 474 = 108710805060 mod 2003 = **1087**
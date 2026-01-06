The [[Network-Security]] [[Data-Encryption-Standard]] is based on Feistel networks while AES is based on the idea of substitution-permutation networks; alternating step of substitution and permutation operations. 
Key sizes: 128, 192, and 256 bits
Block size: 128 bits
![[Pasted image 20251002132228.png]]
State: The input/output of the round function in AES can be represented by a matrix array of bytes. The array has 4 rows and the number of columns Nb is the block size divided by 32. 

Key: A matrix array with bytes, the array is 4 rows, and the number of rows Nk is the key size divided by 32
![[Pasted image 20251002132308.png]]

**Bit padding** 
Block ciphers require their input to be an exact multiple of block size. A padding string is added before encryption, if the plaintext to be encrypted is not an exact multiple.  
### Encryption modes
To hide the statistical characteristics of the plaintext, data format, etc. To improve the overall security and prevent deleting, replaying, inserting and forging attacks. 

**Electronic Cookbook (ECB):** Ideal for short data, for example encryption keys. If the same plaintext packet is repeated in the message, the generated cipher text packet is also the same. Not enough to be secure for long messages.

**Cipher Block Chaining (CBC):** Use the cipher text in the previous block to generate the cipher text. Used in general purpose block-oriented transmission. Have error propagation (increasing or losing one or more bits). If there is one bit error int he plaintext, the subsequent cipher will be affected. If a cipher block yi has error during transmission, the plaintext xi and the next block xi+1 and following blocks cannot be recovered without error.

**Cipher Feedback (CFB):** Block cipher is the key stream generator. The size of the feedback is s if s = 1, it is stream cipher. No bit padding is needed. Used in general-purpose stream oriented transmission. Has error propagation. The initial vector should be changed for each key.

**Output Feedback (OFB):** No error propagation, the structure of a typical stream cipher. Block cipher is the key stream generator. The output if the block cipher is fed back to the input of the bock cipher. Used in stream orientated transmission over noisy channels. No detection the cipher tampering. 

**Counter (CTR):** The initial counter value must be a nonce and incremented by 1 for each subsequent block. If a counter value is used multiple times, the confidentiality of all the plain text blocks may be compromised. Hardware and software efficiency; prepossessing; simplicity. Used for general purpose block oriented transmission for high speed requirements. 
#### Comparison
**ECB:** simple high speed but weakest and vulnerable to replay attacks. Not recommend 

**CBC:** Suitable for file encryption but slower than ECB. Security is stronger and no synchronization if there are a few errors 

**OFB and CFB:** Much slower than CBC only a few bit complete encryption each iteration. CFB is used systems that can be self synchronized and tolerate small error propagation. Widely used in stream chipper for character by character.

**OFB:** Used in high speed synchronization systems and does not have error propagation.

**OFB and CTR:** Structures of stream ciphers.
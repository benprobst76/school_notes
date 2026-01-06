Here are the questions copied exactly from the provided exam papers.
### **Exam 2021**
Q2 (15 points).
a). What are the functions offered by the TLS/SSL handshake protocol?
> - Allow the server and client to authenticate each other. 
> - Negotiate the encryption and MAC algorithms. 
> - Create cryptographic keys to be used for the secure connection. 
> - Establish a TLS connection and subsequently a session

b). Describe the detailed processes of the TLS 1.2 handshake protocol (including 4 stages). 
> 1. The client send client hello message proposing security capabilities including protocol version, random number, cipher suites and compression algorithms supported. The server responds with server hello message choosing the common security capabilities.
> 2. The server sends optional authentication such as a certificate, key exchange, or certificate request. The server then signals it has finished its part of the initial handshake message.
> 3. The client does authenticate such as sending a certificate, generating the secrets for key exchange and encrypting with the server's public key and the server verifies the client using the clients public key.
> 4. Both the client and server send Change Cipher Spec messages that signals transition to the newly established cryptographic parameters so all subsequent communication will use the new cipher and suite keys. Both the client and server send finished messages as a final verification that the handshake was successful and both parties have derived the same cryptographic keys.

**Q3 (10 points).** Define a toy hash function h: $(Z_{2})^{7}\rightarrow(Z_{2})^{4}$ by the rule by $h(x)=xA$ where all operations are modulo 2 and $A=\begin{pmatrix}1&0&0&0\\ 1&1&0&0\\ 1&1&1&0\\ 1&1&1&1\\ 0&1&1&1\\ 0&0&1&1\\ 0&0&0&1\end{pmatrix}.$ Find all preimages of (0,1,0,1). 

> To find the preimages of $y = (0, 1, 0, 1)$, we solve the linear system $xA = y$ over $Z_2$.
  Given $A$, this corresponds to the system of equations: $$
  \begin{aligned}
  x_1 + x_2 + x_3 + x_4 &\equiv 0 \pmod 2 \\
  x_2 + x_3 + x_4 + x_5 &\equiv 1 \pmod 2 \\
  x_3 + x_4 + x_5 + x_6 &\equiv 0 \pmod 2 \\
  x_4 + x_5 + x_6 + x_7 &\equiv 1 \pmod 2
  \end{aligned} $$
Step A: Solve for $x_4$ using Eq (4)  $$  \begin{aligned} 
    x_4 + x_5 + x_6 + x_7 = 1 \\ x_4 = 1 + x_5 + x_6 + x_7
    \end{aligned}$$
Step B: Solve for $x_3$ using Eq (3) $$ \begin{aligned}
	x_3 + (1 + x_5 + x_6 + x_7) + x_5 + x_6 = 0 \\
	x_3 + 1 + 2x_5 + 2x_6 + x_7 = 0 \\
	x_3 + 1 + x_7 = 0 \\
	x_3 = 1 + x_7
	\end{aligned}$$
  Step C: Solve for $x_2$ using Eq (2) $$  \begin{aligned} 
  x_2 + (1 + x_7) + (1 + x_5 + x_6 + x_7) + x_5 = 1 \\
   x_2 + 2 + 2x_5 + x_6 + 2x_7 = 1 \\
   x_2 + x_6 = 1 \\
   x_2 = 1 + x_6
  \end{aligned}$$
  Step D: Solve for $x_1$ using Eq (1) $$ \begin{aligned}
  x_1 + (1 + x_6) + (1 + x_7) + (1 + x_5 + x_6 + x_7) = 0  \\
  x_1 + 3 + x_5 + 2x_6 + 2x_7 = 0 \\ 
  x_1 + 1 + x_5 = 0 \\ 
  x_1 = 1 + x_5
  \end{aligned}$$
  3. General Solution We now have the dependent variables defined by the free variables ($x_5, x_6, x_7$):
   >* $x_1 = 1 + x_5$
   * $x_2 = 1 + x_6$
   >* $x_3 = 1 + x_7$
   * $x_4 = 1 + x_5 + x_6 + x_7$ 
> Solving this system yields the following 8 preimages: $$
  \begin{aligned}
  &(0, 0, 0, 0, 1, 1, 1) \\
  &(0, 0, 1, 1, 1, 1, 0) \\
  &(0, 1, 0, 1, 1, 0, 1) \\
  &(0, 1, 1, 0, 1, 0, 0) \\
  &(1, 0, 0, 1, 0, 1, 1) \\
  &(1, 0, 1, 0, 0, 1, 0) \\
  &(1, 1, 0, 0, 0, 0, 1) \\
  &(1, 1, 1, 1, 0, 0, 0)
  \end{aligned} $$

Q4 (13 points). A common way to speed up RSA decryption incorporates the Chinese Remainder Theorem, as follows. Suppose that $d_{k}(y)=y^{d}$ mod n and $n=pq$. Define $d_{p}=d$ mod $(p-1)$ and $d_q=d$ mod $(q-1)$; and let $M_{p}=q^{-1}$ mod p and $M_{q}=p^{-1}$ mod q. Then, consider the following algorithm:
Algorithm 1. CRT-Optimized RSA Decryption (n, $d_{p,}$ $d_{q,}$ $M_{p}$, $M_{q_{r}}$ y)
$x_{p}\leftarrow y^{d_{p}}$ mod p
$x_{q}\leftarrow y^{d_q}$ mod q 
$x\leftarrow M_{p}qx_{p}+M_{q}px_{q}$ mod n
return (x)
The Algorithm 1 replaces an exponentiation modulo n by modular exponentiations modulo p and q. If p and q are l-bit integers and exponentiation modulo an l-bit integer takes time cl³, then the time to perform the required exponentiation is reduced from $c(2l)^{3}$ to 2cl³, a saving of 75%. The final step, involving the Chinese Remainder Theorem, require $O(l^{2})$ if $d_{p}$, $d_{q,}$ $M_{p_{r}}$ and $M_{q}$ have been pre-computed.
a). Prove that the value x returned by Algorithm 1 is, in fact, $y^{d}$ mod n.
> Step 1: Verification of Modular Exponents
  We are given the definitions $d_p = d \pmod{p-1}$ and $d_q = d \pmod{q-1}$.
 >Consider the value $x_p$ modulo $p$: $$x_p \equiv y^{d_p} \pmod p$$  From the definition of $d_p$, we can write $d = k(p-1) + d_p$ for some integer $k$. Substituting this into the exponent for $y^d$: $$y^d \equiv y^{k(p-1) + d_p} \pmod p \equiv (y^{p-1})^k \cdot y^{d_p} \pmod p$$  According to Fermat's Little Theorem, if $p$ is a prime and $y$ is not a multiple of $p$, then $y^{p-1} \equiv 1 \pmod p$.  $$y^d \equiv (1)^k \cdot y^{d_p} \pmod p \equiv y^{d_p} \pmod p$$  Thus, $x_p$ is indeed congruent to $y^d \pmod p$. By the same logic, $x_q$ is congruent to $y^d \pmod q$.
  Step 2: Recombination via Chinese Remainder Theorem (CRT)
  We now have a system of congruences describing the target value $X = y^d$:
   1. $X \equiv x_p \pmod p$ 
  > 2. $X \equiv x_q \pmod q$
> The algorithm calculates: $$x = (M_p \cdot q \cdot x_p + M_q \cdot p \cdot x_q) \pmod n$$ Let's check this result modulo $p$: $$x \pmod p = (M_p \cdot q \cdot x_p + M_q \cdot p \cdot x_q) \pmod p$$ Since the second term contains $p$, it becomes 0 modulo $p$: $$x \equiv (M_p \cdot q) \cdot x_p \pmod p$$ We are given $M_p = q^{-1} \pmod p$, which implies $(M_p \cdot q) \equiv 1 \pmod p$.  $$x \equiv 1 \cdot x_p \equiv x_p \pmod p$$ Similarly, let's check the result modulo $q$: $$x \pmod q = (M_p \cdot q \cdot x_p + M_q \cdot p \cdot x_q) \pmod q$$ The first term vanishes because it contains $q$:  $$x \equiv (M_q \cdot p) \cdot x_q \pmod q$$ We are given $M_q = p^{-1} \pmod q$, which implies $(M_q \cdot p) \equiv 1 \pmod q$.  $$x \equiv 1 \cdot x_q \equiv x_q \pmod q$$Since the calculated $x$ satisfies $x \equiv x_p \equiv y^d \pmod p$ and $x \equiv x_q \equiv y^d \pmod q$, and $p$ and $q$ are distinct primes, by the Chinese Remainder Theorem, $x$ is the unique solution modulo $n$ ($n=pq$). Therefore, $x \equiv y^d \pmod n$.
  
b). Given that $p=15,$ $q=23$, and $d=123$, compute $d_{p}$, $d_{q}$, $M_p$, and $M_{q}$.
> $$\begin{aligned}
  d_p &= d \pmod{p-1} = 123 \pmod{15 - 1} = 11 \\
  d_q &= d \pmod{q-1} = 123 \pmod{23 - 1} = 13 \\
  \\
  M_p &= q^{-1} \mod p \\ &= 23^{-1} \mod 15 = 8^{-1} \mod 15 \\
  & 2\times8 \equiv 1 \mod 15 \rightarrow M_p = 2 \\
  \\
  M_q &= p^{-1} \mod q = 15^{-1} \mod 23 \\
  & 15\times20 \equiv 1 \mod 23 \rightarrow M_q = 20
  
 \end{aligned}
$$

c). Given the above values of p, q, and d, decrypt the ciphertext $y=17$ using Algorithm 1. 
> 1. Compute $x_p$ $$x_p = y^{d_p} \pmod p = 17^{11} \pmod{15} = 2^{11} \pmod{15}$$  We know $2^4 = 16 \equiv 1 \pmod{15}$. Therefore: $2^{11} = (2^4)^2 \cdot 2^3 = 1^2 \cdot 8 = 8$ 
> 	$x_p = 8$
  2. Compute $x_q$ $$x_q = y^{d_q} \pmod q = 17^{13} \pmod{23}$$  Using modular exponentiation (or repeated squaring):
  > $17^1 \equiv 17$
  > $17^2 = 289 \equiv 13 \pmod{23}$
   >$17^4 \equiv 13^2 = 169 \equiv 8 \pmod{23}$
>   $17^8 \equiv 8^2 = 64 \equiv 18 \pmod{23}$
  Combine to get $17^{13} = 17^8 \cdot 17^4 \cdot 17^1$:  $$17^{13} \equiv 18 \cdot 8 \cdot 17 \pmod{23} \equiv 144 \cdot 17 \pmod{23} \equiv (6) \cdot 17 \pmod{23} \equiv 102 \pmod{23}\equiv10\pmod{23}$$$x_q = 10$ 
  3. Compute $x$ (Final Recombination) $$x = (M_p \cdot q \cdot x_p + M_q \cdot p \cdot x_q) \pmod n$$ $$x = (2 \cdot 23 \cdot 8 + 20 \cdot 15 \cdot 10) \pmod{345}$$$$x = (368 + 3000) \pmod{345}$$$$x = 3368 \pmod{345}$$ $3368 \div 345 = 9$ with a remainder of $263$. Answer: The decrypted value is 263.

Q5 (10 points). Discuss whether the mutual authentication Protocol 1 is secure. If it is secure, give the security analysis; otherwise, present the attack and improve it to be secure. (Certificates are omitted from its description, but they are assumed to be included in the scheme in the usual way. $y=sig_{Alice}(x)$ is Alice's signature of x, $ver_{Alice}(x,y)$ is the verification of y on x using Alice's public key. $y=sig_{Bob}(x)$ is Bob's signature of $x,$ $ver_{Bob}(x,y)$ is the verification of y on x using Bob's public key.)
Protocol 1: UNKNOWN PROTOCOL.
1. Bob chooses a random challenge, $r_{1},$ and he sends it to Alice.
2. Alice chooses a random challenge, $r_{2}$, she computes $y_{1}=sig_{Alice}(r_{1}),$ and she sends $r_{2}$ and $y_{1}$ to Bob.
3. Bob checks that $ver_{Alice}(r_{1},y_{1})=true$; if so, then Bob "accepts"; otherwise, Bob "rejects." Bob also computes $y_{2}=sig_{Bob}(r_{2})$ and he sends $y_{2}$ to Alice.
4. Alice checks that $ver_{Bob}(r_{2},y_{2})=$ true. If so, then Alice "accepts"; otherwise, Alice "rejects."
> This protocol is vulnerable to a Man-in-the-Middle attack. Eve, can position herself between Alice and Bob and trick them into thinking they are authenticating with each other, when in fact they are both authenticating with Eve.
>1.  **Bob Initiates with Eve:** Bob wants to talk to Alice and sends his random challenge, but unknowingly initiates the protocol with Eve.
    -   `Bob -> Eve: r1`
>2.  **Eve Initiates with Alice:** Eve takes Bob's challenge `r1` and uses it to initiate a separate session with Alice, impersonating Bob.
    -   `Eve -> Alice: r1`
>3.  **Alice Responds to Eve:** Alice, thinking she is talking to Bob, responds with her own challenge `r2` and signs the challenge she received, sending both back.
    -   `Alice -> Eve: r2, y1 = sig_Alice(r1)`
>4.  **Eve Forwards to Bob:** Eve now has the signature she needs to convince Bob that she is Alice. She forwards Alice's response to Bob.
    -   `Eve -> Bob: r2, y1`
>5.  **Bob Authenticates Eve (as Alice):** Bob receives `r2` and `y1`. He checks if `ver_Alice(r1, y1)` is true. Since `y1` is a valid signature from Alice on his original challenge `r1`, the verification succeeds. Bob now incorrectly believes he has authenticated Alice.
>6.  **Bob Responds to Eve:** Following the protocol, Bob signs the challenge `r2` he received.
    -   `Bob -> Eve: y2 = sig_Bob(r2)`
>7.  **Eve Forwards to Alice:** Eve takes Bob's signature `y2` and forwards it to Alice to complete the second session.
    -   `Eve -> Alice: y2`
>8.  **Alice Authenticates Eve (as Bob):** Alice receives `y2` and checks if `ver_Bob(r2, y2)` is true. Since `y2` is a valid signature from Bob on her original challenge `r2`, the verification succeeds. Alice now incorrectly believes she has authenticated Bob.
 When Alice signs `r1`, she is simply signing a random number. She has no way to enforce that this signature is intended for a session with Bob. A secure protocol would require the signed message to include identifiers to prevent this attack.
 Secure Version:
  Alice should compute: $y_1 = sig_{Alice}(r_1, ID_{Bob})$
  If Alice does this, the attack fails:
   1. Bob sends $r_1$.
>   1. Eve sends $r_1$ to Alice.
   2. Alice sees the request is from Eve (or on a channel with Eve) and signs $y = >     sig_{Alice}(r_1, ID_{Eve})$.
   3. Eve forwards this to Bob.
>   1. Bob checks $ver_{Alice}(r_1, y)$ against his own ID ($ID_{Bob}$). The verification
      fails because the signed data contains $ID_{Eve}$, not $ID_{Bob}$.

Q6 (12 points). Here is a variation of the ElGamal Signature Scheme. The key is constructed in a similar manner as before: Alice chooses $\alpha\in Z_{p}^{*}$ to be a primitive element, $0\le a\le p-2$ where $gcd(a,p-1)=1$, and $\beta=\alpha^{a}$ mod p. The key $K=(\alpha,a,\beta),$ where $\alpha$ and $\beta$ are the public key and a is the private key. Let $x\in Z_{p}$ be a message to be signed. Alice chooses $0\le k\le p-2$ and computes the signature $sig(x)=(\gamma,\delta)$ where $\gamma=\alpha^{k}$ mod p, and $\delta=(x-k\gamma)a^{-1}$ mod $(p-1)$.
Answer the following questions concerning this modified scheme.
a). Describe how a signature $(\gamma,\delta)$ on a message x would be verified using Alice's public key.
>  1. Start with the signature generation equation for $\delta$: $\delta \equiv (x - k\gamma)a^{-1} \pmod{p-1}$
>  2. Multiply both sides by $a$ to remove the inverse: $a\delta \equiv x - k\gamma \pmod{p-1}$
>  3. Rearrange the terms to isolate $x$: $a\delta + k\gamma \equiv x \pmod{p-1}$
>  4. Raise the generator $\alpha$ to the power of both sides. If the exponents are congruent modulo $p-1$, then the powers are congruent modulo $p$ (by Fermat's Little Theorem): $\alpha^{a\delta + k\gamma} \equiv \alpha^{x} \pmod{p}$
   5. Expand the left side using exponent rules: $(\alpha^{a})^{\delta} \cdot (\alpha^{k})^{\gamma} \equiv \alpha^{x} \pmod{p}$
>  6. Substitute the public key components and signature values:
   >  * We know $\beta \equiv \alpha^{a} \pmod{p}$.
   * We know $\gamma \equiv \alpha^{k} \pmod{p}$.
 >     Substituting these in yields the verification equation: $$ \beta^{\delta} \cdot \gamma^{\gamma} \equiv \alpha^{x} \pmod{p} $$
> Verification Algorithm:
  To verify the signature $(\gamma, \delta)$ for message $x$:
   6. Compute $V_1 = \beta^{\delta} \cdot \gamma^{\gamma} \pmod p$.
>   5. Compute $V_2 = \alpha^{x} \pmod p$.
   7. Check if $V_1 = V_2$. If they are equal, the signature is valid

b). Suppose that two people (say Alice and Bob) using this variation of the ElGamal Signature Scheme happen to use the same k-value to sign two messages. Additionally, we assume that Alice and Bob employ the same values of p and $\alpha$. Alice has $\beta_{1}=\alpha^{a_{1}}$ mod p and Bob has $\beta_{2}=\alpha^{a_{2}}$ mod p, where $|a_{1}-a_{2}|\le c,$ for some small constant $c\le$ 1000000. Alice has created a signature $(\gamma,\delta_{1})$ on a message x1, and Bob has created a signature $(\gamma,\delta_{2})$ on a message x2. Then it is almost always possible for an adversary to easily compute Alice's and Bob's secret keys (a1 and a2, respectively), without solving the corresponding instances of the Discrete Logarithm problem. Describe how an adversary can first compute $c=a_{1}-a_{2}$ and then compute Alice's and Bob's secret keys ($a_1$ and $a_2$, respectively). Note that if c is small in absolute value, it is feasible to compute c from $\alpha^{c}$ mod p. 
>  1. Recovering the Difference $C = a_1 - a_2$
   We are given two signature equations from the problem statement:
   1. Alice: $a_1 \delta_1 \equiv x_1 - k\gamma \pmod{p-1}$
>   2. Bob: $a_2 \delta_2 \equiv x_2 - k\gamma \pmod{p-1}$
   We don't know $k$, but it is the same in both equations. Let's isolate the $k\gamma$ term in both:  
	$k\gamma \equiv x_1 - a_1 \delta_1 \pmod{p-1} \equiv x_2 - a_2 \delta_2 \pmod{p-1}$
  Setting them equal to eliminate $k\gamma$:
	   $x_1 - a_1 \delta_1 \equiv x_2 - a_2 \delta_2 \pmod{p-1}$
  Rearranging to group the unknown private keys $a_1$ and $a_2$:
	  $a_1 \delta_1 - a_2 \delta_2 \equiv x_1 - x_2 \pmod{p-1}$
  This doesn't immediately solve for $a_1$ or $a_2$. However, we can also exploit the public keys.
  $\beta_1 = \alpha^{a_1} \pmod p$
  $\beta_2 = \alpha^{a_2} \pmod p$
  Let's look at the ratio of their public keys to find information about the difference $C = a_1 - a_2$: $$ \frac{\beta_1}{\beta_2} \equiv \alpha^{a_1} \cdot \alpha^{-a_2} \equiv \alpha^{a_1 - a_2} \equiv \alpha^C \pmod p
  $$The adversary computes $V = \beta_1 \cdot (\beta_2)^{-1} \pmod p$.
  We know that $V \equiv \alpha^C \pmod p$. Since $C$ is small ($|C| \le 1,000,000$), the adversary can easily
  brute-force this by checking $\alpha^i \pmod p$ for $i \in [-1000000, 1000000]$ until a match with $V$ is found.
  This reveals the exact integer value of $C = a_1 - a_2$.
  2. Recovering the Secret Keys $a_1$ and $a_2$
>Now that we know $C$, we can substitute $a_1 = a_2 + C$ back into our combined linear equation: 
>	$(a_2 + C)\delta_1 - a_2 \delta_2 \equiv x_1 - x_2 \pmod{p-1}$  
>Expand and group terms by $a_2$:
>	$a_2 \delta_1 + C \delta_1 - a_2 \delta_2 \equiv x_1 - x_2 \pmod{p-1}$
	  $a_2(\delta_1 - \delta_2) \equiv x_1 - x_2 - C \delta_1 \pmod{p-1}$
  This is a linear congruence of the form $A \cdot a_2 \equiv B \pmod{p-1}$, where:
   * $A = \delta_1 - \delta_2$
>   * $B = x_1 - x_2 - C \delta_1$
  All values on the right-hand side ($x_1, x_2, C, \delta_1, \delta_2$) are known. The adversary can solve this linear
  congruence for $a_2$.
   * Calculate $g = \gcd(A, p-1)$.
>   * If $g$ divides $B$, there are $g$ solutions for $a_2$. Since $p$ is large and primes are usually chosen such that $p-1$ has large factors, $g$ is likely small (often 1).
   * Multiply $B/g$ by the modular inverse of $A/g$ modulo $(p-1)/g$ to find $a_2$.
>  Once $a_2$ is found, simply compute $a_1 = a_2 + C$. The adversary can verify the correct pair $(a_1, a_2)$ by checking if $\alpha^{a_1} \equiv \beta_1 \pmod p$.
  Summary of Attack Steps:
   1. Compute $V = \beta_1 \cdot \beta_2^{-1} \pmod p$.
>   2. Brute-force the small range $[-c, c]$ to find $C$ such that $\alpha^C \equiv V \pmod p$.
   2. Substitute $a_1 = a_2 + C$ into the linear relation derived from the signatures: $a_2(\delta_1 - \delta_2) \equiv (x_1 - x_2 - C\delta_1) \pmod{p-1}$.
>   4. Solve this linear equation for $a_2$.
   3. Compute $a_1 = a_2 + C$.

---

### **Exam 2024**
Q1 (10 points). Classic Ciphers
i. For the plaintext "FINAL," write the corresponding ciphertext using the following encryption methods:
a) Caesar cipher.
> ILQDO

b) Affine cipher with $K=(5,1)$
> APOBE

c) Hebern rotor cipher with $K=O$.
>TXDRD

ii. For the ciphertext "EXAM," write the corresponding plaintext using the following encryption method:
d) Affine cipher with $K=(5,1),$
> VLBI

iii. If the alphabet includes not only lowercase (a-z) and uppercase letters (A-Z) (case-sensitive) but also the 10 digits from 0 to 9, how many possible keys are there for each of the following encryption methods?
e) Shift cipher
> 62

f) Substitution cipher
> 62!

g) Vigenère cipher with a key length of 4
> 62^4

h) Affine cipher
> 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,33,35,37,39,41,43,45,47,49,51,53,55,57,59 := 29
> 29 x 62 = 1798

iv. In the later stages of World War II, Germany enhanced the original Enigma encryption machine by adding an additional rotor. This required every German soldier to select 4 rotors from a set of 6 before use.
i) For the enhanced Enigma machine, how many possible keys are there in total? (you only need to write down the computation formula, no need to calculate the detail values)
> $keys = (5\times4\times3)(26^3)[26! / (6! \times 10! \times 2^{10})]$


Q3 (12 points). RSA Cryptosystem.
Suppose Alice's RSA modulus is $n=203=7\times29,$ that is, $p=7$ and $q=29,$
a) How many possible private keys are there?
> $\phi(n)=(7-1)(29-1)=168$
>  Find the prime factorization $168 = 2^3 \times 3 \times 7$ 
>  Now, we use the formula for Euler's totient function: $$ \phi(N) = N \prod_{r|N, r \text{ is prime}} \left(1 - \frac{1}{r}\right) $$ Applying this to $N=168$:  $$ \begin{aligned}
  \phi(168) &= 168 \times \left(1 - \frac{1}{2}\right) \times \left(1 - \frac{1}{3}\right) \times \left(1 -
  \frac{1}{7}\right) \\
    &= 168 \times \left(\frac{1}{2}\right) \times \left(\frac{2}{3}\right) \times \left(\frac{6}{7}\right) \\
   &= \frac{168 \times 1 \times 2 \times 6}{2 \times 3 \times 7} \\
   &= \frac{2016}{42} \\
  &= 48 
  \end{aligned}$$

b) Alice's public key component is $e=17$.
i) Find Alice's private key d.
> $17d\equiv1\pmod{168}$
> $$ \begin{aligned}
 gcd(168,17) &= 1 \\ 
 168 &= 17(9) + 15 \\
 17 &= 15(1) + 2 \\
 15 &= 2(7) + 1 \\
 \\
 gcd(168,17) &= 1 = 15 - 2(7) \\
 &= 15 - (17 - 15)(7) = (8)(15) - (7)(17) \\
 &= (8)(168 - 17(9)) - (7)(17) = (8)(168) - (79)(17) \\
 d &= -79 \\
 d &= -79 + 168 = 89
 \end{aligned}
 $$
 
ii) Given a message $m=101$ and the hash function H: $y=x^{10}$ mod 23, find Alice's digital signature of m.
> $H(101)=101^{10}\mod23 \equiv 9^{10}\mod23$ 
> $9^2 = 81 \equiv 12 \pmod{23} \quad (since\ 81 - 3 \times 23 = 12)$
  $9^4 \equiv 12^2 = 144 \equiv 6 \pmod{23} \quad (since\ 144 - 6 \times 23 = 6)$
  $9^8 \equiv 6^2 = 36 \equiv 13 \pmod{23} \quad (since\ 36 - 23 = 13)$
  $9^{10} = 9^8 \times 9^2 \equiv 13 \times 12 = 156 \pmod{23} = 18$
  $h = 18$
> $\sigma=18^{89}\mod203$
> $18^2 = 324 \equiv 121$
> $18^4 = 121^2 \equiv 25$
> $18^8 \equiv 25^2 \equiv 16$
> $18^{16} \equiv 16^2 \equiv 53$
> $18^{32} \equiv 53^2 \equiv 170$
> $18^{64} \equiv 170^2 \equiv 74$
> $18^{89} = 18^{64}\times18^{16}\times18^8\times18 \equiv 74 \times 53 \times 16 \times 18 \equiv 44$

iii) What's the ciphertext of the message $m=30?$
> $c=30^{17}\mod203$
> $30^2\equiv88$
> $30^4 \equiv 88^2 \equiv 30$
> $30^8 \equiv 30^2 \equiv 88$
> $30^{16} \equiv 88^2 \equiv 30$
> $30^{17} = 30{16} \times 30 \equiv 30 \times 30 \equiv 88$
> $c=88$

c) If the RSA signing algorithm is changed to be $\sigma=m^{d}$ mod n, is the variant still secure? Why?
> No:
>  1. Multiplicative Attack: If an attacker has valid signatures $\sigma_1$ and $\sigma_2$ for messages $m_1$ and $m_2$, they can construct a valid signature for the message $m_{new} = m_1 \times m_2 \pmod n$ without knowing the private key $d$. $\sigma_{new} = \sigma_1 \times \sigma_2 \equiv m_1^d \times m_2^d \equiv (m_1 \times m_2)^d \pmod n$
   2. Arbitrary Signature Generation: An attacker can pick a random signature $\sigma$ first and then compute the corresponding message $m$ using the public key $e$: $m = \sigma^e \pmod n$ The pair $(m, \sigma)$ is a valid message-signature pair, even though the attacker did not generate it using the private key. While $m$ might look like gibberish, it is technically a validly signed message.

d) Security of RSA
i) What is the underlying hard problem in the RSA cryptosystem?
> Integer factorization problem. Specifically, it relies on the computational difficulty of factoring a large composite number $n$ (which is the product of two large prime numbers $p$ and $q$) into its two prime factors. If an attacker can efficiently factor $n$ into $p$ and $q$, they can then compute $\phi(n) = (p-1)(q-1)$ and subsequently determine the private key $d$ from the public key $e$, thereby compromising the security of the system.

ii) Can you explain why the RSA cryptosystem is secure?
>  The security of the RSA cryptosystem rests on the assumption that reversing the "trapdoor function" is computationally infeasible without the private key. Specifically:
   1. Intractability of Factoring: RSA is secure because the underlying mathematical problem—Integer Factorization—is considered computationally hard for large numbers. The public modulus $n$ is the product of two large primes ($p$ and $q$). To break RSA (i.e., to find the private key $d$ from the public key $(n, e)$), an attacker generally needs to calculate Euler's totient function $\phi(n) = (p-1)(q-1)$. Finding $\phi(n)$ is equivalent in difficulty to finding $p$ and $q$. For sufficiently large key sizes (e.g., 2048-bit or 4096-bit), no efficient algorithm currently exists on classical computers that can factor $n$ in a reasonable amount of time. 
> 2. The Discrete Root Problem (RSA Problem): Even if an attacker doesn't factor $n$, decrypting a specific ciphertext $c$ to get message $m$ requires solving the equation $m^e \equiv c \pmod n$ for $m$. This is known as computing the $e$-th root modulo $n$. This problem is conjectured to be as hard as factoring $n$, meaning there is no known way to solve it efficiently without knowing the prime factors of $n$.
> In short, RSA is secure because "easy" operations (multiplication and exponentiation) are used to construct a "hard" to reverse operation (factoring large numbers and finding modular roots), creating a one-way function with a secret trapdoor.

Q4 (12 points). EC Digital Signature
Consider the digital signature scheme presented in Scheme 1.
Scheme 1. FIRST ECC DIGITAL SIGNATURE
We have a global elliptic curve, prime p, and "generator" G.
Alice picks a private signing key $X_{A}$ and forms the public verifying key $Y_{A}=X_{A}G$.
To sign a message M:
- Alice picks a value k.
- Alice sends Bob M, k, and the signature $S=M-kX_{A}G.$
- Bob verifies that $M=S+kY_{A}$
a) What is the underlying hard problem on which the security of this digital signature scheme depends?
> Elliptic Curve Discrete Logarithm Problem. Given the generator G and the public key $Y_A$ it is computationally infeasible to find the private signing key $X_A$. 

b) Show that this scheme works. That is, show that the verification process produces an equality if the signature is valid.
> To show that the verification process produces an equality if the signature is valid, we substitute the definitions of the public key and the signature into the verification equation. $$ \begin{aligned}
M &= S + kY_A \\
&= (M - kX_AG) + kY_A \\
0 &= k(-X_AG +Y_A) \\
&= k(-Y_A + Y_A) = 0
\end{aligned}$$

c) Show that the scheme is unacceptable by describing a simple technique for forging a user's signature on an arbitrary message.
> Create a signature $S = M - kY_A$ 

Now, consider the digital signature scheme presented in Scheme 2.
Scheme 2. FIRST ECC DIGITAL SIGNATURE
we have a global elliptic curve, prime p, and "generator" G. Alice picks a private signing key $X_{A}$ and forms the public verifying key $Y_{A}=X_{A}G$. To sign a message M:
- Bob picks a value k.
- Bob sends Alice $C_{1}=kG$.
- Alice sends Bob M and the signature $S=M-X_{A}C_{1}$
- Bob verifies that $M=S+kY_{A}$
d) Show that this scheme works. That is, show that the verification process produces an equality if the signature is valid.
>  To show that the verification process produces an equality if the signature is valid, we substitute the definitions of the public key and the signature into the verification equation. $$ \begin{aligned}
>  M &= S + kY_A  \\
>  &= M - X_AC_1 + kY_A \\
>  &= M - X_AC_1 + kX_AG \\
>  &= M - X_A(C_1 - kG) \\
>  &= M - X_A(kG - kG) \\
>  M &= M
\end{aligned} $$

e) Show that forging a message in this scheme is as hard as breaking (Elgamal) elliptic curve cryptography, or find an easier way to forge a message.
>  The attacker must produce: $S = M - kY_A$
>  The information available to the attacker
   * $M$: The message chosen by the attacker.
>   * $Y_A$: Alice's public key ($Y_A = X_A G$).
   * $C_1$: The challenge sent by Bob ($C_1 = kG$). The attacker intercepts this.
> To compute $S$, the attacker needs to calculate the term $kY_A$. 
> Substituting the known values:
   * The attacker has $kG$ (from $C_1$).
>   * The attacker has $X_A G$ (from $Y_A$).
   * The attacker needs to compute $k(X_A G) = k X_A G$.
> This is exactly the Computational Diffie-Hellman (CDH) Problem: Given $G$, $aG$ (here $kG$), and $bG$ (here $X_A G$),  compute $abG$ (here $k X_A G$).
  The security of ElGamal encryption relies on the same difficulty. In ElGamal, a ciphertext consists of $(C_1, C_2) =(kG, M + kY_A)$. To decrypt this without the private key, an attacker must compute the "shared secret" mask $kY_A$ using only $C_1$ ($kG$) and the public key $Y_A$ ($X_A G$). This is the CDH problem. Since forging a signature requires computing $kY_A$ from $kG$ and $Y_A$, and breaking ElGamal encryption also requires computing $kY_A$ from $kG$ and $Y_A$, forging a message in this scheme is exactly as hard as breaking ElGamal ECC.
> 

f) This scheme has an extra "pass" compared to other cryptosystems and signature schemes we have looked at. What are some drawbacks to this?
> The extra "pass" in Scheme 2 refers to the interactive step where Bob must first pick $k$ and send $C_1$ to Alice before Alice can generate the signature. This introduces several significant drawbacks compared to standard non-interactive signature schemes (like RSA or ECDSA):
    -  Offline Signing Impossible: Alice cannot sign a message for Bob if Bob is offline. They must both be online and communicating simultaneously. Alice cannot simply "post" a signed document for anyone to verify later; she needs a specific challenge from a specific verifier.
    - No "Public" Verification: The signature is generated specifically for Bob (based on his $k$). A third party (Carol) cannot verify the signature unless she also knows $k$ or trusts Bob's challenge generation, effectively making it a directed signature rather than a universally verifiable one.

Q4 (10 points). Digital Signature  
Consider the digital signature scheme presented in Scheme 1.  
Scheme 1. DIGITAL SIGNATURE - (Setup, KeyGen, Sign)  
Setup: The shared global public parameters $(p, g)$:  
– choose a large prime p with $2^{L-1} < p < 2^L$, where L= 512 to 1024 bits and is a multiple  
of 64  
– g is the generator of group $Z_p$.  
– H is a cryptographic hash function: $\{0,1\}*→Z_p-1$  
KeyGen: A user, Alice, chooses the private key x and computes the public key y:  
– choose a random private key: $x ∈ Z_p$  
– compute the public key: $y = g^x \mod p$  
Sign: to sign a message m, Alice:  
– generate a random value $k ∈ Z_p$, and compute $e= g^k \mod p$, k must be destroyed  
after use, and never be reused  
– compute the signature pair: $r = H(m||e), s = (k+xr) \mod p-1$  
– send the signature σ=(r, s) with message m
a) What is the underlying hard problem on which the security of this digital signature  
scheme depends?  
>The discrete logarithm problem.  Given a prime $p$, a generator $g$ of the multiplicative group $Z_p^*$, and an element $y \in Z_p^*$, it  is computationally infeasible to find the integer $x$ such that $y = g^x \pmod p$. In this scheme, an attacker would need to solve the DLP to derive Alice's private key $x$ from her public key $y$, $g$, and $p$.

b) Which of the following algorithms is used for verifying the signature σ= (r, s)?  
	A. The verifier computes $r’=H(m||g^s y^{-r} \mod p)$ and checks if r=r’.  
	B. The verifier computes $r’=H(m||g^s y^r \mod p)$ and checks if r=r’.  
	C. The verifier computes $r’=H(m||g^r y^s \mod p)$ and checks if r=r’.  
	D. The verifier computes $r’=H(m||g^r y^{-s} \mod p)$ and checks if r=r’.  
Please select all the correct answers and explain why. 
> A.  To determine the correct verification equation, we need to derive the condition that must hold true if the signature is valid.
   1. Analyze the Signature Generation:
>     * $e = g^k \pmod p$
       * $r = H(m || e)$
       * $s = (k + xr) \pmod{p-1}$
>   1. Express $k$ in terms of public values:
      From the equation for $s$, we can isolate $k$: $k \equiv (s - xr) \pmod{p-1}$
   3. Reconstruct $e$:
>      The verification process needs to recompute the value $e$ (let's call it $e'$) to feed into the hash function and check if the resulting $r'$ matches the received $r$.
      We know $e = g^k \pmod p$.
      Substitute the expression for $k$ we found in step 2:
      $e' = g^{(s - xr)} \pmod p$
      $e' = g^s \cdot g^{-xr} \pmod p$
      $e' = g^s \cdot (g^x)^{-r} \pmod p$
   4. Substitute the Public Key:
>      We know Alice's public key is $y = g^x \pmod p$.
      Substitute $y$ into the equation:     $e' = g^s \cdot y^{-r} \pmod p$
   5. Form the Verification Step:
>      The verifier computes $r'$ using this reconstructed $e'$:
		   $r' = H(m || e')$
      $r' = H(m || g^s y^{-r} \pmod p)$

c) Explain how an adversary can recover the secret key (i.e., x), when the signer, Alice,  
reuses the same random number k for signing two different messages.  
> $$ \begin{aligned}
	k &\equiv (s - xr)\pmod{p-1} \\
	k &\equiv (s' - xr')\pmod{p-1} \\
	s &= (s'-xr' - xr)\pmod{p-1} \\
	s &= (s'-x(r'-r))\pmod{p-1} \\
	x &\equiv (s'- s)(r' - r)^{-1}\pmod{p-1}
\end{aligned}$$This solution requires that $\gcd(r' - r, p-1) = 1$ for the inverse to exist uniquely. If the greatest common divisor is $d > 1$, there will be $d$ potential solutions for $x$. The adversary can easily test each candidate solution against the public key equation $y = g^x \mod p$ to find the correct private key.

d) Assume the digital signature of message m is computed as follows: $[r, s]=[g^ky^{H(m)} \mod p, H(m)(k + x · r) \mod p−1]$. Are there any security problems in the variant? If so, identify one and briefly justify it. If not, explain why not. (Note that in this question,  
you cannot assume that the signer will reuse the same random number k.)
> Assuming that the hash function is secure, this digital signature method has no security problems. 
> Security Problem:
  The scheme allows for Existential Forgery for specific messages. Specifically, if an attacker can find a message $m$ such that its hash value $H(m) \equiv 0 \pmod{p-1}$, they can forge a valid signature $(r, s)$ for that message
  without knowing the private key $x$.
  Justification:
  The verification equation for the signature is derived as follows:
  From $s \equiv H(m)(k + xr) \pmod{p-1}$, we can verify by checking if $g^s \equiv (g^k y^r)^{H(m)} \pmod p$.
  Substituting $g^k = r y^{-H(m)}$ (from the definition of $r$), the verification equation becomes: $$g^s \equiv (r \cdot y^{r - H(m)})^{H(m)} \pmod p$$ If an attacker finds a message $m$ where $H(m) \equiv 0 \pmod{p-1}$:
   1. The attacker sets $s = 0$.
>   1. The attacker chooses any arbitrary value for $r$ (e.g., $r = 1$).
>   2. The verification equation becomes:     $$g^0 \equiv (r \cdot y^{r - 0})^0 \pmod p \equiv 1 \pmod p$$ The equation holds true, making $(r, 0)$ a valid signature for message $m$. While finding a message with a specific hash value (preimage attack) is computationally difficult for secure hash functions, this represents a structural flaw where the security of the scheme collapses entirely for such messages.

Q5. (12 points) Elliptic Curve Cryptosystem
Given an Elliptic curve: $y^{2}=x^{3}+x+1$ and a point $Q=(0,1)$
(You maybe use the formula of addition and doubling:
$\lambda=\frac{y_{2}-y_{1}}{x_{2}-x_{1}}$, $x_{3}=\lambda^{2}-x_{1}-x_{2}$
$y_{3}=(x_{1}-x_{3})\lambda-y_{1}$, $\lambda=\frac{{3x_{1}}^{2}+a}{2y_{1}}$
$x_{3}=\lambda^{2}-2x_{1}$, $y_{3}=(x_{1}-x_{3})\lambda-y_{1}$
Hints: $1P=(3,10)$ $2P=(7,12)$ $4P=(17,3)$ $8P=(13,16)$ $16P=(5,19)$ $28P=O$)
a) What is the value of 2Q on real number field R?
> $$\begin{aligned}
\lambda &=\frac{{3x_{1}}^{2}+a}{2y_{1}}= \frac{3(0)^2+1}{2(1)} = \frac{1}{2} \\
x_{3} &=\lambda^{2}-2x_{1}= (\frac{1}{2})^2 -2(0)= \frac{1}{4} \\
y_3 &=(x_{1}-x_{3})\lambda-y_{1} = (0 - \frac{1}{4})(\frac{1}{2}) - 1 = -\frac{9}{8} \\ 2Q &= (\frac{1}{4},-\frac{9}{8})
\end{aligned}$$

Let E denote the elliptic curve $y^{2}=x^{3}+x+1$ defined over $Z_{23}$. It can be shown that $\#E=28$.
b) What is the value of 2Q on the group $E(Z_{23})$?
> $1\cdot4^{-1}\mod23\equiv 1\cdot6\equiv6\mod23$
 $-9\cdot8^{-1}\mod23\equiv14\cdot3\equiv42\equiv19\mod23$
 $2Q(6,19)$
 
c) What is the value of $\frac{1}{5}Q$ on the group $E(Z_{23})$?
> $$\begin{aligned}
5^{-1}\mod23&\equiv17\mod23 \\
\frac{1}{5}&=17Q=16Q+Q \\
\lambda&=\frac{{3(6)}^{2}+1}{2(19)}=109\cdot38^{-1}\equiv17\cdot15^{-1}\equiv17\cdot20\equiv18\mod23 \\
x_3&=18^2-2(6)=312\equiv13\mod23 \\
y_3&=(6-13)(18)-19=-145\equiv-7\equiv16\mod23\\
4Q&=(13,16)=8P \\
2(8P)&=16P=8Q=(5,19) \\
2(16P)&=32P=4P=16Q=(17,3) \\
17Q&= Q + 16Q\\
\lambda&=\frac{3 - 1}{17 - 0} =2\cdot17^{-1}\equiv2\cdot19\equiv38\equiv15\mod23 \\
x_3&=15^2-0-17=208\equiv1\mod23 \\
y_3&=(0-1)(15)-1=-16\equiv7\mod23 \\
17Q &=(1,7)
\end{aligned}$$
> 

Considering the Elliptic Curve ElGamal cryptosystem that is implemented in E. Set $P=$ (3, 10) as a generator. $a=3$ is the private key of Alice.
d) Compute the public key of Alice.
> $$\begin{aligned}
P_A&=3\alpha=3(3,10)=3P=P+2P=(3,10)+ (7,12) \\
\lambda&=\frac{12 - 10}{7 - 3} =1\cdot2^{-1}\equiv1\cdot12\equiv12\mod23 \\
x_3&=12^2-3-7=134\equiv19\mod23 \\
y_3&=(3-19)(12)-10=-202\equiv5\mod23 \\
P_A&=(19,5)
\end{aligned}$$

e) Suppose Bob needs to send a message $m=(0,22)$ to Alice. Bob chooses a random value $k=5$ for encryption. Compute the corresponding ciphertext of m.
> $C_1=k\alpha=5P=P+4P=(3,10) + (17,3)=(11,3)$
> $C_2=m+kP_A=m+5(3P)=m + 15P=(7,11)$

f) Show the decryption of the ciphertext ((11,3), (7,11)) from Bob.
> $m=C_2-aC_1=(7,11)-3(11,3)$

Q6. (12 points) Block Cipher Encryption.
Given the plaintext (00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F) 16 and the key (10 20 30 40 50 60 70 80 91 02 13 24 35 46 57 60)16, please use AES Encryption to:
a. Show the original contents of State, displayed as a $4\times4$ matrix.
>$$  \begin{pmatrix}
  00 & 04 & 08 & 0C \\
  01 & 05 & 09 & 0D \\
  02 & 06 & 0A & 0E \\
  03 & 07 & 0B & 0F
  \end{pmatrix}  $$
  
b. Show the value of State after initial AddRoundKey.
> $$  \begin{pmatrix}
  10 & 54 & 99 & 39 \\
  21 & 65 & 0B & 4B \\
  32 & 76 & 19 & 59 \\
  43 & 87 & 2F & 6F
  \end{pmatrix}  $$
  
c. Show the value of State after SubBytes.
> $$  \begin{pmatrix}
  CA & 20 & EE & 12 \\
  FD & 4D & 2B & B3 \\
  23 & 38 & D4 & CB \\
  1A & 17 & 15 & AB
  \end{pmatrix}  $$

d. Show the value of State after ShiftRows.
> $$  \begin{pmatrix}
  CA & 20 & EE & 12 \\
  4D & 2B & B3 & FD\\
  D4 & CB & 23 & 38\\
  AB& 1A & 17 & 15
  \end{pmatrix}  $$

e. Why do we no longer use DES encryption recently?
>    1. Small Key Space (56-bit Key): DES uses a 56-bit key (the remaining 8 bits of the 64-bit input are for parity). This results in only $2^{56}$ (approx. 72 quadrillion) possible keys. While this was sufficient in the 1970s, Moore's Law and advances in computing power have made exhaustive key search trivial. Specialized hardware (like the EFF's "Deep Crack" in 1998) and modern distributed computing can crack DES keys in hours or even minutes.
   2. Small Block Size (64-bit): DES operates on 64-bit blocks. Encrypting large amounts of data (more than $2^{32}$ blocks) with the same key using modes like CBC creates vulnerabilities due to the "birthday paradox" (collision probability), potentially revealing information about the plaintext.

f. Why don't we use 2DES to enhance DES?
>    1. The Concept of 2DES: Involves encrypting a message twice using two different 56-bit keys ($K_1$ and $K_2$). $C = E_{K2}(E_{K1}(P))$ Intuitively, one might expect this to double the effective key length to $56 + 56 = 112$ bits, making the search space $2^{112}$.
   2. The Meet-in-the-Middle Attack:
>       * This attack exploits the fact that the encryption and decryption operations meet "in the middle."
       * Given a known plaintext-ciphertext pair $(P, C)$:
           1. Encrypt Forward: The attacker encrypts $P$ with all $2^{56}$ possible values of $K_1$ and stores the results in a lookup table (memory).
               * $X = E_{K1}(P)$
           2. Decrypt Backward: The attacker decrypts $C$ with all $2^{56}$ possible values of $K_2$.
               * $X' = D_{K2}(C)$
           3. Match: For each result $X'$, the attacker checks if it exists in the stored table of $X$ values. If $X = X'$, the corresponding pair $(K_1, K_2)$ is a candidate key.
       * This reduces the effort from $2^{112}$ operations to roughly $2^{57}$ operations (plus significant memory storage).
       * Since $2^{57}$ is only marginally harder than breaking single DES ($2^{56}$), 2DES fails to provide the expected square of security.

---

### **Exam 2022**
Q1 (20 points).
a) What are the differences between transport mode and tunnel mode in IPsec protocol?
> Transport mode provides protection for the upper-layer protocols like TCP and UDP. Tunnel mode provides protection for the entire IP packet. In transport mode AH authenticates and ESP encrypts the IP payload but not the whole IP header. In tunnel mode the entire original IP packet is treated as a payload of a new outer packet so the entire inner IP packer is authenticated and encrypted. Transport mode is typically used for end-to-end communication between hosts while tunnel mode is used between security gateways to create VPNs. 

b) What are the security properties offered by the AH protocol?
> The AH provides integrity and authentication for IP packets. It provides a sequence number to prevent replay attacks. It includes a integrity check value or a message authentication code that is calculated over the immutable and predictably mutable fields of the IP header. 

c) What are the security properties offered by the ESP protocol?
> ESP provides confidentiality and optionally authentication services. It provides a sequence number to prevent replay attacks. It encrypts the payload data, padding, pad length and next header fields. If authentication is enabled ICV is computed over the ESP packet typically after encryption. Padding is done to align the plaintext with the block size, alignment to 32 bit words, and obscure the length of the original data.

d) What are the steps for the gateways with the IPsec protocol to handle IP packets sent from host A to host B in ESP tunnel model?
> 1. The packet is routed from host A to its network's gateway.
> 2. Gateway A performs IPsec processing which includes encrypting and optionally authenticates the entire original IP packet including the inner header and payload. Encapsulates the packet with a new outer IP header and sets the destination to Gateway B's address.
> 3. The packet is routed across the network to gateway B
> 4. Gateway B receives the packet, examines the outer IP header and performs IPsec processing. It decrypts and authenticates the inner packet an strips off the outer IP header.
> 5. Gateway B forwards the decrypted packet to the host

e) What are the security functions offered by the SSL/TLS handshake protocol?
> The handshake protocol allows the server and client to authenticate each other, negotiate the cipher suite, create cryptographic keys, and establish a TLS session and subsequently a connection. 

f) Describe the detailed processes of the SSL/TLS handshake protocol (including 4 stages).
> 1. Establish security capabilities: The client sends a client hello message proposing its security capabilities including its TLS version, cipher suites and compression algorithms. The server responds with a server hello message choosing the common security capabilities often choosing the highest version of security supported by both the client and sever. Both messages include a random number to prevent replay attacks and optionally a session ID to resume a session or create a new one.
> 2. Server authentication and key exchange: The sever sends its digital certificate to the client which typically contains the severs public key and is verified by the client using trusted certificate authorities. If Diffie-Hellman parameter exchange is needed the server will exchange a key. If the sever requires client authentication it sends a certificate request. The sever signals that is has finished its part of the initial handshake messages. 
> 3. Client authentication and key exchange: The client sends a certificate chain if requested by the sever. The client generates a pre master secret or other key parameters and encrypts it with the severs public key. This is used by both parties to derive the master secret and subsequently the MAC key, encryption keys and IVs. If the client sent a certificate it uses the private key to sign a hash of the handshake messages. The server verifies this  signature using the clients public key.
> 4. Finish handshake: Both the client and server send change cipher spec messages. This signals a transition to the newly negotiated parameters. After this message all subsequent communication will use the new cipher suite and keys. Both the client and the server send finished messages. These are encrypted and MACed using the established keys. The server sends a final verification that the handshake was successful and that both parties have correctly derived the same keys.  

Q2 (10 points). Suppose g is a collision resistant hash function that takes an arbitrary bitstring as input and produces an n-bit message digest. Define a hash function h as follows:
$h(x)=\begin{cases}0||x \text{ if x is a bitstring of length n}\\ 1||g(x) \text{ otherwise}\end{cases}$ 
a) Prove that h is collision resistant.
> Case 1: Both outputs start with `0`.
    This implies that $|x| = n$ and $|x'| = n$.
          By the definition of $h$, we have:
          $h(x) = 0 || x$
          $h(x') = 0 || x'$
          If $h(x) = h(x')$, then $0 || x = 0 || x'$, which implies $x = x'$.
          However, this contradicts our initial assumption that $x \neq x'$. Thus, a collision of this type is impossible.
   Case 2: Both outputs start with `1`.
          This implies that $|x| \neq n$ and $|x'| \neq n$.
          By the definition of $h$, we have:
          $h(x) = 1 || g(x)$
          $h(x') = 1 || g(x')$
          If $h(x) = h(x')$, then $1 || g(x) = 1 || g(x')$, which implies $g(x) = g(x')$.
          Since $x \neq x'$, this means we have found two distinct inputs $x$ and $x'$ that produce the same hash under $g$. This constitutes a collision for the function $g$. Given $g(x)$ is collision resistant is must be impossible to find a collision in $h$.

b) Prove that h is not preimage resistant. More precisely, show that preimages (for the function h) can easily be found for half of the possible message digests.
> Given a hash value $h(x)$, if the hash value starts with 0 then $h(x)=0||x$. Therefore it is easy to find the message $x$ simply by removing the first bit of any hash value that starts with 0. This is true for half of the possible message digests because $g(x)$ maps to an n bit message, meaning there are $2^n$ possibilities. There are also $2^n$ possibilities for any input message of length n. Therefore there are $2^{n+1}$ total possibilities for the $h(x)$ and $2^n$ preimages can easily be found using the method mentioned which is equivalent to half of the possible message digests. 

Q3 (20 points). For $n=pq,$ where p and q are distinct odd primes, define
$\lambda(n)=\frac{(p-1)(q-1)}{gcd(p-1,q-1)}.$
Suppose that we modify the RSA digital signature by requiring that $ed \equiv1 \mod \lambda(n)$. Other operations are the same as the original RSA digital signature.
a. Prove that Sign and Verify algorithms are still inverse operations in this modified digital signature (the hash function is not considered here).
> $\lambda(n) = \frac{(p-1)(q-1)}{\gcd(p-1, q-1)} = \text{lcm}(p-1, q-1)$
   Since $n = pq$ and $\gcd(p, q) = 1$, by the Chinese Remainder Theorem, $m^{ed} \equiv m \pmod n$ holds if and only if: $m^{ed} \equiv m \pmod p$ and $m^{ed} \equiv m \pmod q$
> $$\begin{aligned}
	m^{p-1} &\equiv 1 \pmod p \\
	m^{ed} &= m^{1 + k \cdot a(p-1)} = m^1 \cdot (m^{p-1})^{ka} \\
	m^{ed} &\equiv m \cdot (1)^{ka} \pmod p \\
	m^{ed} &\equiv m \pmod p  \\
	\\
	m^{q-1} &\equiv 1 \pmod q \\
	m^{ed} &= m^{1 + k \cdot b(q-1)} \equiv m \cdot (1)^{kb} \equiv m \pmod q
	\end{aligned}$$
	Since $m^{ed} \equiv m \pmod p$ and $m^{ed} \equiv m \pmod q$, it follows that: $m^{ed} \equiv m \pmod{pq}$ $m^{ed} \equiv m \pmod n$ Therefore, the Verify operation $S^e \pmod n$ correctly recovers the original message $m$, proving that Sign and Verify are inverse operations.

b. If $p=19,$ $q=37,$ and $e=5$, compute d in this modified digital signature.
> $\lambda(n)=\frac{(19-1)(37-1)}{gcd(18,36)}=\frac{648}{18}=36$
> $5d\equiv1\mod36$
> $$\begin{aligned}
  gcd(36,5) &= 1 \\
  36 &= 5(7) + 1 \\
  \\ 
  1 &= 36 - (7)5 \\
  d &= -7 \equiv 29\mod36
  \end{aligned}$$

c. If the hash value of the message m to be signed is $H(m)=17$ compute the digital signature o of the message m with the public-private key pair obtained in Q3.b (Use the Repeated Squaring Algorithm and show the calculation steps).
> $\sigma=H(m)^d\pmod{n}=17^{29}\pmod{703}$
> $$\begin{aligned}
  17^2 & =289 \\
  17^4 &= 289^2\equiv567 \\
  17^8 &= 567^2 \equiv 218 \\
  17^{16} &= 218^2\equiv423 \\
  17^{29} &= 17^{16}\cdot17^8\cdot17^4\cdot17\equiv423\cdot218\cdot567\cdot17\equiv 42
  \end{aligned}$$

d. If we modify the RSA digital signature by removing the hash function H in Sign algorithm, is this modification secure? Why?
>  No:
>  1. Multiplicative Attack: If an attacker has valid signatures $\sigma_1$ and $\sigma_2$ for messages $m_1$ and $m_2$, they can construct a valid signature for the message $m_{new} = m_1 \times m_2 \pmod n$ without knowing the private key $d$. $\sigma_{new} = \sigma_1 \times \sigma_2 \equiv m_1^d \times m_2^d \equiv (m_1 \times m_2)^d \pmod n$
   2. Arbitrary Signature Generation: An attacker can pick a random signature $\sigma$ first and then compute the corresponding message $m$ using the public key $e$: $m = \sigma^e \pmod n$ The pair $(m, \sigma)$ is a valid message-signature pair, even though the attacker did not generate it using the private key. While $m$ might look like gibberish, it is technically a validly signed message.

Q4 (10 points). Discuss whether the mutual authentication Protocol 1 is secure. If it is secure, give the security analysis; otherwise, present the attack and improve it to be secure.
Protocol 1: MUTUAL AUTHENTICATION
1. Bob chooses a random challenge, $r_1$. He sends ID(Bob) and $r_1$ to Alice.
2. Alice chooses a random challenge, $r_2$. She computes $y_{1}=MAC_{k}(r_{1})$ and she sends ID(Alice), $r_2$ and $y_1$ to Bob.
3. Bob checks that $MAC_{k}(r_{1})=y_{1}$. If so, then Bob "accepts"; otherwise, Bob "rejects." Bob also computes $y_{2}=MAC_{k}(r_{2})$ and he sends y2 to Alice.
4. Alice checks that $MAC_{k}(r_{2})=y_{2}.$ If so, then Alice "accepts"; otherwise, Alice "rejects."
(K is the secret key shared between Alice and Bob, $MAC_{k}(x)$ is the message authentication code on the message x using the secret key K. ID(Alice) is the identity of Alice, and ID(Bob) is the identity of Bob).
>  Protocol 1 is NOT secure.
  It is vulnerable to a Reflection Attack (also known as a Parallel Session Attack). This
  occurs because the protocol is symmetric—the messages look the same regardless of who is
  initiating or responding, and the cryptographic proof ($MAC_k(r)$) does not contain
  information about the direction of the communication or the identity of the sender.
  Security Analysis (The Attack):
  Suppose Eve wants to impersonate Alice to Bob.
   1. Session 1: Bob initiates a connection to Alice. He generates a nonce $r_1$ and sends
>      ID(Bob), r1 to Eve (who intercepts the message).
   2. Session 2: Eve initiates a new, separate connection with Bob (or Alice),
>      impersonating the other party. She sends Bob's own nonce r1 back to him as her
      challenge: ID(Alice), r1.
   3. Session 2: Bob, believing he is responding to a valid challenge from Alice, computes
>      y = MAC_k(r1) and sends it to Eve.
   4. Session 1: Eve takes this value y and sends it to Bob in the first session as the
>      response to his original challenge: ID(Alice), r2, y.
   5. Result: Bob verifies MAC_k(r1) == y and accepts Eve as Alice, even though Eve does
>      not know the key $K$.
  Improvement to be Secure:
  To prevent this attack, the MAC calculation must bind the response to the specific
  identities and the role (sender/receiver) to distinguish between a message from Alice to
  Bob and a message from Bob to Alice.
  Improved Protocol:
  Modify the MAC calculation to include the identity of the sender (or the intended
  recipient).
   6. Bob chooses $r_1$. Sends ID(Bob), r1 to Alice.
>   1. Alice chooses $r_2$. She computes $y_1 = MAC_K(r_1, ID(Alice))$. She sends ID(Alice),
>      r2, y1 to Bob.
   7. Bob checks that $y_1$ matches the MAC calculated with Alice's ID. If valid, he computes $y_2 = MAC_K(r_2, ID(Bob))$ and sends y2 to Alice.
   8. Alice checks that $MAC_K(r_2, ID(Bob)) == y_2$.
>  Why this fixes the attack:
  In the reflection attack steps above, Bob (in Session 2) would generate $MAC_K(r_1,ID(Bob))$ because he is the one sending the response. However, in Session 1, Bob expects to receive $MAC_K(r_1, ID(Alice))$. Since $ID(Bob) \neq ID(Alice)$, the verification will fail, and the attack is thwarted.

Q5. (10 points) Bob's company mail server publishes a public key PKB so that all incoming emails to Bob are encrypted under PKB. When Bob goes on vacation, he instructs the company's mail server to forward all his incoming emails to his colleague Alice. Alice's public key is PKA. The mail server needs a way to translate an email encrypted under public key PKB into an email encrypted under the public key PKA. This would be easy, if the mail server has the private key SKB, but then the mail server could read all of Bob's incoming emails, which is undesirable.
Let G be a group of a prime order q with a generator $g\in G$. Consider a minor variation of the ElGamal encryption scheme in our lecture notes, where encryption using a public key PK as $u=g^{\alpha}\in G$ works as follows:
$E(PK,m)=\{\beta\leftarrow Zq,v=g^{\beta}$, $k=H(u^{\beta})$, $c=E_{sym}(k,m)$, output (v, c)}.
Here, $E_{sym}$ is the encryption algorithm of a symmetric cipher with key space $K_{sym,}$ H is a hash function H: $G\rightarrow K_{sym}$, m is the message to be encrypted, and ẞ is a random value chosen from Zq.
Suppose that PKB and PKA are the public keys with corresponding private keys $SK_{B}=\alpha$ $\in Zq$ and $SK_{A}=\alpha^{\prime}\in Zq$ To enable private translation of ciphertexts from $PK_B$ to $PK_A$ Alice and Bob get together to compute $\tau=\alpha/\alpha^{\prime}\in Zq$. They give to the mail server.
a) Explain how Bob can decrypt his emails with his private key $SK_{B}=\alpha$.
> To decrypt the message $m$, Bob needs to derive the symmetric key $k$.
> Bob uses his private key $\alpha$ and the value $v$ from the ciphertext. The value $u^\beta$ (which was used to generate $k$) can be computed as:  $u^\beta = (g^\alpha)^\beta = g^{\alpha\beta}$
> Bob, knowing $\alpha$ and receiving $v = g^\beta$, can compute this same value by raising $v$ to the power of his private key: $v^\alpha = (g^\beta)^\alpha = g^{\beta\alpha} = g^{\alpha\beta}$
>  Bob computes the symmetric key $k$. Once Bob has computed $g^{\alpha\beta}$, he applies the hash function $H$: $k=H(v^\alpha)$
>  Bob uses the symmetric key $k$ and the symmetric decryption algorithm $D_{sym}$ (the inverse of $E_{sym}$) to recover the message: $m = D_{sym}(k, c)$

b) Explain how the mail server uses $\tau$ to translate a ciphertext $c=E(PK_{B},m)$ to a ciphertext c' for $PK_A$ for the same message m. Justify your answer.
> $v'=v^\tau$ the new $c'=(v',c)$
>  Let's verify that Alice can decrypt this new ciphertext $(v', c)$.
   1. The Translation Key: We are given $\tau = \alpha / \alpha'$ (computed in
>      $\mathbb{Z}_q$, so $\tau = \alpha \cdot (\alpha')^{-1} \pmod q$).
   2. Server's Computation: $$ v' = v^\tau = (g^\beta)^{\alpha/\alpha'} = g^{\beta \cdot (\alpha/\alpha')} $$3. Alice's Decryption:
 >     Alice receives $(v', c)$. To decrypt, she computes $k' = H((v')^{SK_A}) =  H((v')^{\alpha'})$.       Substituting the value of $v'$:     $$ (v')^{\alpha'} = (g^{\beta \cdot \frac{\alpha}{\alpha'}})^{\alpha'} $$      $$ (v')^{\alpha'} = g^{\beta \cdot \frac{\alpha}{\alpha'} \cdot \alpha'} $$     $$ (v')^{\alpha'} = g^{\beta \cdot \alpha} = g^{\alpha\beta} $$   3. Result:      $$ k' = H(g^{\alpha\beta}) $$ This is exactly the same key $k = H(u^\beta) = H((g^\alpha)^\beta) =  H(g^{\alpha\beta})$ used to encrypt the original message $c$. Therefore, Alice can successfully derive $k$ and decrypt $c$ to recover $m$

c) Show that $\tau$ can also be used to translate in the other direction. That is, if $c=E(PK_{A},$ m) then the mail server can construct a ciphertext c' for $PK_B$ for the same message m. Note that this is an unintended consequence that Alice did not want. It is not difficult to modify the scheme to prevent this unintended feature, but we will not do that here.
> Using the same logic as above to translate to a new $c'$
> $v'=v^{\tau^{-1}}=(g^{\beta})^{\alpha'/\alpha}$
> For Bob to decrypt he computes $k' = H((v')^{SK_B}) =  H((v')^{\alpha})$
> Substituting the value of $v'$:     $(v')^{\alpha} = (g^{\beta \cdot \frac{\alpha'}{\alpha}})^{\alpha}= g^{\beta \cdot \alpha}$
> 
> Result:      $k' = H(g^{\alpha\beta})$

d) When Bob comes back from vacation, what should he do to make sure that Alice can no longer read his emails?
> Bob must generate a new key pair $(PK_{B_{new}}, SK_{B_{new}})$ and publish the new
  public key.

---

### **Exam 2023**
Q1 (10 points). Hash functions.
Let $X=\{0,1\}^{x}$ and $Y=\{0,1\}^{y}$ where x is larger than y.
a) Explain what it means for a hash function H: $X\rightarrow Y$ to be collision resistant.
> A hash function is collision resistant if it is computationally infeasible to find any two values $X_1$ and $X_2$ where $X_1\not= X_2$ and $H(X_1)=H(X_2)$ 

b) Explain what it means for a hash function H: $X\rightarrow Y$ to be second preimage resistant.
> A hash function is second preimage resistant if it is computationally infeasible to find a value $X_2$ given a value $X_1$ where $X_1\not= X_2$ and $H(X_1)=H(X_2)$ 

b) Suppose H: $X\rightarrow Y$ is collision resistant, is H also second preimage resistant? If so, explain why. If not, give an example of a collision resistant function that is not second preimage resistant.
> If a hash function is collision resistant it must also be second preimage resistant. This is because if an attacker could find a second preimage for a given X that means they found a collision. 

d) Suppose H: $X\rightarrow Y$ is second preimage resistant, is H also collision resistant? If so, explain why. If not, give an example of a second preimage resistant function that is not collision resistant. 
> If a hash function is second preimage resistant that does not imply that it is also collision resistant. It is generally easier to find any two messages that collide then to find a message that collides with a specific message.
> An example would be $H(X)=\begin{cases}1010 \text{ if x is a bitstring of length n}\\ 0||X \text{ otherwise}\end{cases}$ it would be easy to find a collision for any two messages of length n. But given a X that is not length n it would be impossible to find any other message that would result in the same hash. (This hash is also not preimage resistant)

Q3 (12 points). Authentication
a) What is mutual authentication?
> Mutual authentication means both parties prove their identities to each other simultaneously or sequentially. The goal is for both parties to be sure of the others identity. This is often done using challenge-response or digital signatures in a public key setting.

b) What are the steps of challenge-response authentication?
> 1. Alice sends a message to Bob saying that she is Alice
> 2. Bob generates a unique random challenge `r` and sends it to Alice
> 3. Alice uses her secret key and potentially her unique ID to compute the response `y` for the challenge and sends `y` back to Bob
> 4. Bob computes what the response should be `y'`, using `r` and his own knowledge of a key or a related public key and if `y=y'` Bob accepts Alices identity

c) Discuss whether the mutual authentication Protocol 1 is secure. If it is secure, give the security analysis; otherwise, present the attack and improve it to be secure. (Certificates are omitted from its description, but they are assumed to be included in the scheme in the usual way. $y=sig_{Alice}(x)$ is Alice's signature of x, $ver_{Alice}(x,y)$ is the verification of y on x using Alice's public key. $y=sig_{Bob}(x)$ is Bob's signature of x, $ver_{Bob}(x,y)$ is the verification of y on x using Bob's public key.
Protocol 1: UNKNOWN PROTOCOL.
1. Bob chooses a random challenge, $r_{1}$, and he sends it to Alice.
2. Alice chooses a random challenge, $r_{2}$, she computes $y_{1}=sig_{Alice}(r_{1})$, and she sends $r_{2}$ and $y_{1}$ to Bob.
3. Bob checks that $ver_{Alice}(r_{1},y_{1})=$ true; if so, then Bob "accepts"; other- wise, Bob "rejects." Bob also computes $y_{2}=sig_{Bob}(r_{2})$ and he sends $y_{2}$ to Alice.
4. Alice checks that $ver_{Bob}(r_{2},y_{2})=$ true. If so, then Alice "accepts"; other- wise, Alice "rejects." 50
> This protocol is not secure because it is vulnerable to Man-in-the-Middle attacks. Eve can position herself between Alice and Bob to intercept messages to present herself as Alice or Bob. Bob wants to talk to Alice and sends a random challenge but unknowingly initiates the protocol with Eve. Eve starts another session with Alice sending Bobs challenge. Alice, thinking she is talking to Bob responds to the challenge using her key and sends her own random challenge to Eve. Eve forwards Alice's response to Bob where Bob confirms the response to his challenge matches and computes his own response to Alices challenge and sends it back to Eve. Now Bob has incorrectly authenticated Eve as Alice. 
> To improve this protocol, users ID should be attached to the challenge. Now if Bob initiates a protocol with Eve thinking she is Alice and Eves forwards the challenge to Alice. Alice will compute the response using Eve's ID. So when Eve forwards Alices response to Bob and Bob checks the response to his challenge he will see that $sig_{Bob}(r_{1},ID_{Bob})\not=sig_{Alice}(r_1,ID_{Eve})$

Q4 (12 points). RSA Cryptosystem.
a) Suppose Alice's RSA modulus is $n=55=5\times11$, that is, $p=5$ and $q=11$ and her public key component is $e=3$
i) Find Alice's private key d.
> $\phi(n) = (p-1)(q-1)=(5-1)(q-1)=40$
> $ed\equiv1\pmod{\phi(n)}\equiv3d\equiv1\mod40$
> $3\cdot27=81\equiv1\mod40$
> $d=27$

ii) Given a message $m=101$ and the hash function H: $y=x$ mod 23, find Alice's digital signature of m.
> $y=101\mod23\equiv9\mod23$
> $\sigma=y^d\mod23=9^{27}\mod23$
> $9^2=81\equiv12$
> $9^4\equiv12^2=144\equiv6$
> $9^8\equiv6^2=36\equiv13$
> $9^{16}\equiv13^2=169\equiv8$
> $9^{27}=9^{16}\cdot9^8\cdot9^2\cdot9\equiv8\cdot13\cdot12\cdot9=11232\equiv8$
> $\sigma=8$

b) If the RSA signing algorithm is changed to be $\sigma=m^{d}$ mod n, is the variant still secure? Why?
> No the variant is not secure because if an attacker has valid signatures $\sigma_1$ and $\sigma_2$ for messages $m_1$ and $m_2$, they can construct a valid signature for the message $m_{new} = m_1 \times m_2 \pmod n$ without knowing the private key $d$. $\sigma_{new} = \sigma_1 \times \sigma_2 \equiv m_1^d \times m_2^d \equiv (m_1 \times m_2)^d \pmod n$. They could also pick a random signature $\sigma$ first and then compute the corresponding message $m$ using the public key $e$: $m = \sigma^e \pmod n$

c) i) What is the underlying hard problem in the RSA cryptosystem?
> The integer factorization problem: Given a large composite number $n$, it is computationally infeasible to find its prime factors $p$ and $q$. If an adversary could factor $n$, they could then compute $\phi(n) = (p-1)(q-1)$ and subsequently derive the private key $d = e^{-1} \pmod{\phi(n)}$, thus breaking the RSA system. 

ii) Can you explain why the RSA cryptosystem is secure?
> The RSA cryptosystem is secure because an attacker would have to either solve the integer factorization problem or the RSA  problem.
> RSA Problem: The forward computation of a message x, a public exponent e and a modulus n is computationally easy $y = x^e \pmod n$. However is is hard to inverse the computation given the cipher text y, public exponent e and modulus n to find the original message $x = y^{1/e} \pmod n$.


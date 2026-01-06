In [[Network-Security]] (P,C,K,E,D) is a crypto system where ∣K∣=∣C∣=∣P∣

The system guarantees perfect secrecy iff:

1. Keys are chosen uniformly at random. (With equal probability 1/|K|)
2. The encryption functions are structured so that for any plaintext–ciphertext pair, there’s exactly one key that links them. (For every x ∈ P, y ∈ C, there is a unique key k such that ek(x)=y)

That’s essentially the mathematical characterization of the one-time pad.

---

### What this means

#### 1. Equal probability of keys

- If some keys are more likely than others, an attacker can use that bias to gain information about the plaintext.
- To achieve Shannon’s _perfect secrecy_, all keys must be equally likely: each key occurs with probability (1/|K|).
#### 2. For every plaintext–ciphertext pair ((x,y)), there is a unique key

- This condition means: For any given plaintext (x) and any possible ciphertext (y), there is exactly one key (k) that maps (x) to (y).
- Intuition: No ciphertext value is “unreachable” from some plaintext (otherwise seeing that ciphertext eliminates some possible plaintext).
- Also, the uniqueness ensures there’s no ambiguity: given (x) and (y), there isn’t more than one key that works.

This is essentially the **one-time pad property** generalized:
- With OTP, plaintext, ciphertext, and key spaces all have the same size.
- For every plaintext (x) and ciphertext (y), there exists a unique key (k = x \oplus y).
- And if the keys are chosen uniformly at random, the ciphertext reveals no information about the plaintext → perfect secrecy.
---
### Putting it all together
- Since (|P| = |C| = |K|), the system can be set up as a _Latin square_: each plaintext–key pair maps uniquely to a ciphertext, and each ciphertext–plaintext pair corresponds uniquely to a key.
- If keys are uniform, then every ciphertext is equally likely regardless of the plaintext. That’s exactly Shannon’s definition of _perfect secrecy_.
---
### 1. Definition of Perfect Secrecy (Shannon, 1949)

A cryptosystem provides **perfect secrecy** if observing the ciphertext gives **zero information** about the plaintext. Formally:

$$
P(X \mid Y) = P(X) \quad \forall x \in P, y \in C  
$$

where:
- (X) is the random variable for the plaintext.
- (Y) is the random variable for the ciphertext.

In words: knowing (Y) (the ciphertext) does not change the probability distribution of (X) (the plaintext).

---
### 2. Restating the conditions

We have a cryptosystem ((P,C,K,E,D)) with:

- (|P| = |C| = |K|).
- Keys are chosen uniformly at random.
- For each ((x,y)) pair, there exists a unique key (k) such that (e_k(x) = y).

---

### 3. Proof Sketch: Why these conditions ⇒ Perfect Secrecy

**Step 1. Compute (P(Y=y | X=x)).**  
Fix a plaintext (x \in P) and ciphertext (y \in C).

- There is **exactly one key** (k) such that (e_k(x)=y).
- Keys are chosen uniformly, so probability of picking that key is:  
$$
    P(Y=y \mid X=x) = \frac{1}{|K|}  
    $$
**Step 2. Compute (P(Y=y)).**  
Now, what’s the probability of ciphertext (y) overall?  
$$
P(Y=y) = \sum_{x \in P} P(Y=y \mid X=x) \cdot P(X=x)  
$$
Since for each (x), exactly one key leads to (y), and that happens with probability (1/|K|):  
$$
P(Y=y \mid X=x) = \frac{1}{|K|}  
$$
So:  
$$
P(Y=y) = \sum_{x \in P} \frac{1}{|K|} \cdot P(X=x) = \frac{1}{|K|} \sum_{x \in P} P(X=x) = \frac{1}{|K|}  
$$

**Step 3. Compute(P(X=x | Y=y))**
By [[Bayes Theorem]]  
$$
P(X=x \mid Y=y) = \frac{P(Y=y \mid X=x) \cdot P(X=x)}{P(Y=y)}  
$$
Plugging in:
$$
(P(Y=y \mid X=x) = \frac{1}{|K|})
$$ $$
(P(Y=y) = \frac{1}{|K|})
$$

So:  
$$
P(X=x \mid Y=y) = \frac{\frac{1}{|K|} \cdot P(X=x)}{\frac{1}{|K|}} = P(X=x)  
$$
---

### 4. Conclusion

We’ve shown:  
$$
P(X=x \mid Y=y) = P(X=x) \quad \forall x,y  
$$
which is the **formal definition of perfect secrecy**.

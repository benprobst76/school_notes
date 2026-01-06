Ben Probst -20284512 - ELEC 425
### Question 1 Calculate Joint Probabilities in HMM

$$
\begin{aligned}
p(x, z) = & p(z_1=\text{Load}) \cdot p(x_1=6|z_1=\text{Load}) \\
& \cdot p(z_2=\text{Fair}|z_1=\text{Load}) \cdot p(x_2=3|z_2=\text{Fair}) \\
& \cdot p(z_3=\text{Fair}|z_2=\text{Fair}) \cdot p(x_3=1|z_3=\text{Fair}) \\
& \cdot p(z_4=\text{Load}|z_3=\text{Fair}) \cdot p(x_4=2|z_4=\text{Load}) \\
& \cdot p(z_5=\text{Load}|z_4=\text{Load}) \cdot p(x_5=4|z_5=\text{Load})
\end{aligned}
$$
Substituting the probabilities from the model:
$$
\begin{aligned}
p(x, z) = & (1/2) \cdot (1/2) \\
& \cdot (0.4) \cdot (1/6) \\
& \cdot (0.6) \cdot (1/6) \\
& \cdot (0.4) \cdot (1/10) \\
& \cdot (0.6) \cdot (1/10) \\
&= 0.000004
\end{aligned}
$$

So, the probability of this scenario is **0.000004**.
### Question 2: Viterbi algorithm 
**The V Matrix**

|                | t = 1 (x=4)    | t = 2 (x=6)     | t = 3 (x=3)      |
| -------------- | -------------- | --------------- | ---------------- |
| k = 1 (Fair)   | $\frac{1}{12}$ | $\frac{1}{120}$ | $\frac{1}{900}$  |
| k = 2 (Loaded) | $\frac{1}{20}$ | $\frac{1}{60}$  | $\frac{1}{1000}$ |
| observation    | "4"            | "6"             | "3"              |

**The Ptr Matrix**

|                | t = 1 (x=4) | t = 2 (x=6) | t = 3 (x=3) |
| -------------- | ----------- | ----------- | ----------- |
| k = 1 (Fair)   | 0           | 1 (Fair)    | 2 (Loaded)  |
| k = 2 (Loaded) | 0           | 1 (Fair)    | 2 (Loaded)  |
| observation    | "4"         | "6"         | "3"         |
The probability is the maximum value in the last column of the V matrix.
$$
p(x, z^*) = \frac{1}{900}
$$

**The hidden state sequence `z*`:**
*   **t=3:** The maximum value is $V_{\text{Fair}}(3)$, so $z^*_3 = \text{Fair}$.
*   **t=2:** the Ptr matrix for (k=Fair, t=3). $Ptr_{\text{Fair}}(3) = \text{Loaded}$, so $z^*_2 = \text{Loaded}$.
*   **t=1:** the Ptr matrix for (k=Loaded, t=2). $Ptr_{\text{Loaded}}(2) = \text{Fair}$, so $z^*_1 = \text{Fair}$.
Therefore:
$$
z^* = (\text{Fair, Loaded, Fair})
$$
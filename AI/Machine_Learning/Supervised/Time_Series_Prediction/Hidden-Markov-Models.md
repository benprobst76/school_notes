In many situations, we observe a great number of sequences, but not the underlying "hidden states" that generate these sequences. Hidden Markov Models (HMMs) provide a statistical framework for modeling such systems, where the system being modeled is assumed to be a Markov process with unobserved (hidden) states.
## Hidden Markov Model: A First Example (DNA Sequences)
Consider the example of DNA sequence analysis:
*   **Hidden States**: These are the unobservable biological regions, such as `Exon`, `Intron`, and `5' SS` (splice site).
*   **Observed Sequence**: These are the actual DNA base pairs that we can measure: `A`, `C`, `G`, `T`.

We observe the DNA sequences (A, T, C, G) but do not directly observe the associated hidden states (exon, intron, splice site). An HMM allows us to infer these hidden states from the observable sequence.

![[Pasted image 20251128094243.png]]
### Model Parameters
HMMs are characterized by several probability distributions:
1.  **Start/Initial Probabilities ($\pi$)**: The probability of starting in a particular hidden state. For example:
    *   $$P(z_1 = \text{"Intron"}) = 1/3$$ $$P(z_1 = \text{"Exon"}) = 1/4$$And so on, for all possible initial hidden states. The sum of all initial probabilities must equal 1.

2.  **State Transition Probabilities ($A$)**: The probability of switching from one hidden state to another. For example, the probability of moving from an 'Exon' state to an 'Intron' state. Each row in the transition matrix (representing the starting state) sums to 1.

3.  **Emission Probabilities ($E$)**: The probability of observing a particular output symbol (e.g., a nucleotide A, T, C, G) given that the system is in a certain hidden state (e.g., exon, intron, splice site). Each row in the emission matrix (representing the hidden state) sums to 1.

![[Pasted image 20251128094331.png]]
_Illustration of transition and emission probabilities. Each row in both the transition and emission probability tables sums to 1, representing the complete probability distribution from a given state._
### Graphical Structure
We can represent sequential data using a Markov chain of latent (hidden) variables, with each observation conditioned on the state of its corresponding latent variable. This crucial graphical structure forms the foundation for both Hidden Markov Models and linear dynamical systems.
## The Dishonest Casino Dealer: An Illustrative Example
This classic example helps to understand the core problems HMMs solve.
A casino has two types of dice:
*   **Fair die**: Each face has an equal probability of being rolled.
    $$P(1) = P(2) = P(3) = P(4) = P(5) = P(6) = 1/6$$
*   **Loaded die**: The '6' face is heavily biased.
    $$P(1) = P(2) = P(3) = P(4) = P(5) = 1/10$$
    $$P(6) = 1/2$$

The casino dealer switches between the fair and loaded die with some probability at each turn.

**The Game:**
1.  You bet 10 dollars.
2.  You roll using a fair die.
3.  The dealer rolls with either the fair or the loaded die.
4.  Whoever rolls the highest number wins $20.

Using an HMM, we can analyze several problems related to this game:

### Question #1 - Decoding Problem

**Given:** A sequence of rolls by the casino dealer, e.g., `2245524462146146136136661664661636616366163616515615115146123562343`.

**Question:** Which rolls were generated with the fair die, and which with the loaded die? (i.e., infer the sequence of hidden states: Fair or Loaded).

This is the **Decoding problem** in HMMs, where we aim to find the most likely sequence of hidden states that produced a given observation sequence.

### Question #2 - Evaluation Problem

**Given:** A sequence of rolls by the casino dealer, e.g., `2245526462146146136136661664661636616366163616515615115146123562343`.

**Question:** How likely is this specific sequence of rolls, given our models of how the dealer works (i.e., given the transition, emission, and start probabilities)?

This is the **Evaluation problem** in HMMs, where we calculate the probability of an observed sequence given an HMM.

### Question #3 - Learning Problem

**Given:** A large number of sequences of rolls by the casino dealer, e.g.,
`2245526462146146136136661664661636616366163616515615115146123562343`
`6136136661664661622455264621461436616366163146123562343616515615115`
... (many such sequences)

**Question:**
*   How often does the casino dealer change from the fair die to the loaded die, and vice-versa? (i.e., determine the **transition probabilities**).
*   How "loaded" is the loaded die, and how "fair" is the fair die? (i.e., determine the **emission probabilities** for each die).
*   How likely is each die to be used first? (i.e., determine the **initial probabilities**).

This is the **Learning problem** in HMMs, where we aim to determine the model parameters (transition, emission, and start probabilities) from observed data.

## Formal Definition of Hidden Markov Models
An HMM is formally defined by the following components:

*   **Output Symbols ($B$)**: A finite set of possible observation symbols,
    $$ B = \{b_1, b_2, \ldots, b_M\} $$
    At each time step $t$, an observation $x_t \in B$ is emitted.
*   **Hidden States ($H$)**: A finite set of unobservable states,
    $$ H = \{1, 2, \ldots, K\} $$
    At each time step $t$, the system is in a hidden state $z_t \in H$.
*   **Start/Initial Probabilities ($\pi$)**: A vector of probabilities for each hidden state being the initial state.  $\pi = \{\pi_1, \pi_2, \ldots, \pi_K\}$ where
    $$ P(z_1 = k) \equiv \pi_k \quad \text{for} \quad k = 1, \ldots, K $$
    and
    $$ \sum_{k=1}^K \pi_k = 1 $$
*   **Transition Probabilities ($A$)**: A $K \times K$ matrix where each element $a_{ij}$ represents the probability of transitioning from hidden state $i$ to hidden state $j$
    $$ A = \{a_{ij}\} \quad \text{where} \quad i, j = 1, \ldots, K $$
    $$ a_{ij} = P(z_{t+1} = j | z_t = i) $$
    For each state $i$, the sum of transition probabilities to all possible next states is 1:
    $$ \sum_{j=1}^K a_{ij} = 1 $$
*   **Emission Probabilities ($E$)**: A $K \times M$ matrix where each element $e_{ij}$ represents the probability of observing symbol $b_j$ given that the system is in hidden state $i$
    $$ E = \{e_{ij}\} \quad \text{where} \quad i = 1, \ldots, K \quad \text{and} \quad j = 1, \ldots, M $$
    $$ e_{ij} = P(x_t = b_j | z_t = i) $$
    For each hidden state $i$, the sum of emission probabilities for all possible output symbols is 1:
    $$ \sum_{j=1}^M e_{ij} = 1 $$

Note that the set of output symbols $B$ is determined by the input sequences, and the number of hidden states $K$ is a hyperparameter chosen before the model is trained.
## The Three Main Problems of HMMs
Hidden Markov Models are powerful because they allow us to answer three fundamental questions about sequential data. These problems, and their efficient solutions, are critical to the wide application of HMMs in areas like speech recognition, bioinformatics, and natural language processing.
### 1. The Decoding Problem
**Informal Question (from The Dishonest Casino Example):** Given a sequence of observations (e.g., dealer's dice rolls), what is the most likely sequence of hidden states (e.g., Fair or Loaded die) that produced these observations?
**Formal Definition:**
Given an HMM specified by its parameters $\theta = (A, E, \pi)$, and an observed sequence $x = (x_1, \ldots, x_T)$, find the sequence of hidden states $z^* = (z_1, \ldots, z_T)$ that maximizes the conditional probability $P(z|x,\theta)$.$$
z^* = \operatorname{argmax}_z P(z|x,\theta)
$$Since $P(z|x,\theta) = \frac{P(x,z|\theta)}{P(x|\theta)}$, and $P(x|\theta)$ is constant for a given observation sequence, this is equivalent to finding:$$
z^* = \operatorname{argmax}_z P(x,z|\theta) $$
#### Naive Approach and its Limitations
A naive approach would be to compute $P(x,z|\theta)$ for every possible hidden state sequence $z$ and then choose the $z$ that yields the maximum probability. However, if there are $K$ hidden states and the sequence length is $T$, there are $K^T$ possible hidden state sequences. This exponential number makes the naive approach computationally intractable for all but the shortest sequences.
#### Solution: The Viterbi Algorithm
The Decoding Problem is efficiently solved using the **Viterbi Algorithm**, a dynamic programming algorithm. It finds the single best path through the hidden state space that explains the observed sequence.
The core idea is to compute, for each time step $t$ and each possible hidden state $k$, the maximum probability of arriving at state $k$ at time $t$ having produced the observations up to $t$.

Let $V_k(t)$ be the maximum probability of any path ending in state $k$ at time $t$:

$$
V_k(t) = \max_{z_1, \ldots, z_{t-1}} P(x_1, \ldots, x_t, z_1, \ldots, z_{t-1}, z_t = k | \theta)
$$

The Viterbi algorithm proceeds as follows:

**1. Initialization ($t=1$):** For each hidden state $k \in \{1, \ldots, K\}$:
$$
V_k(1) = \pi_k \cdot e_{k, x_1}
$$
where $\pi_k$ is the initial probability of state $k$, and $e_{k, x_1}$ is the emission probability of observing $x_1$ from state $k$. We also store `Ptrk(1) = 0` to backtrack the path.

**2. Recursion ($t=2, \ldots, T$):** For each time step $t$ and each hidden state $k' \in \{1, \ldots, K\}$:
$$
V_{k'}(t) = \left( \max_{k \in \{1, \ldots, K\}} (V_k(t-1) \cdot a_{k, k'}) \right) \cdot e_{k', x_t}
$$
where $a_{k, k'}$ is the transition probability from state $k$ to state $k'$, and $e_{k', x_t}$ is the emission probability of observing $x_t$ from state $k'$. We also store the predecessor state:
$$
\text{Ptr}_{k'}(t) = \operatorname{argmax}_{k \in \{1, \ldots, K\}} (V_k(t-1) \cdot a_{k, k'})
$$

**3. Termination:** The maximum probability of the entire observed sequence is:
$$
P(x, z^*|\theta) = \max_{k \in \{1, \ldots, K\}} V_k(T)
$$
The end state of the most likely path, $z_T^*$, is the state $k$ that yields this maximum.

**4. Path Backtracking:** Recover the optimal path $z^*$ by backtracking from $z_T^*$ using the `Ptr` pointers:
$$
z_{t-1}^* = \text{Ptr}_{z_t^*}(t) \quad \text{for } t = T, T-1, \ldots, 2
$$

#### Practical Consideration: Underflow Prevention

When multiplying many small probabilities, the values of $V_k(t)$ can become extremely small, leading to numerical underflow. The standard solution is to perform calculations in the log-domain. Instead of multiplying probabilities, we sum their logarithms:

$$
\log(V_{k'}(t)) = \log(e_{k', x_t}) + \max_{k \in \{1, \ldots, K\}} (\log(V_k(t-1)) + \log(a_{k, k'}))
$$
This transforms products into sums, mitigating underflow issues.

### 2. The Evaluation Problem

**Informal Question (from The Dishonest Casino Example):** Given an HMM and an observed sequence (e.g., a series of dice rolls), how likely is this specific sequence of observations?

**Formal Definition:**
Given an HMM specified by its parameters $\theta = (A, E, \pi)$, and an observed sequence $x = (x_1, \ldots, x_T)$, find the total probability of the observed sequence, $P(x|\theta)$.

$$
P(x|\theta) = \sum_z P(x, z|\theta)
$$

This sum is over *all possible* hidden state sequences $z = (z_1, \ldots, z_T)$ that could have generated $x$.

#### Naive Approach and its Limitations
Similar to the Decoding Problem, a naive summation over all $K^T$ possible hidden state sequences is computationally infeasible.
### Again, “Bugs on a Grid”  
1. put bugs in each state at t=1, holding values of initial probability times the emission probability.  
2. move each bug forward to time t+1 by making copies of each of  them to all K node at t+1 and the value of each copy is the bug’s  original value times the probability of the transition and emission.  
3. at each node of time t+1, replace all the bugs with a single bug carrying the sum of their values  
4. go to 2 until all bugs have reached time n  
5. sum up values on all bugs.  
This is also a case of dynamic programming!
#### Solution: The Forward Algorithm (and Backward Algorithm)
The Evaluation Problem is efficiently solved using the **Forward Algorithm** (or the Backward Algorithm), another dynamic programming technique. The Forward Algorithm computes the "forward probabilities" $\alpha_k(t)$, which is the probability of observing the partial sequence $x_1, \ldots, x_t$ and being in state $k$ at time $t$.

The final $P(x|\theta)$ is the sum of these forward probabilities at the last time step $T$:
$$
P(x|\theta) = \sum_{k=1}^K \alpha_k(T)
$$

Like the Viterbi algorithm, the Forward and Backward algorithms also utilize log-probabilities to avoid underflow.

### 3. The Learning Problem
**Informal Question (from The Dishonest Casino Example):** Given a large set of observed sequences (e.g., many series of dice rolls from the dealer), how can we determine the HMM parameters (initial, transition, and emission probabilities) that best explain these observations?

**Formal Definition:**
Given a set of observed sequences $X = \{x^{(1)}, \ldots, x^{(N)}\}$, find the model parameters $\theta^* = (A, E, \pi)$ that maximize the likelihood of the observed data.

$$
\theta^* = \operatorname{argmax}_\theta P(X|\theta)
$$

#### Solution: The Expectation-Maximization (EM) Algorithm

The Learning Problem is typically solved using an iterative optimization approach called the **Expectation-Maximization (EM) algorithm**. For HMMs, this is specifically known as the **Baum-Welch algorithm**.

The Baum-Welch algorithm iteratively refines the HMM parameters (initial state probabilities $\pi$, state transition probabilities $A$, and emission probabilities $E$) to increase the likelihood of the observed training data until convergence. It does this by:
*   **E-step (Expectation):** Calculate the expected counts of transitions and emissions based on the current model parameters. This step uses the Forward and Backward algorithms.
*   **M-step (Maximization):** Re-estimate the model parameters using these expected counts to maximize the likelihood of the data.

The algorithm converges to a local maximum of the likelihood function.
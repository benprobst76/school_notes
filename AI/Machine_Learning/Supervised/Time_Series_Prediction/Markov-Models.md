A Markov Model, often referred to as a Markov Chain, is a stochastic model that describes a sequence of events in which the probability of each event depends only on the state of the system at the previous event. This is known as the **Markov Property**.
## The Markov Property (Memorylessness)
The core assumption of a Markov Model is that the future is independent of the past, given the present. For a sequence of random variables $x_1, x_2, ..., x_n$, this means the probability of the next state $x_t$ depends only on the current state $x_{t-1}$.
*   **First-Order Markov Model:** The most common type.
    $P(x_t | x_{t-1}, x_{t-2}, ..., x_1) = P(x_t | x_{t-1})$
    ![[Pasted image 20251022135910.png]]
*   **Second-Order Markov Model:** The next state depends on the two previous states.
    $P(x_t | x_{t-1}, x_{t-2}, ..., x_1) = P(x_t | x_{t-1}, x_{t-2})$
    ![[Pasted image 20251022140618.png]]
Higher-order models are possible but are often impractical as the number of state dependencies (and thus parameters to learn) grows exponentially.
## Components of a Markov Model
A Markov Model is formally defined by:
1.  **States (S):** A finite set of N possible states, $S = \{s_1, s_2, ..., s_N\}$.
2.  **Initial Probabilities (π):** A vector of probabilities for starting in each state. $\pi_i = P(x_1 = s_i)$.
3.  **Transition Probabilities (A):** An $N \times N$ matrix where $A_{ij} = P(x_t = s_j | x_{t-1} = s_i)$, representing the probability of moving from state $s_i$ to state $s_j$.
### Example: Weather
Consider a simple weather model with three states: {Sunny, Cloudy, Rainy}.
![[Pasted image 20251022140312.png]]
The transition probabilities could be represented by a matrix/table shown above.
## Core Tasks and Algorithms
### 1. Evaluation: Probability of a Sequence
Given a model (π and A) and a sequence of observed states $X = (x_1, x_2, ..., x_T)$, what is the probability of this sequence occurring?
This is calculated by chaining the probabilities together:
$P(X) = P(x_1) \cdot P(x_2|x_1) \cdot P(x_3|x_2) \cdot ... \cdot P(x_T|x_{T-1})$
$P(X) = \pi_{x_1} \cdot A_{x_1, x_2} \cdot A_{x_2, x_3} \cdot ... \cdot A_{x_{T-1}, x_T}$
### 2. Generation (Sampling)
We can use a Markov model to generate a new sequence of states:
1.  Start in a state $x_1$ chosen according to the initial probabilities $\pi$.
2.  From the current state $x_t$, choose the next state $x_{t+1}$ according to the transition probabilities in the corresponding row of matrix A.
3.  Repeat step 2 until the desired sequence length is reached.
### 3. Learning
Given a set of observed sequences, the goal is to estimate the model parameters (π and A). Using Maximum Likelihood Estimation (MLE), this is a matter of counting occurrences in the training data.
*   **Initial Probability:** $\pi_i = \frac{\text{Number of sequences starting with state } i}{\text{Total number of sequences}}$
*   **Transition Probability:** $A_{ij} = \frac{\text{Number of transitions from state } i \text{ to } j}{\text{Total number of transitions from state } i}$
**Problem: Unseen Events (Smoothing)**
If a particular transition (e.g., from "dance" to "robust") never occurs in the training data, its probability will be 0. This is often unrealistic. **Smoothing** (or regularization) techniques, like Laplace (add-one) smoothing, are used to assign a small non-zero probability to unseen events.
## Applications
*   **Language Modeling (N-grams):** Predicting the next word or character in a sequence. A first-order model is a bigram model, and a second-order model is a trigram model. Used in predictive text, speech recognition, and machine translation.
*   **Bioinformatics:** Modeling sequences of DNA or amino acids.
*   **Web Usage Analysis:** Modeling the path a user takes through a website, where each page is a state.

## Limitations and Next Steps
The main limitation of a standard Markov Model is the assumption that the state is **directly observable**. We know for certain whether it is "Sunny" or "Cloudy".

What if the state is hidden or latent, and we can only see indirect observations? For example, we don't know the weather (hidden state), but we can see if someone is carrying an umbrella (observation). This is the problem that [[Hidden-Markov-Models]] are designed to solve.
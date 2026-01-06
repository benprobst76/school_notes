## Modelling Sequences: Motivations
In many machine learning tasks, the goal is to transform an input sequence into an output sequence or to predict the next element in a sequence. This is essential for applications involving temporal data or language.
### Use Cases
1.  **Sequence-to-Sequence Transformation:**
    *   **Machine Translation:** Translating a French sentence (Input Sequence: A B C) to an English sentence (Output Sequence: W X Y Z).
    *   **Image-to-Text:** Predicting a sequence of words to describe an image, conditioning on both the image features and the previously generated words.

2.  **Next-Term Prediction (Self-Supervised Learning):**
    *   The model is trained to predict the next term in an input sequence.
    *   **Example:** "Shared joy is a double joy; shared sorrow is __ sorrow" (Predict "half").
    *   This approach blurs the line between supervised and unsupervised learning. It uses supervised methods (calculating error against the actual next term) but requires no separate, manually labeled training signal. This paradigm has led to dramatic improvements in Natural Language Processing (NLP).
## Simple Sequence Models
### Memoryless Models
These models process inputs without maintaining a memory of the long-term history.
*   **Markov Models:** As discussed in [[Markov-Models]], standard Markov models assume the future depends only on the current state (or a short fixed window), ignoring the long history.
*   **Feed-Forward Neural Networks:** Simple [[Feed-Forward]] networks can be designed to predict the next term based on a fixed-size window of previous terms. While this generalizes Markov models by adding non-linear hidden layers, it still lacks a mechanism to store information about the distant past.
### Beyond Memoryless Models: Hidden States
To model long-term dependencies, we need systems that can maintain an internal state.
*   **Hidden Markov Models (HMMs):** These introduce hidden states, allowing the model to infer a probability distribution over sequences. However, they have fundamental limitations in capacity.
#### Limitations of HMMs
HMMs rely on a discrete $1$-of-$K$ hidden state. To store "history" information, the model must select one specific state.
*   **The Information Bottleneck:** Consider a spoken sentence where the first half contains syntax, semantics, accent, and tone information required to predict the second half. If this context amounts to 100 bits of information, an HMM would require $2^{100}$ states to distinguish every possible history configuration.
*   Generally, with $K$ hidden states, an HMM can only track $\log_2(K)$ bits of history information. This makes them inefficient for complex, high-dimensional context.
## Recurrent Neural Networks (RNNs)
Recurrent Neural Networks (RNNs) are designed specifically to overcome memory limitations. Unlike feed-forward networks, they possess an internal memory that persists over time.
*   **Architecture:** At each time step $t$, the RNN uses a layer of hidden units ($h_t$) to remember history information
*   **Shared Weights:** The weights ($W$, $U$, $V$) are **shared** across all time steps. This means the same function is applied recurrently to each input in the sequence.
![[Pasted image 20251130075206.png]]
*Figure 1: A basic RNN cell. Note that the weights are constant across time.*
### Mathematical Formulation
The output at time $t$ is often computed using a softmax function over the output units $o(t)$:
$$ 
 y_i(t) = \text{softmax}(o(t))_i = \frac{e^{o_i(t)}}{\sum_{j=1}^m e^{o_j(t)}} 
$$
Where:
*   $\mathbf{o}(t) = \{o_1(t), \dots, o_m(t)\}$ represents the raw logits for $m$ units.
*   The hidden layer usually employs a non-linear activation function like $\tanh$ or ReLU.
### Visualizing RNNs: Folded vs. Unfolded
RNNs can be visualized in two ways:
1.  **Folded (Recurrent):** Shows the loop where the hidden state feeds back into itself.
2.  **Unfolded (Time-expanded):** Shows the network unrolled over time steps, looking like a very deep feed-forward network where each layer corresponds to a time step.
![[Pasted image 20251130075300.png]]
*Figure 2: Folded representation (left) vs. Unfolded representation (right).*
## Training RNNs
### Backward Propagation Through Time (BPTT)
Training RNNs is similar to training feed-forward networks, but with a constraint: the weights $W$ must remain identical at every time step.
1.  **Compute Gradients:** Calculate the gradient of the error $E$ with respect to the weights at each time step separately (treating them as distinct parameters in the unfolded graph).
2.  **Aggregate:** Sum the gradients across all time steps to update the shared weights.
$$ 
 \Delta W = \sum_{t} \frac{\partial E}{\partial W(t)} 
$$
If the weights start satisfying the constraint (being equal), this update rule ensures they continue to do so.
### Difficulties in Training
Despite being theoretically more powerful than HMMs, RNNs were historically difficult to use due to:
1.  **Computational Cost:** Training on long sequences is slow.
2.  **Vanishing/Exploding Gradients:** This is the primary algorithmic challenge when network depth (sequence length) increases.
### The Vanishing/Exploding Gradient Problem
When backpropagating errors through many time steps, the gradient signal passes through repeated matrix multiplications and non-linear derivative computations.
Consider the chain rule for a simple weight update at a deep layer (or early time step):
$$ 
 \frac{\partial E}{\partial h_i} = \sum_{j} \frac{\partial E}{\partial \alpha_j} \frac{d \alpha_j}{d h_i} 
$$
If we propagate this back through $T$ time steps, we essentially multiply by the weight matrix $W$ and the derivative of the activation function $T$ times.
*   **Vanishing Gradient:** If weights/derivatives are small ($< 1$), the gradient decays exponentially to zero. The model stops learning from early inputs (long-term memory failure).
*   **Exploding Gradient:** If weights are large ($> 1$), the gradient grows exponentially, causing instability and NaN values.
Because RNNs are often trained on sequences of length 100+, this effect is severe, making it hard for standard RNNs to learn dependencies that span long time intervals.
## Long Short-Term Memory (LSTM)
To address the vanishing gradient problem, Hochreiter & Schmidhuber (1997) introduced the LSTM. It is a specific RNN architecture designed to preserve error signals over long durations.
### Key Concept: Gating
LSTM replaces the simple hidden node with a memory cell protected by **gates**. These gates regulate the flow of information, allowing the network to decide what to keep, what to update, and what to forget.
*   **Analogous to Logic:** A gate can be thought of as a multiplier. If the gate value is $0$ (closed), no information passes. If $1$ (open), information passes freely. In LSTMs, these are "soft" gates (sigmoid activation) with values between $0$ and $1$.
![[Pasted image 20251130082144.png]]
*Figure 3: High-level visualization of information flow control in LSTMs.*
### LSTM Cell Architecture
At each time step $t$, an LSTM cell maintains:
*   **Cell State ($c_t$):** The internal memory.
*   **Hidden State ($h_t$):** The output.
*   **Gates:** 
    *   **Input Gate ($i_t$):** Controls how much new information flows into the memory cell.
    *   **Forget Gate ($f_t$):** Controls how much of the previous memory cell content is retained.
    *   **Output Gate ($o_t$):** Controls how much of the internal memory is exposed as the output hidden state.
![[Pasted image 20251130082359.png]]
*Figure 4: Detailed schematic of an LSTM block.*
### Impact
Although LSTMs were proposed in 1997, they became the dominant approach for sequence learning between 2009 and 2014, achieving state-of-the-art results in:
*   Speech Recognition
*   Handwriting Recognition
*   Machine Translation
While newer architectures like the **Transformer** (specifically [[Attention-Models]]) have since surpassed RNNs in many NLP tasks, LSTMs remain a fundamental tool for sequential data analysis and are widely implemented in frameworks like TensorFlow and PyTorch.

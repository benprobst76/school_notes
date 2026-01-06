## What is Attention?
In human perception, we selectively focus on certain parts of our sensory input. For instance, when looking at a scene, our brain pays more attention to specific features or regions of interest to recognize objects. Similarly, attention mechanisms in neural networks allow a model to focus on specific parts of the input when performing a task.
Attention can be interpreted as a set of importance weights assigned to the input elements (e.g., pixels in an image or words in a sentence). These weights are learned during training and help the model determine how much each part of the input contributes to the output. For example, a self-driving car's vision system might use attention to focus more on pedestrians and traffic lights than on buildings or the sky.
### Example: Machine Translation
When translating a sentence from one language to another, an attention mechanism allows the decoder to "look back" at the source sentence and focus on the most relevant words at each step of the translation. For instance, when translating "Le chat est sur le tapis" (French) to "The cat is on the mat" (English), the model would pay attention to different parts of the French sentence as it generates each English word.
![[Pasted image 20251125110549.png]]
## Details of Attention
The core idea behind attention is to compute a context vector that captures the relevant information from the encoder's hidden states. This is typically done in three steps:
1.  **Scoring:** An alignment score is computed for each input, measuring how well it matches the current output. $$e_{ij}=f(s_i-1,h_j) $$2.  **Normalization:** The scores are normalized into a probability distribution (weights) using a softmax function. $$\alpha_{ij}=\frac{exp}{\sum} $$2.  **Context Vector:** The context vector is a weighted sum of the inputs, where the weights are the normalized scores.
![[Pasted image 20251125110651.png]]
There are different types of attention:
-   **Inter-attention (or Encoder-Decoder Attention):** Relates information between the encoder and the decoder. This is common in sequence-to-sequence models for tasks like machine translation or image captioning.
-   **Self-attention (or Intra-attention):** Relates different positions of the same sequence to compute a representation of the sequence. It allows the model to weigh the importance of different words in the same sentence.
![[Pasted image 20251125110720.png]]
## Key, Query, and Value (KQV)
A powerful and widely used implementation of attention is based on the concepts of Query, Key, and Value. This framework is analogous to a retrieval system. When you search for something (a query), the system looks at a set of keys to find the most relevant ones and then returns the corresponding values.
In the context of attention:
-   **Query (Q):** Represents the current element or context that is "asking" for information.
-   **Key (K):** Represents the elements in the source from which information is to be retrieved.
-   **Value (V):** Represents the information content of the source elements.
The attention score is calculated based on the similarity between the Query and the Key. This score is then used to create a weighted sum of the Values.
![[Pasted image 20251125110828.png]]
## Transformer and Scaled Dot-Product Self-Attention
The Transformer, a groundbreaking architecture introduced by Vaswani et al. in "Attention Is All You Need" (NeurIPS 2017), relies almost entirely on attention mechanisms, replacing traditional recurrent or convolutional layers. Its core component is the Scaled Dot-Product Self-Attention.
The formula for scaled dot-product attention is:
$$
\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V
$$
Where:
-   $Q$, $K$, and $V$ are matrices containing the queries, keys, and values.
-   $d_k$ is the dimension of the keys. The scaling factor $\frac{1}{\sqrt{d_k}}$ is used to prevent the dot products from growing too large, which could lead to vanishing gradients in the softmax function.
![[Pasted image 20251125110950.png]]
### Multi-Head Attention
Instead of performing a single attention function, the Transformer uses "Multi-Head Attention". This involves projecting the queries, keys, and values into different learned linear projections multiple times. Attention is then applied in parallel to each of these projected versions. The outputs are concatenated and once again projected, resulting in the final values. This allows the model to jointly attend to information from different representation subspaces at different positions.
![[Pasted image 20251125111035.png]]
The Transformer is the foundation for many state-of-the-art models, including Generative Pre-trained Transformer (GPT), the "T" in ChatGPT.
## How does ChatGPT work?
Models like ChatGPT are based on the Transformer architecture. They are "pre-trained" on a massive amount of text data. A common pre-training objective is a form of language modeling, such as predicting a masked or upcoming word in a sentence. This process forces the model to learn grammar, facts, and reasoning abilities.
After pre-training, the model is "fine-tuned" on a smaller, task-specific dataset. For ChatGPT, this involves instruction tuning and reinforcement learning from human feedback (RLHF) to make it a better conversational agent.
The power of these models lies in their ability to generalize. The same fundamental architecture can be applied to various data types, not just text. By changing the input data, these models can learn to write computer programs, analyze sensor data, or even generate images.
![[Pasted image 20251125111157.png]]

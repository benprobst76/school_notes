Feed-forward neural networks are the most basic type of artificial neural networks. They are characterized by a unidirectional flow of information from the input layer through one or more hidden layers to the output layer.
* **Fully Connected:** Neurons between two adjacent layers are fully connected, meaning every neuron in one layer is connected to every neuron in the next layer.
* **Layered Structure:** The first layer serves as the input layer, and the final layer is the output layer. Any layers in between are known as hidden layers.
* **Deep Networks:** If a network contains more than one hidden layer, it is often referred to as a "deep" neural network.
* **Mapping Function:** These networks essentially compute a mapping from the input data to the output predictions.
* **Non-linear Activation:** Typically, the activities of the neurons in each layer are a non-linear function of the activities in the layer below, which is crucial for learning complex patterns.

![[Pasted image 20251104110757.png]]
## Network Architecture with One Hidden Layer
Consider a simple feed-forward network with one hidden layer.
![[Pasted image 20251105134409.png]]

The computations for the hidden layer output ($h$) and the final output ($y$) are as follows:

The hidden layer activation $h$ is computed from the input $x$:
$$
h = f_1(W_1^T x + c)
$$
And the output $y$ is computed from the hidden layer activation $h$:
$$
y = f_2(W_2^T h + b)
$$
Where:
*   $f_1(.)$ and $f_2(.)$ are activation functions (potentially different).
*   $W_1$ and $W_2$ are weight matrices for the first and second layers, respectively.
*   $c$ and $b$ are bias vectors for the hidden and output layers, respectively. Biases can often be absorbed into the weight matrices by appending a constant '1' to the input vector.

Suppose $f_1(.)$ is the [[Neurons#Rectified Linear Units (ReLU) Neurons|Rectified Linear Unit (ReLU)]] activation function, and $f_2(.)$ is a linear activation function (i.e., $f_2(z) = z$). Then the full expression for $y$ becomes:
$$
\begin{aligned}
y &= f_2(W_2^T h + b) \\&= f_2(W_2^T f_1(W_1^T x + c) + b) \\&= W_2^T \max(0, W_1^T x + c) + b
\end{aligned}
$$
## Solving the XOR Problem with a Neural Network
The XOR (exclusive OR) problem is a classic example in machine learning because it is not [[Linear-Classifier|linearly separable]]. This means a single linear classifier cannot correctly classify all four possible input combinations. While kernel methods can map non-linearly separable data into a higher-dimensional space where it becomes linearly separable, neural networks can learn such mappings automatically through their hidden layers.

Consider a feed-forward neural network for the XOR problem. The lower layer (hidden layer) uses a ReLU activation:
$$
h = \max(0, W_1^T x + c)
$$
Suppose we have already trained the model and obtained the following weights and biases for the first layer:
$$
W_1 = \begin{pmatrix}
1 & 1 \\ 1 & 1
\end{pmatrix}
\quad c = \begin{pmatrix}
0 \\ -1
\end{pmatrix}
$$
Let's examine how the four possible input points for XOR are mapped by this hidden layer:
Given the four input points:
$$
\begin{aligned}
x_a &= (0,0)^T \\x_b &= (0,1)^T \\x_c &= (1,0)^T \\x_d &= (1,1)^T
\end{aligned}
$$
The hidden layer maps them to:
$$
\begin{aligned}
h_a &= \max\left(0, \begin{pmatrix} 1 & 1 \\ 1 & 1 \end{pmatrix} \begin{pmatrix} 0 \\ 0 \end{pmatrix} + \begin{pmatrix} 0 \\ -1 \end{pmatrix}\right) = \max\left(0, \begin{pmatrix} 0 \\ -1 \end{pmatrix}\right) = \begin{pmatrix} 0 \\ 0 \end{pmatrix} \\h_b &= \max\left(0, \begin{pmatrix} 1 & 1 \\ 1 & 1 \end{pmatrix} \begin{pmatrix} 0 \\ 1 \end{pmatrix} + \begin{pmatrix} 0 \\ -1 \end{pmatrix}\right) = \max\left(0, \begin{pmatrix} 1 \\ 0 \end{pmatrix}\right) = \begin{pmatrix} 1 \\ 0 \end{pmatrix} \\h_c &= \max\left(0, \begin{pmatrix} 1 & 1 \\ 1 & 1 \end{pmatrix} \begin{pmatrix} 1 \\ 0 \end{pmatrix} + \begin{pmatrix} 0 \\ -1 \end{pmatrix}\right) = \max\left(0, \begin{pmatrix} 1 \\ 0 \end{pmatrix}\right) = \begin{pmatrix} 1 \\ 0 \end{pmatrix} \\h_d &= \max\left(0, \begin{pmatrix} 1 & 1 \\ 1 & 1 \end{pmatrix} \begin{pmatrix} 1 \\ 1 \end{pmatrix} + \begin{pmatrix} 0 \\ -1 \end{pmatrix}\right) = \max\left(0, \begin{pmatrix} 2 \\ 1 \end{pmatrix}\right) = \begin{pmatrix} 2 \\ 1 \end{pmatrix}
\end{aligned}
$$

![[Pasted image 20251105140158.png]]

As shown in the figure above, the lower layer neural network successfully maps the data that are not linearly separable in the original input space (left figure) to a new feature space (right figure) where they become linearly separable. Once linearly separable, a simple linear classifier in the upper layer can effectively classify the data.
## Why Deep Networks?
A common question arises: if a single hidden layer is theoretically sufficient to approximate any function (as per the Universal Approximator Theorem), why do we use deep networks with many hidden layers?
### Universal Approximator Theorem
The **Universal Approximator Theorem** states that a feed-forward network with a single hidden layer containing a finite number of neurons can approximate any continuous function on compact subsets of $\mathbb{R}^n$, given appropriate activation functions. This means that, in theory, a "shallow" network can learn any mapping.

However, "approximating any function" does not mean it can do so *efficiently* or *effectively* in practice. The number of neurons required in a single hidden layer to approximate a complex function to a desired accuracy can be astronomically large, making such a network impractical to train and generalize well.
### Benefits of Deep Architectures
Deep neural networks (those with multiple hidden layers) offer several practical advantages over shallow ones:
1.  **Hierarchical Feature Learning:** Deep networks can learn hierarchical representations of data. Early layers might learn simple features (e.g., edges, textures in images), while subsequent layers combine these simpler features into more complex and abstract representations (e.g., object parts, entire objects). This hierarchical learning is more efficient and often leads to better performance.
2.  **Increased Representational Power:** While a shallow network *can* approximate any function, a deep network can often represent the same function with significantly fewer parameters. This is because deeper architectures can build more intricate and abstract mappings.
3.  **Improved Generalization:** Deep models often generalize better to unseen data, especially when ample training data is available.
4.  **Reduced Overfitting (in some contexts):** As observed in the figure below, deep models can sometimes be less prone to overfitting than large, shallow models, given similar parameter counts.

![[Pasted image 20251129092706.png]]

The figure illustrates that shallow models (depth 3, convolutional) might overfit at around 20 million parameters, while deeper models (depth 11, convolutional) can continue to benefit from having over 60 million parameters without overfitting as severely. This suggests that for the same number of parameters, deep models can achieve better performance than shallow ones by effectively utilizing their capacity.
## Training: The Forward and Backward Algorithm
Training a neural network involves adjusting its parameters (weights and biases) to minimize an error function that measures the discrepancy between the network's predictions and the true target values. A naive approach would be to randomly perturb parameters and keep changes that improve performance, but this is highly inefficient.
Instead, we use gradient-based optimization. This involves computing the derivatives of the error function with respect to each model parameter. Once these derivatives (gradients) are known, various optimization algorithms (e.g., gradient descent) can be used to iteratively update the parameters.
In feed-forward neural networks, these derivatives are efficiently computed using an algorithm called **Backward Propagation** (a.k.a. Backprop). Modern neural network toolkits often automate forward and backward propagation, requiring users primarily to define the network architecture.
It's important to note that optimization algorithms in neural networks often do not guarantee finding a globally optimal solution because the error function is typically non-convex, possessing many local optima.
The training process can be broken down into three main steps:
### Step 1: Forward Propagation
During forward propagation, the input data is passed through the network, layer by layer, to compute the output prediction. For a network with one hidden layer, this involves:
*   Computing the hidden layer activations: $h = f_1(W_1^T x + c)$
*   Computing the output layer activations: $y = f_2(W_2^T h + b)$
For deeper networks, this process is extended by iteratively computing activations for each subsequent hidden layer in a bottom-up fashion until the final output layer is reached. This step essentially computes the network's prediction for a given input.
### Step 2: Compute Errors and Derivatives w.r.t. Output Variables
After forward propagation, the network's output ($y_j$) is compared to the true target value ($t_j$) for each output unit $j$. An error function quantifies this discrepancy. A common choice is the squared error (or Mean Squared Error for a batch):
$$
E = \frac{1}{2} \sum_{j} (y_j - t_j)^2
$$
The next step is to compute the derivative of the error function with respect to each output unit's activation ($y_j$). For the squared error, this would be:
$$
\frac{\partial E}{\partial y_j} = y_j - t_j
$$
These derivatives form the starting point for backpropagation, which then propagates the error gradients backward through the network to compute derivatives for parameters in lower layers.
### Step 3: Backward Propagation (Backprop)
Backpropagation is the core algorithm for efficiently computing the gradients of the error function with respect to all weights and biases in the network. It achieves this by applying the chain rule of calculus in a top-down (from output to input) manner.
With backpropagation, error derivatives for hidden units and subsequently for all weights and biases can be computed efficiently. Let's look at the derivative for a single neuron, especially one with a logistic (sigmoid) activation function.
#### Derivatives of the Logistic Activation Function
Suppose we have a logistic neuron where the activation function is $y = \frac{1}{1 + e^{-\alpha}}$, where $\alpha$ is the weighted sum of inputs ($z = w^Tx + b$).
The derivative of the logistic function with respect to its input $\alpha$ is:
$$
\begin{aligned}
\frac{dy}{d\alpha} &= \frac{d}{d\alpha} \left( \frac{1}{1 + e^{-\alpha}} \right) \\&= -1 \cdot (1 + e^{-\alpha})^{-2} \cdot (-e^{-\alpha}) \\&= \frac{e^{-\alpha}}{(1 + e^{-\alpha})^2} \\&= \frac{1}{1 + e^{-\alpha}} \cdot \frac{e^{-\alpha}}{1 + e^{-\alpha}} \\&= y \cdot (1 - y)
\end{aligned}
$$
This form, $y(1-y)$, is very convenient because the value of $y$ has already been computed during forward propagation, making the derivative readily available.
#### Derivative of the Weighted Sum
For the weighted sum $\alpha = b + \sum_i x_i w_i$:
*   The derivative with respect to a weight $w_i$ is:    $$
    \frac{\partial \alpha}{\partial w_i} = x_i
    $$
*   The derivative with respect to an input $x_i$ is:    $$
    \frac{\partial \alpha}{\partial x_i} = w_i
    $$
Knowing these, we can see that once we have the error derivatives for a hidden unit, it's straightforward to get the error derivatives for the weights feeding into that hidden unit by applying the chain rule.

#### Error Derivatives at the Top Two Layers (Example for Logistic Output)
Let $E$ be the total error. For an output unit $j$ with logistic activation $y_j$:
The derivative of the error with respect to the pre-activation sum $\alpha_j = W_2^T h_j + b_j$:
$$
\frac{\partial E}{\partial \alpha_j} = \frac{\partial E}{\partial y_j} \frac{dy_j}{d\alpha_j} = \frac{\partial E}{\partial y_j} y_j (1 - y_j)
$$
Then, the derivative of the error with respect to a weight $w_{ij}$ connecting hidden unit $i$ to output unit $j$:
$$
\frac{\partial E}{\partial w_{ij}} = \frac{\partial E}{\partial \alpha_j} \frac{\partial \alpha_j}{\partial w_{ij}} = \frac{\partial E}{\partial \alpha_j} h_i
$$
The derivative of the error with respect to the activation of a hidden unit $h_i$:
$$
\frac{\partial E}{\partial h_i} = \sum_j \frac{\partial E}{\partial \alpha_j} \frac{\partial \alpha_j}{\partial h_i} = \sum_j \frac{\partial E}{\partial \alpha_j} w_{ij}
$$
This process of computing error derivatives is performed top-down, effectively propagating the error backward through the network.

## Checking Correctness of Backprop Implementation

Backpropagation is notoriously complex and prone to subtle bugs. A crucial step in development is to numerically check the correctness of its implementation.

Recall the mathematical definition of a derivative using finite differences:
$$
\frac{\partial E(\theta)}{\partial \theta} = \lim_{\epsilon \to 0} \frac{E(\theta + \epsilon) - E(\theta - \epsilon)}{2\epsilon}
$$
Thus, for a small constant $\epsilon$ (e.g., $10^{-4}$), we can numerically approximate the derivative as:
$$
\frac{\partial E(\theta)}{\partial \theta} \approx \frac{E(\theta + \epsilon) - E(\theta - \epsilon)}{2\epsilon} \quad (*)
$$
Where $\theta$ represents a single parameter (weight or bias) of the network.

### Algorithm for Checking Backpropagation:
In a neural network, $\theta$ is a vector encompassing all weights and biases. The outline of the checking algorithm is:

1.  **Initialize Parameters:** Randomly pick a set of parameters $\theta$.
2.  **Compute Numerical Gradient:** For each parameter $\theta_k$ in the vector $\theta$:
    *   Create $\theta_{k, \text{plus}}$ by adding $\epsilon$ to $\theta_k$ (i.e., $\theta_{k, \text{plus}} = \theta + \epsilon \cdot e_k$, where $e_k$ is a standard basis vector).
    *   Create $\theta_{k, \text{minus}}$ by subtracting $\epsilon$ from $\theta_k$ (i.e., $\theta_{k, \text{minus}} = \theta - \epsilon \cdot e_k$).
    *   Perform forward propagation with $\theta_{k, \text{plus}}$ to compute $E(\theta_{k, \text{plus}})$.
    *   Perform forward propagation with $\theta_{k, \text{minus}}$ to compute $E(\theta_{k, \text{minus}})$.
    *   Approximate the numerical derivative for $\theta_k$ using equation $(*)$:
        $$
        \text{grad}_{\text{numerical}}(\theta_k) = \frac{E(\theta_{k, \text{plus}}) - E(\theta_{k, \text{minus}})}{2\epsilon}
        $$
3.  **Compute Analytical Gradient:** Perform a single forward pass with the original $\theta$ to compute $E(\theta)$, and then run backpropagation to compute the analytical gradients $\text{grad}_{\text{analytical}}(\theta_k)$ for all parameters.
4.  **Compare Gradients:** Check if the numerical gradient $\text{grad}_{\text{numerical}}(\theta_k)$ is approximately equal to the analytical gradient $\text{grad}_{\text{analytical}}(\theta_k)$ for all $k$. A common metric for comparison is the relative error:
    $$
    \text{Relative Error} = \frac{|\text{grad}_{\text{numerical}} - \text{grad}_{\text{analytical}}|}{|\text{grad}_{\text{numerical}}| + |\text{grad}_{\text{analytical}}|}
    $$
A relative error less than $10^{-7}$ or $10^{-8}$ typically indicates a correct implementation. This process is computationally expensive but invaluable for debugging backpropagation.
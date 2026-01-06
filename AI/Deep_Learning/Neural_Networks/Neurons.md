For simplicity, a neuron is often drawn as follows, where the circle includes both the weighted sum operation and the activation function:
![[Pasted image 20251129091746.png]]
Multiple neurons can be used to construct a complicated [[Neural-Network]]. A network of simple non-intelligent decisions can lead to intelligence.
## Types of Neurons
### Linear Neurons
A linear neuron just computes a weighted sum of input features. These are simple but computationally limited. A multilayer of linear neurons is still a linear model. The output `y` is given by the equation:
$$
y = w^Tx + b = b + \sum_i x_i w_i
$$
Where:
*   $y$ is the output.
*   $x$ is the input vector.
*   $w$ is the weight vector.
*   $b$ is the bias.
*   $x_i$ is the $i^{th}$ input.
*   $w_i$ is the weight corresponding to the $i^{th}$ input.
Artificial neurons often have an activation layer applied over the weighted sum of input. We can think a linear neuron has a linear activation layer.
![[Pasted image 20251104105947.png]]
### Binary Threshold Neurons
Binary Threshold Neurons, also known as perceptrons in their simplest form, use a threshold to determine if the output is 1 or 0. If the weighted sum of inputs exceeds a certain threshold, the neuron fires (output 1); otherwise, it does not (output 0).
The output for a binary threshold neuron is defined as:
$$ a(z) =
\begin{cases}
1 & \text{if } z \ge \text{threshold} \\
0 & \text{if } z < \text{threshold}
\end{cases}
$$
Where $z = w^Tx + b$.
![[Pasted image 20251104110036.png]]
### Rectified Linear Units (ReLU) Neurons
Rectified Linear Neurons (ReLU) compute a weighted sum of their inputs, and the output is a result of a non-linear function. They output the input directly if it is positive, otherwise, they output zero. This non-linearity allows neural networks to learn more complex patterns than linear models.
The output for a ReLU neuron is given by the equation:
$$ a(z) = \max(0, z) $$
Where $z = w^Tx + b$.
![[Pasted image 20251104110201.png]]
### Sigmoid Neurons
Sigmoid Neurons give a real-valued output that is a smooth and bounded function of their total input. They are typically used in the output layer for binary classification problems where the output needs to be interpreted as a probability.
*   Typically they use the logistic function.
*   They have nice derivatives which make learning easy, as the gradient can be easily calculated during backpropagation.
*   For many years, the sigmoid function was widely used due to the convenience of its first derivative.
The output for a sigmoid neuron is given by the logistic function:
$$ y = \frac{1}{1 + e^{-za}} $$
Where $a = w^Tx + b$.
![[Pasted image 20251129091820.png]]

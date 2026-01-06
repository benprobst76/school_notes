In [[Machine-Learning]] **kernel machines** are a class of algorithms for pattern analysis whose best known member is the [[Support-Vector-Machine]].  These methods involve using [[Linear-Classifier]]s  to solve nonlinear problems. 
### Kernel Trick
The kernel trick reduces the amount of computation required for Support Vector Machines by avoiding the math that transforms the data from low to high dimensions. 
In [[K-Nearest-Neighbour]] we often compute the following squared Euclidean distance between two data points $x$ and $z$: $d(x,z)=||x-z||^2 = x^Tx +z^Tz - 2x^Tz$
- We can see that the KNN only needs to compute dot products between two data points (e.g. $x^Tx$) and dot products between a datapoint and itself (e.g., $x^Tx$).  
- Similar to KNN, many classification, regression, and unsupervised algorithms (e.g., Perceptron, PCA, etc.) need only to compute such dot products.  
- Note that both x and z are vector, but $||x − z||^2, x^Tz, z^Tz, x^Tz$ are all scalar.  
- If $x^Tx, z^Tz, x^Tz$ have been computed (which is easy), we can  also easily compute 𝑑′(x, z) above and 𝑑′(x, z) below:  $$ 𝑑′(x, z) = (1 + x^Tx )^2 +(1 + z^Tz)^2 − 2∗(1 + x^Tz)^2$$But 𝑑′(x, z) corresponds to a deep explanation.
![[Pasted image 20251021131443.png]]
The "trick" is that it only needs the **dot product** between data points.
### Kernel Method
The key idea of the kernel method is to first reduce an algorithm to one which depends only on dot products between data points.
- Many machine learning algorithms can be reduced this way
- We can replace the dot product with a kernel function $k(x,z)$
	- $k(x,z)=(1+x^Tz)^2$

Some Widely used kernels:
- Linear: $x^Tz$
- Polynomial: $(c +g x^Tz)^n$
- RBF: $exp(-g||x-z||^2)$
- Sigmoid: $tanh(c+gx^Tz)$
Not all functions can be kernel functions, there are some rules use to construct new kernel functions:
- The sum of two kernels is a kernel  
- The product of two kernels is a kernel  
- A kernel plus a constant is a kernel  
- A scalar times a kernel is a kernel.
Remember the [[Perceptron]]. 
The perceptron classification equation (bias has been absorbed into w and x): $$ f(C_k|x_j)=sign(w^Tx_j)$$
But this does not have the form $x_i^Tx_j$
Remember also how weights are updated in perceptron: the final weights w is a linear combination of input datapoints: $$w=∑_ia_it_ix_i$$
Where $a_i$ is the numbers of time $x_i$ has been misclassified; $x_i$ is a datapoint and $t_i$ is its true label. Now we can "Kernelize" the perceptron because we can represent it in terms of dot product $x_i^Tx_j$ $$f(C_k|x_j)=sign(\sum_i (a_it_i)x_i^Tx_j)$$
Now we can replace $x_i^Tx_j$ with any kernel function $k(x_i^T, x_j)$
The key idea of the kernel method is to take a standard machine learning algorithm and convert it to the format that only relies on dot products $x^T z$.  
- A kernel machine contains two modules: the machine learning algorithm itself and the kernel function.  
- There are many different kernel functions you can use, as we have discussed earlier.  
- To choose among different kernel functions you can use a validation set.
### Gram Matrix
The Gram Matrix is the N-by-N symmetric matrix (N is number of training datapoints) that contains all pairwise dot products between training datapoints.  
- Each element in the matrix (i.e., $G_{ij}$) is a dot product between the corresponding datapoint $x_i$ and $x_j$.  
- Once you have kernelized a machine learning algorithm, you can build the Gram matrix and after that you do not need the original data anymore.  
- Your algorithm will only need to access entries of the Gram matrix, because it depends only on the dot products between  datapoints.

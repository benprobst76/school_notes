Based on the exam papers provided (2018, 2019, 2020, 2022, and 2025), here is a compiled question bank. Duplicate questions have been merged, but variations (e.g., error curves vs. complexity vs. data size) have been kept distinct.
### **Part 1: True or False**
**General Machine Learning & Methodology**
- In machine learning, instead of writing a program by hand for each specific task, a learning algorithm can learn from data. [T]
    
- Supervised models are trained on labeled data while unsupervised models learn from unlabeled data. [T]
    
- In supervised learning, the algorithm is given only inputs without corresponding desired outputs. [F - the algorithm is given desired outputs]
    
- Self-supervised learning blurs the distinction between supervised and unsupervised learning. [T]
    
- Overfitting can be reduced by decreasing the amount of training data. [F - overfitting can be reduced by increasing the amount of training data]
    
- Increasing the order of polynomials in regression decreases the test error because higher-order models are more capable than lower-order models. [F - higher order decreases training error but results in overfitting]
    

**Classification & Regression**
- Classification models must have categorical input (features) and categorical output (predictions); they cannot take continuous input (features). [F - they can take continuous input features]
	
- Regression models have categorical output.[F - they have continuous output]
    
- Classification models have categorical output and regression models have continuous output. [T]
    
- The input of regression must be real-valued numbers. [F -  the input can be anything]
    
- Logistic regression refers to regression models that use the logistic sigmoid function to help make predictions. [F - logistic regression refers to classification models]
    
- Logistic regression computes the posterior probability of classes $p(C_{k}|x)$ directly, without using Bayes' Theorem. [T]
    
- A Perceptron classifier is a discriminative model. [T]
    
- Perceptron classifiers are generative models. [F - they are discriminative]
    
- Discriminative models use Bayes' theorem to find the posterior class probabilities. [F - they learn the decision boundary between classes directly]
    
- After a discriminative model is trained, you cannot calculate the joint probability $p(x,C_{k})$. [T]
    

**KNN, SVM & Kernels**
- KNNs are parametric models. [F - they are non-parametric]
    
- In K Nearest Neighbour (KNN), if K is too large, it often causes overfitting. [F - large K causes underfitting]
    
- The Naïve Bayes assumption is: conditioned on class, features/variables are dependent on each other. [F - the assumption is they are independent of each other]
    
- SVM tries to minimize the margin between two classes. [F - aims to maximize the margin]
    
- A support vector machine (SVM) is a kernelized, minimum-margin hyperplane classifier. [F - kernelized maximum-margin hyperplane classifier]
    
- In SVM, once a model is trained, only support vectors are kept; other non-support vectors are not needed in the test stage. [T]
    
- To train a kernelized classification model, once you have built the Gram Matrix from the original training data, you do not need the original data anymore. [T]
    
- The product of any two kernel functions is still a kernel function. [T]
    
- The kernel trick allows algorithms to calculate the dot product between two datapoints without explicitly mapping the datapoints to that high dimensional space. [T]
    

**Clustering & Unsupervised Learning**
- Clustering is a supervised learning problem and dimensionality reduction is an unsupervised learning problem. [F - clustering is also a unsupervised learning problem]
    
- K-means guarantees to find the globally optimal solution. [F - guarantees convergence to extrema but not does not guarantee its the global extrema]
    
- In K-means clustering, a data point is simultaneously assigned to multiple clusters with a probability distribution. [F -  a data point is assigned to one the clusters known as 1-of-K coding]
    
- In the M step of Mixture of Gaussians, the centre of a cluster is moved to the weighted mean of all datapoints assigned to that cluster in the previous E step. [T]
    
- In Mixture of Gaussians clustering, during the E-step, each datapoint is assigned to the cluster whose center is closest to that datapoint. [F - a data point is assigned to multiple clusters with some probability]
    
- The EM algorithm is an unsupervised clustering model. [T]
    
- When applying PCA dimensionality reduction, you can reconstruct the original data with no information loss even when you leave out some eigenvectors. [F - there will be some information loss if you used fewer components than the original number of dimensions]
    

**Neural Networks & Deep Learning**
- Convolutional neural networks can be used to model image data; they can also be used to model sequence data. [T]
    
- CNNs are fully connected neural networks in which some parameters share the same values. [F - CNNS include fully connected layers and not fully connected layers]
    
- In convolutional neural networks, the hidden units between any two adjacent layers are fully connected. [F - adjacent layers are locally connected]
    
- Convolutional Neural Networks use filters to detect local features in an input. [T]
    
- In CNN, if you use max pooling, the backpropagation takes derivative with regard to every input unit of the pooling layer. [F - it only regards the max input unit]
    
- Compared to normal/basic RNNS, LSTM can alleviate the vanishing gradient issue. [T]
    
- Long Short-Term Memory (LSTM) is a type of convolutional neural networks. [F - it is a recurrent neural network]
    
- HMM is less powerful than Recurrent Neural Networks (RNN). One reason is that HMM uses the 1-of-K encoding for hidden states while RNN's hidden layer can use real-valued numbers. [T]
    
- There is no parameter sharing mechanism in recurrent neural networks but there is parameter sharing in convolutional neural networks. [F - recurrent neural networks use shared weights across all time steps]
    
- Vanishing/exploding gradient is less serious in RNN than in a feed-forward network, because RNN share parameters at different time steps. [F - it is more serious because RNN shares parameters across all time steps]
    
- Compared to the sigmoid activation function, using the ReLU activation makes vanishing gradient more serious. [F - ReLU alleviates vanishing gradient]
    
- Without activation functions, a neural network would be equivalent to a single-layer linear model. [T]
    
- Autoencoders are supervised models. [F - autoencoders are unsupervised]
    
- Dropout has both effects of model averaging and model regularization. [T]
    
- It has been proven that networks without hidden layers are adequate to represent an approximation of any function to an arbitrary degree of accuracy. [F - networks without hidden layers are limited to sates that are directly observable]
    
- Deep learning models are typically more interpretable than traditional machine learning models such as decision trees.  [F - they are typically less interpretable]
    

---

### **Part 2: Multiple Choice (Concepts)**

**Neural Network Components**

- Which are activation functions used in deep learning? ([ReLU], [Sigmoid], [Tanh], Max pooling, Gaussian) 
    
- **Overfitting:** Which techniques help mitigate overfitting? ([Dropout], [Early stopping], [Data augmentation], Average pooling) 
    
- **CNN Layers:** Which are parts of CNN layers? ([Convolutional], Recurrent, [Fully-connected], [Pooling], Hashing) 
	
- What is the equation of a ReLU neuron? ([$y=max(0,wx+b)$] )
    
- **Convolution:** What operation is performed in convolution? ([Dot product between weights and input region], Addition of biases, Matrix inversion, Autoencoding) 
    
- **Pooling:** What is max pooling and why is it used? ([Sampling/reducing size of feature maps], Increasing parameters, Controlling overfitting, [keeping only the maximum features in a region])
    
- **Output Size:** After applying a $2\times2$ filter with stride 1 to a $4\times4$ matrix, what is the size of the resulting feature map? (1 x 1, 2 x 2, [3 x 3], 4 x 4)
    

**Training & Algorithms**

- **Backpropagation:** Which statements are true? ([Computes gradients layer by layer],[Uses chain rule], Updates weights during forward pass, [Used to train neural networks], only used in supervised learning, Optimization algorithm) 
    
- **Mixture of Gaussians (MoG):**
    - What technique is used to find the solution for MoG? (Maximum pooling, Gradient Descent, [EM], Backprop)
        
    - What occurs in the M-step? ([Updating parameters based on memberships], Assigning memberships,  gradient descent, normalizing)
        

**RNNs & LSTMs**

- Which are true of RNNs? ([they suffer from vanishing gradients], equivalent to feedforward, [share parameters across time steps], [LTSMs and GRUs help reduce vanishing gradient])  
    
- **LSTM Components:** Which are components of an LSTM cell? ([Forget gate], [Input gate], Update gate, [Output gate], Reset gate)
    
- **Gating:** What problem does gating mitigate in LSTMs? ([Vanishing gradient], Overfitting, computational inefficiency, high bias)
    

**Regression & Depth**

- Which are true of regression?  ([under-fitting is more likely in constant models], regularization prevents coefficients from becoming small,  deep learning models cannot be used for regression, a regularized model has a lower training error) 
    
- **Depth:** Outcomes of increasing network depth (Improving training speed, Increasing training error, Reducing vanishing gradient, [Mitigating overfitting]).
    
---

### **Part 3: Definitions & Short Answer**

**Explain the following terms/concepts:**

- **General/Methodology:** 
	- Overfitting: [When the model learns the training data too well including its noise and random fluctuations rather than the underlying patterns. This means high training accuracy but a low testing accuracy.]
	- Unsupervised learning: [When a model is trained given only inputs. Features, representations and structures are discovered automatically from the input data.]
	- Cross validation: [Cross validation is a technique that can be applied on the entire training data to select the best-performing model that you can develop. When the data is limited you can split the training data and run part of it as validation for each run. This avoids the validation set being too small.]
	- Regularization: [Often used to control overfitting. It adds a penalty term to the error function to discourage the coefficients from reaching large values making the model simpler and more generalizable.]
	- Models averaging/ensembling: [Combine predictions from multiple models by averaging the outputs to achieve a more accurate overall prediction then any single model.]
	- Data augmentation [A technique to artificially increase the size and diversity of the training dataset. Existing data is transformed into new plausible training examples. This helps reduce overfitting when the original dataset is limited.]
	- Development dataset: [Also called a validation dataset. It is used to compare different models to see which performs better on unseen data. Can also be used to tune hyper-parameters and make architectural decisions. ]
	- Underfitting: [When the model is too simple and does not catch the underlying patterns in the data. Then the model does not learn much from the data.]
- **Models:** 
	- Parametric vs. Non-Parametric models:[Parametric models summarize data with a fixed number of parameters regardless of the training data size and make assumptions about the data's distribution. Non-parametric models can increase the number of parameters with the training data and make fewer assumptions about the data distribution.]
	- Generative vs. Discriminative models: [Discriminative models learn the decision boundary between classes directly and model the conditional probability p(y|x). Generative models learn the distribution of individual classes and model the joint probability p(x,y) or the conditional probability p(x|y) and the prior p(y).]
	- Support Vector Machine: [A kernelized maximum-margin hyperplane classifier. It finds a hyperplane in linearly separable data that separates the data points without misclassifying any and maximizes the margin.]
	- Naïve Bayes classifier: [A probabilistic generative model used for classification tasks. It assumes conditioned on the class, all features are mutually independent.]
	- Decision tree: [A non-parametric supervised learning method used for classification and regression. It predicts the class of a target variable by learning simple decision rules inferred from the data features.]
	- Autoencoder: [An unsupervised neural network designed to learn efficient data codings. It learns a representation (encoding) for a set of data typically for dimensionality reduction by training the network to ignore noise.]
- **Clustering:** 
	- Clustering: [A unsupervised machine learning method that aims to group similar training cases into clusters and identify a prototype example to represent each cluster. Ideally, within each cluster, all cases share very similar input characteristics. ]
	- K-Means: [An unsupervised model that assigns data points into K number of clusters. It alternates in two steps: 1. E step: For all data points, assign each to the cluster whose center is closest to this data point, and 2. M step: Update each cluster’s center to be the mean of all points assigned to that cluster]
	- Agglomerative Clustering: [A bottom-up strategy used for hierarchical clustering that starts with each data point in its own cluster and then successively merges the most similar pairs until a single cluster remains.]
	- Divisive clustering: [A top-down strategy used for hierarchical clustering that starts with all data points in a single cluster and at each step splits the least coherent cluster in two. In the last step every data point has its own cluster.]
- **Neural Networks:** 
	- Recurrent Neural Networks: [ a type of neural networks designed to model sequences. At each time step, RNN has one layer of hidden units to remember history information. So the depth of the network along the time line corresponds to the number of timesteps (the length of input sequences).]
	- Back Propagation: [Used in training feed forward neural networks. It computes the gradients of the error function with respect to all weights and biases in the network by applying the chain rule in a top-down manner.]
	- Dropout: [A regularization technique for neural networks that helps prevent overfitting by randomly dropping out a proportion of neurons during training. Effectively training on a different smaller network on each mini-batch and then averaging predictions.]
	- Rectified Linear Unit (ReLU): [A neuron that computes a weighted sum of their inputs and the output is the result of a non-linear function. They output the input directly if it is positive otherwise they output zero.]
	- Max pooling: [A type of subsampling that divides the input feature map into a set of non-overlapping rectangles and for each sub-region outputs the maximum value. It introduces a degree of invariance to image translation.]
	- Vanishing Gradient: [When errors are back propagating through many time steps and if the weights are small the gradient decays exponentially to zero. The model stops learning from early inputs ]
	- Forward Propagation: [Used in training feed forward neural networks.  It passes the input data through the network layer by layer to compute the output prediction. ]
- **Optimization:** 
	- Local minima: [When the value of the error function is lower than all nearby points but  is not the absolute lowest passible value. If a model gets stuck at a local minimum it thinks it has found the best solution when it has not.]
	- PCA [PCA is the most common linear dimensionality reduction technique. It transforms the data into a new coordinate system such that the greatest variances of the data come to lie on the first coordinates (called principal components).]
- **Algorithms:** 
	- Viterbi algorithm: [A dynamic programming algorithm used in hidden markov models to solve the decoding problem. It finds the single best path through the hidden state space that explains the observed sequence. ]
	- The Kernel Trick: [A method to reduce the amount of computation required for support vector machines by avoiding the math that transforms data from low to high dimensions. The idea is to reduce an algorithm to one the depends only on dot products between data points.]
- **Theorems:** 
	- The Universal Approximator Theorem: [The theorem states that feed-forward networks with a single hidden layer containing a finite number of neurons can approximate any continuous function on compact subsets of real numbers, given appropriate activation functions. Meaning in theory shallow networks can learn any mapping]
	- The Assumption of Naïve Bayes: [It assumes conditioned on the class, all features in the input vector x are mutually independent. While it is rarely true in real world data, it works well in practice.]
    
---
### **Part 4: Graphical & Conceptual Analysis**
**Error Curves**
- **Training/Test vs. Model Complexity:** Draw curves showing typical behaviour of training errors and test errors versus model complexity (assuming fixed training set size). 
	![[Pasted image 20251203123025.png]]
- **Training/Test vs. Data Size:** Draw curves showing typical behaviour of training errors and test errors versus training data sizes. 
    ![[Pasted image 20251203122053.png]]
- **Training/Test vs. K (KNN):** Draw curves showing typical behaviour of training errors and test errors versus the value of K in KNN. 
    ![[Pasted image 20251203123005.png]]
    - _Follow up:_ What are the phenomena associated with K when it is too small or too large? [When K is too small the result has too mush noise and does not ignore outliers. When K is too big you cant learn anything from the data.]
        

**Architecture & Depth**

- **Deep vs. Shallow:** Explain the evidence in the provided graph (Accuracy vs Number of Parameters) that supports the statement that deeper networks are better than shallow ones. 
	![[Pasted image 20251203123241.png]]
	[In the above graph as the number of parameters increase the test accuracy increase for the deep neural network (11 convolutional layers) but for the shallow network (3 layers) the model performances decreases after a certain number parameters are added. Therefore deeper networks are better at learning more complex representations of data. ]
- **CNN Parameters:** Compared to fully connected feedforward networks, how do CNNs reduce the number of model parameters? 
<span style="color:rgb(112, 48, 160)">Instead of having unique connections for every neuron, CNNs employ filters that apply the same set of weights across different regions of input, drastically reducing the number of parameters</span>
### **Part 5: Calculation & Proofs**

**Kernel Methods**

- We have two data points $x = (x_1, x_2)^T$ and $z = (z_1, z_2)^T$ , which are two column vectors. Suppose we have the following kernel function:$$
k(x, z)= (3x^Tz)^2 $$Prove that if we use the above kernel to replace the dot product in a kernelized algorithm, it implicitly maps the data point **x** from $(x_1, x_2)^T$ to a higher dimensional image $\varphi(x)=(3x_{1}^{2}, 3x_{2}^{2}, 3\sqrt{2}x_{1}x_{2})^{T}$ and maps **z** from $(z_1, z_2)^T$ to $\varphi(z)=(3z_{1}^{2}, 3z_{2}^{2}, 3\sqrt{2}z_{1}z_{2})^{T}$
	To prove that the kernel $k(x, z) = (3x^Tz)^2$ implicitly maps the data points to the feature space defined by $\varphi(x)$, we need to show that the kernel function is equal to the dot product of the feature mappings: $$ k(x, z) = \varphi(x)^T \varphi(z) $$**Step 1: Expand the Kernel Function**
	Let $x = (x_1, x_2)^T$ and $z = (z_1, z_2)^T$.
	First, we compute the inner dot product $x^Tz$: $$ x^Tz = x_1z_1 + x_2z_2 $$Now substitute this into the kernel definition and expand:$$

  \begin{aligned}

  k(x, z) &= (3(x^Tz))^2 \\

  &= (3(x_1z_1 + x_2z_2))^2 \\

  &= 3^2(x_1z_1 + x_2z_2)^2 \\

  &= 9(x_1^2z_1^2 + 2x_1z_1x_2z_2 + x_2^2z_2^2) \\

  &= 9x_1^2z_1^2 + 18x_1z_1x_2z_2 + 9x_2^2z_2^2

  \end{aligned} $$**Step 2: Compute the Dot Product of the Feature Mappings**
	Now we compute the dot product of the proposed feature mappings $\varphi(x)$ and $\varphi(z)$. Given: $$ \varphi(x) = (3x_1^2, 3x_2^2, 3\sqrt{2}x_1x_2)^T $$$$ \varphi(z) = (3z_1^2, 3z_2^2, 3\sqrt{2}z_1z_2)^T $$The dot product is:$$

  \begin{aligned}

  \varphi(x)^T \varphi(z) &= (3x_1^2)(3z_1^2) + (3x_2^2)(3z_2^2) + (3\sqrt{2}x_1x_2)(3\sqrt{2}z_1z_2) \\

  &= 9x_1^2z_1^2 + 9x_2^2z_2^2 + (3 \cdot 3 \cdot \sqrt{2} \cdot \sqrt{2}) x_1x_2z_1z_2 \\

  &= 9x_1^2z_1^2 + 9x_2^2z_2^2 + (9 \cdot 2) x_1x_2z_1z_2 \\

  &= 9x_1^2z_1^2 + 9x_2^2z_2^2 + 18x_1x_2z_1z_2

  \end{aligned}

  $$By comparing the results from Step 1 and Step 2, we can see that: $$ 9x_1^2z_1^2 + 18x_1z_1x_2z_2 + 9x_2^2z_2^2 = 9x_1^2z_1^2 + 9x_2^2z_2^2 + 18x_1x_2z_1z_2 $$Thus, **$k(x, z) = \varphi(x)^T \varphi(z)$**, proving that the kernel implicitly maps the data to the 3-dimensional space defined by $\varphi$.
    
- Repeat the question above for kernel $k(x,z)=(3+x^{T}z)^{2}$, prove it maps $x$ to $\varphi(x)=(3, \sqrt{6}x_{1}, \sqrt{6}x_{2}, x_{1}^{2}, \sqrt{2}x_{1}x_{2}, x_{2}^{2})$. 
	First, we compute the inner dot product $x^Tz$: $$ x^Tz = x_1z_1 + x_2z_2 $$Now substitute this into the kernel definition and expand:$$

  \begin{aligned}
  k(x, z) &= (3 + (x^Tz))^2 \\
  &= (3 + (x_1z_1 + x_2z_2))^2 \\
  &= 3(3) + 3(x_1z_1 + x_2z_2) + (x_1z_1 + x_2z_2)(3) + (x_1z_1 + x_2z_2)(x_1z_1 + x_2z_2) \\
  &= 9 + 6x_1z_1 + 6x_2z_2 + x_1^2z_1^2 + 2x_1z_1x_2z_2 + x_2^2z_2^2 \\
  \end{aligned} $$
  Now we compute the dot product of the proposed feature mappings $\varphi(x)$ and $\varphi(z)$. The dot product: $$
    \begin{aligned}
    \varphi(x)^T \varphi(z) &= (3)(3) + (\sqrt{6}x_1)(\sqrt{6}z_1) + (\sqrt{6}x_2)(\sqrt{6}z_2) + x_1^2z_1^2 + (\sqrt{2}x_1x_2)(\sqrt{2}z_1z_2) + x_2^2z_2^2 \\
    &= 9 + 6x_1z_1 + 6x_2z_2 + x_1^2z_1^2 + 2x_1z_1x_2z_2 + x_2^2z_2^2
    \end{aligned}
  $$Comparing the results we can see they are the same. 
- Repeat the question above for kernel $k(x,z)=(x^{T}z)^{3}$, prove the implicit mapping to higher dimensional image $\varphi(x)=(x_1^3, \sqrt{3}x_1^2x_2, \sqrt{3}x_1x_2^2, x_2^3)^T$ $$\begin{aligned}
	k(x,z)&=(x^Tz)^3 \\
	&= (x_1z_1 + x_2z_2)^3 \\
	&= (x_1^2z_1^2 + 2x_1z_1x_2z_2 + x_2^2z_2^2)(x_1z_1+x_2z_2) \\
	&= x_1^3z_1^3 + 3x_1^2z_1^2x_2z_2 + 3x_1z_1x_2^2z_2^2 + x_2^3z_2^3
	\end{aligned}$$$$
    \begin{aligned}
    \varphi(x)^T \varphi(z) &= (x_1^3, \sqrt{3}x_1^2x_2, \sqrt{3}x_1x_2^2, x_2^3)(z_1^3, \sqrt{3}z_1^2z_2, \sqrt{3}z_1z_2^2, z_2^3) \\
    &= x_1^3z_1^3+3x_1^2x_2z_1^2z_2+3x_1x_2^2z_1z_2^2+x_2^3z_2^3
    \end{aligned}
   $$
- **Identify Kernels:** Label the following as polynomial, RBF, etc.
    - $(x^{T}z)^{3}$
	    This is a **Polynomial Kernel** with parameters $\gamma=1$, $r=0$, and degree $d=3$.
    - $tanh(1+x^{T}z)$
        This is a **Sigmoid Kernel** (also known as a Hyperbolic Tangent Kernel) with parameters $\gamma=1$ and $r=1$.
    - $exp(-2||x-z||^{2})$
        This is a **Radial Basis Function (RBF) Kernel** or **Gaussian Kernel** with parameter $\gamma=2$.
    - $(2+3x^{T}z)^{2}$ 
        This is a **Polynomial Kernel** with parameters $\gamma=3$, $r=2$, and degree $d=2$.

**Naive Bayes Calculation**
- Given a dataset of Insurance (Low/High) based on Age (Senior/Adult) and Car (Regular/Sports/Vintage), manually calculate class priors and conditional distributions. ![[Pasted image 20251204085851.png]]
	$$\begin{aligned}
	P(y=H) &= 1/2 \\
	P(y=L) &= 1/2 \\
	P(x_1=senior | y=H) &= 3/5\\
	P(x_1=adult | y=H) &= 2/5 \\
	P(x_1=senior | y=L) &= 1/5\\
	P(x_1=adult | y=L) &= 4/5\\
	P(x_2=regular | y=H) &= 0\\
	P(x_2=sports | y=H) &= 2/5\\ 
	P(x_2=vintage | y=H) &= 3/5\\
	P(x_2=regular | y=L) &= 4/5\\
	P(x_2=sports | y=L) &= 0\\
	P(x_2=vintage | y=L) &= 1/5
	\end{aligned}
	$$
- Classify a new data point $x_{test}=(Senior, Sports)$ using the calculated probabilities. 
    Calculate the posterior probability for each class $y \in \{H, L\}$ using the Naive Bayes assumption.
	The classification rule is to choose the class $y$ that maximizes: $$ P(y | x_1, x_2) \propto P(y) \cdot P(x_1 | y) \cdot P(x_2 | y) $$**1. Calculate for High Insurance ($y=H$)** $$
  \begin{aligned}
  P(y=H | Senior, Sports) &\propto P(y=H) \cdot P(Senior | H) \cdot P(Sports | H) \\
  &= \frac{1}{2} \cdot \frac{3}{5} \cdot \frac{2}{5} \\
  &= 0.12
  \end{aligned}
  $$
  **2. Calculate for Low Insurance ($y=L$)**$$
  \begin{aligned}
  P(y=L | Senior, Sports) &\propto P(y=L) \cdot P(Senior | L) \cdot P(Sports | L) \\
  &= \frac{1}{2} \cdot \frac{1}{5} \cdot 0 \\
  &= 0
  \end{aligned}
  $$The data point is classified as: **Class H (High Insurance)**

**Gaussian Classifiers**
- In the process of training Gaussian Classifier p(x|Ck): Assuming we have two classes C1, and C2 and they share the same covariance matrix ∑, write out the formulas used to estimate $\mu_1$ and $\mu_2$, assuming that N1, is the number of training datapoints in class C1; N2 is the number of training datapoints in class C2; N is the total number of training datapoints across both classes. Xn is a single training datapoint. 
    To estimate the means ($\mu_1$ and $\mu_2$) for two classes $C_1$ and $C_2$ in a Gaussian Classifier, given that they share the same covariance matrix, we use the sample mean of the training data points belonging to each respective class. Let $N_1$ be the number of training data points in class $C_1$, and $N_2$ be the number of training data points in class $C_2$. Let $X_n$ denote a single training data point.  
  The formulas for estimating $\mu_1$ and $\mu_2$ are:
  For class $C_1$: $$ \hat{\mu}_1 = \frac{1}{N_1} \sum_{n=1}^{N_1} X_n^{(1)} $$where $X_n^{(1)}$ represents the $n$-th training data point belonging to class $C_1$.
  For class $C_2$: $$ \hat{\mu}_2 = \frac{1}{N_2} \sum_{n=1}^{N_2} X_n^{(2)} $$where $X_n^{(2)}$ represents the $n$-th training data point belonging to class $C_2$. These estimators are simply the empirical means of the data points within each class.
- Write the formulas to estimate $\Sigma$ (shared covariance matrix) as a weighted sum of $S_{1}$ and $S_{2}$. 
    Use a pooled estimate that is a weighted sum of their individual sample covariance matrices, $S_1$ and $S_2$. First, the individual sample covariance matrices for each class are given by: $$ S_k = \frac{1}{N_k - 1} \sum_{n=1}^{N_k} (X_n^{(k)} - \hat{\mu}_k)(X_n^{(k)} - \hat{\mu}_k)^T $$where:
   * $N_k$ is the number of training data points in class $C_k$.
   * $X_n^{(k)}$ is the $n$-th training data point from class $C_k$.
   * $\hat{\mu}_k$ is the estimated mean vector for class $C_k$.
  The shared (pooled) covariance matrix $\hat{\Sigma}$ is then estimated as a weighted average of $S_1$ and $S_2$: $$
  \hat{\Sigma} = \frac{(N_1 - 1)S_1 + (N_2 - 1)S_2}{N_1 + N_2 - 2}
  $$
  This formula combines the scatter matrices (the numerators of the individual covariance matrices) and divides by the total degrees of freedom ($N_1 - 1 + N_2 - 1 = N_1 + N_2 - 2$). This provides an unbiased estimate of the shared covariance matrix.
- Technique used to find solutions for Gaussian classifiers? 
    The technique used to find the solutions (parameters $\mu$, $\Sigma$, and priors) for Gaussian Classifiers is **Maximum Likelihood Estimation (MLE)**.

**Logistic Regression & Perceptron**
**Logistic Calculation:** Given the following hyperplane $w^{T}x$ 
$$w^Tx=(0.1,0.9,2.6)\pmatrix{1\\x_1\\x_2}$$
	For binary classification, you can calculate the probability of x belonging to class 1, p(C=1|x), by computing the above value and then apply a logistic sigmoid function on it. Write the equation of the sigmoid logistic function: $$ \sigma(z) = \frac{1}{1 + e^{-z}} $$
	where $z$ is the input ($w^Tx$). This function squashes any real-valued number into a probability between 0 and 1.
Given a data point, $x=(x_1=3,x_2=1)$ classify it using the sigmoid function. 
    **Step 1: Calculate the value of the hyperplane $w^Tx$**
	The hyperplane equation expands to: $$ w^Tx = (0.1 \times 1) + (0.9 \times x_1) + (2.6 \times x_2) $$Substitute the given values for $x_1 = 3$ and $x_2 = 1$: $$ w^Tx = 0.1 + (0.9 \times 3) + (2.6 \times 1) $$$$ w^Tx = 0.1 + 2.7 + 2.6 $$$$ w^Tx = 5.4 $$
	  **Step 2: Apply the logistic sigmoid function to find $P(C=1|x)$**
	  Now we apply the logistic sigmoid function to the calculated $w^Tx$ value (let $z = w^Tx = 5.4$) to find the probability of the data point belonging to Class 1: $$ P(C=1|x) = \frac{1}{1 + e^{-z}} $$Substitute $z = 5.4$: $$ P(C=1|x) = \frac{1}{1 + e^{-5.4}} $$Calculate $e^{-5.4}$:$$ e^{-5.4} \approx 0.004517 $$Now, substitute this back into the probability equation:$$ P(C=1|x) = \frac{1}{1 + 0.004517} $$$$ P(C=1|x) = \frac{1}{1.004517} $$$$ P(C=1|x) \approx 0.99549 $$**Step 3: Classify the data point** For binary classification using the logistic regression model, if $P(C=1|x) > 0.5$, the data point is classified as Class 1. Otherwise, it is classified as Class 2. In this case, $P(C=1|x) \approx 0.99549$. Since $0.99549 > 0.5$, the data point is classified as **Class 1**.
    
**Perceptron Code:** Fill in the missing lines of pseudo-code for `PerceptronTrain` (Prediction calculation and Weight update rule). 
```
PerceptronTrain(X, t)(// X: feature matrix; t: true labels (take a value of 1 or -1)
w = small random values; //Initialize random weights 
do {
	errors = 0;
	for n = 0: N-1 { //loop through all training data points
		x = X(n); //get the feature vector of the nth data point
		У (x) = sign(w^T * x); //compute prediction y(x) based on x
		if (y(x) != t(n)){
			W= W + t(n) * x;; //update weights/parameters
			errors ++;
		}
	}until (errors == 0)
 return w;
```
    
**Regularization**
- The first half of the following equation is the sum of errors made on training data, the second half is a regularizer. More specifically, N is the number of training datapoints, Xn is one datapoint, y(Xn, W) is the output/prediction of the model on datapoint Xn , w are model parameters, tn is the (true) target value, $\lambda$  is the coefficient of the regularizer, D is the dimensionality of w, wj is one parameter in w and q is the constant that determines the form of the regularizer. $$ \frac{1}{2}\sum^N_{n-1}\{y(x_n,w)-t_n\}^2+\frac{\lambda}{2}\sum^D_{j=1}|w_j|^q$$
- Based on the above equation, briefly describe what is Lasso Regularizer and what is Quadratic Regularizer.
	**Quadratic Regularizer (L2 Regularization)**
   * **Definition:** This regularizer corresponds to setting $q = 2$ in the regularization term. $$ \frac{\lambda}{2}\sum^D_{j=1}w_j^2 $$      (Note: $|w_j|^2 = w_j^2$)
   * **Description:** It penalizes the square of the magnitude of the weights. The effect is to discourage very large weights, thereby preventing the model from becoming too complex and overfitting the training data. While it drives weights to be small, it typically does not drive them exactly to zero. It is also known as Ridge Regression when used with linear models.
  **Lasso Regularizer (L1 Regularization)**
   * **Definition:** This regularizer corresponds to setting $q = 1$ in the regularization term. $$ \frac{\lambda}{2}\sum^D_{j=1}|w_j| $$ **Description:** It penalizes the absolute value of the magnitude of the weights. A key characteristic of Lasso regularization is its ability to perform **feature selection** by driving the weights of less important features exactly to zero. This results in sparser models, effectively removing features from the model and simplifying its interpretation. It is also known as Lasso Regression when used with linear models.
    
- **Visual Analysis:** Given a figure with error contours and a regularization circle, mark the optimal parameter $w^{*}$ and describe the effect of regularization. 
    ![[Pasted image 20251022082608.png]]

---

### **Part 6: Algorithms & Models (Long Answer)**

**Hidden Markov Models (HMM)**
- **Viterbi Algorithm:**
    - What is it used for?
	    [To solve the decoding problem: find the most probable sequence of hidden states in a HMM.]
  **Markov Model (HMM)**, given a sequence of observed events.
    - If I have an input sequence of length N and if each hidden variable can take one of K values. If I run the Viterbi algorithm What is the time complexity in terms of $N$ and $K$? 
    - $O(N K^2)$.
	  This complexity arises because for each of the $N$ steps in the input sequence, the algorithm needs to consider transitions from all $K$ possible previous hidden states to all $K$ possible current hidden states, leading to $K \times K$ operations for each step.
		
    - **Calculation:** For the "Dishonest Casino" model (Fair/Loaded dice), manually follow the Viterbi algorithm to fill out the V matrix and Ptr matrix for observation sequence "2, 6, 6". Find the optimal hidden state sequence. 
	    ![[Pasted image 20251204154611.png]]
	    
        
- **Forward Algorithm:** What probability does it compute? How do you modify Viterbi to make it the Forward algorithm?
	[the probability of observing a given sequence of observations up to a certain time t AND being in a particular hidden state i at that time t. More formally, for each time step t and each possible hidden state i, it calculates] $\alpha_t(i) =  P(O_1, O_2, \dots, O_t, S_t = i)$, where $O_1, \dots, O_t$ is the observed sequence and $S_t = i$ is the hidden state at time $t$.  [By summing these probabilities over all possible hidden states at the final time step, it can also be  used to efficiently calculate the total probability of observing the entire sequence], $P(O_1, O_2,\dots, O_T)$.

**Neural Networks**
- **Back propagation:** Explain what it is. Write the formula for $\frac{\partial E}{\partial w_{ij}}$ in terms of $\frac{\partial E}{\partial\alpha_{j}}$ and $\alpha_j$. 
	[Back propagation is the core algorithm for efficiently computing the gradients of the error function with respect to all weights and biases in the network. ]
	The formula for the partial derivative of the error $E$ with respect to a weight $w_{ij}$ (connecting neuron $i$ in the previous layer to neuron $j$ in the current layer) is derived using the chain rule.
	Let's define the terms:
   * $E$: The total error or loss function.
   * $w_{ij}$: The weight connecting the output of neuron $i$ in the _previous layer_ to the input of neuron $j$ in the _current layer_.
   * $a_i$: The _output activation_ of neuron $i$ from the _previous layer_.
   * $\alpha_j$: The *pre-activation* (or net input) of neuron $j$ in the *current layer*. This is
     calculated as the weighted sum of inputs from the previous layer, including $w_{ij}a_i$: $$ \alpha_j = \sum_{k} w_{kj} a_k $$Using the chain rule, we can write:$$ \frac{\partial E}{\partial w_{ij}} = \frac{\partial E}{\partial \alpha_j} \cdot \frac{\partial
  \alpha_j}{\partial w_{ij}} $$Now, we need to find $\frac{\partial \alpha_j}{\partial w_{ij}}$. From the definition of $\alpha_j$:
  $$ \frac{\partial \alpha_j}{\partial w_{ij}} = \frac{\partial}{\partial w_{ij}} \left( \sum_{k} w_{kj}
  a_k \right) $$
  When differentiating $\alpha_j$ with respect to a specific weight $w_{ij}$, only the term involving $w_{ij}$ remains, and all other terms become zero because they are independent of $w_{ij}$. $$ \frac{\partial \alpha_j}{\partial w_{ij}} = a_i $$ (where $a_i$ is the output of neuron $i$ in the *previous* layer, which serves as an input to neuron $j$ via weight $w_{ij}$).
  Substituting this back into the chain rule equation, we get: $$ \frac{\partial E}{\partial w_{ij}} = \frac{\partial E}{\partial \alpha_j} \cdot a_i $$This formula shows that the derivative of the error with respect to a weight is the product of the error signal propagating back to the neuron ($\frac{\partial E}{\partial \alpha_j}$) and the activation of the neuron ($a_i$) that sends its output along that weight.
    
- **Vanishing Gradient:** Explain what it is using a diagram of units $i$ and $j$. 
    **Vanishing gradient** is a problem that occurs during the training of deep neural networks (especially with sigmoid or tanh activation functions) where the error signal used to update weights becomes exponentially small as it propagates backward from the output layer to the input layer.
	**Explanation using unit $i$ and unit $j$:**
	Consider a network where **unit $i$** is in an early layer (closer to the input) and **unit $j$** is in a later layer (closer to the output), and there is a connection from $i$ to $j$ with weight $w_{ij}$.
   1. **Backward Propagation:** During backpropagation, the error signal (gradient) travels backward from **unit $j$** to **unit $i$** to calculate how much to adjust the weights.
   2. **The Chain Rule:** The gradient at **unit $i$** is calculated by multiplying the gradient coming from **unit** **$j$** by the derivative of the activation function (e.g., sigmoid) and the weight $w_{ij}$.
   3. **The Problem:** If the derivative of the activation function is small (e.g., the maximum derivative of a sigmoid function is 0.25) and the weights are small ($<1$), this multiplication results in a smaller value.
   4. **Vanishing Effect:** In a deep network, this multiplication happens repeatedly across many layers. By the time the error signal propagates all the way back to **unit $i$**, the gradient has been multiplied by small numbers so many times that it approaches zero.
   5. **Consequence:** The weights associated with **unit $i$** receive almost no update, causing the early layers of the network to stop learning or learn extremely slowly
- **Components:** Draw and explain the components of a Sigmoid Neuron vs. a Rectified Linear Neuron. Write gradient equations for Sigmoid and Tanh. 
    ReLU ![[Pasted image 20251104110201.png]]
    Sigmoid ![[Pasted image 20251129091820.png]]
     **Gradient Equations**
	These equations represent the derivative of the activation function output ($a$) with respect to its input ($z$).
  **1. Sigmoid Gradient**
  If the activation function is $a = \sigma(z) = \frac{1}{1+e^{-z}}$, the gradient is: $$ \sigma'(z) = \sigma(z)(1 - \sigma(z)) $$(or simply $a(1-a)$)
  **2. Tanh Gradient**
  If the activation function is $a = \tanh(z) = \frac{e^z - e^{-z}}{e^z + e^{-z}}$, the gradient is:$$ \tanh'(z) = 1 - \tanh^2(z) $$(or simply $1 - a^2$)
- **CNNs:** Draw a figure to demonstrate main components (e.g., LeNet5). Explain how components work. 
	![[Pasted image 20251119134257.png]]
	**1. Convolutional Layer (Feature Extraction)**
	 This is the core building block.
   * **Filters (Kernels):** Small, learnable matrices (e.g., 3x3 or 5x5) slide (convolve) across the input image.
   * **Feature Maps:** At each position, the filter performs an element-wise multiplication with the input pixels and sums the result. This produces a "feature map" that highlights specific patterns like edges, corners, or textures detected by that filter.
   * **Parameter Sharing:** The same filter is used across the entire image, significantly reducing the number of parameters compared to fully connected layers and allowing the network to detect the same feature anywhere in the image (translation invariance).
   * **Activation Function (ReLU):** A Rectified Linear Unit (ReLU) is usually applied after convolution to introduce non-linearity, allowing the network to learn complex patterns.
   **2. Pooling Layer (Downsampling)**
  This layer reduces the spatial dimensions (width and height) of the feature maps while retaining the most important information.
   * **Operation:** It slides a window over the feature map and condenses the information.
   * **Max Pooling:** Takes the maximum value from the window (e.g., the strongest edge detected in that region).
   * **Average Pooling:** Takes the average value.
   * **Benefit:** Reduces computational cost, prevents overfitting, and makes the network robust to small translations or distortions in the image.
  **3. Fully Connected (Dense) Layer (Classification)**
  After several alternating convolutional and pooling layers, the high-level reasoning happens here.
   * **Flattening:** The 2D/3D feature maps from the final pooling layer are flattened into a single 1D vector.
   * **Dense Connection:** This vector is fed into a standard feed-forward neural network (like a multi-layer perceptron).
   * **Output:** The final layer typically uses a **Softmax** activation function to output a probability distribution over the target classes (e.g., "Cat: 0.8, Dog: 0.1, Car: 0.1").
   * 
**Autoencoders**
- **Structure:** Draw a figure showing the main components. Explain them. 
    ![[Pasted image 20251119140310.png]]
    Used primarily for dimensionality reduction and learning efficient data codings. It consists of two main, symmetrically structured components:
   1. **Encoder:**
       * **Purpose:** This part takes the input data and transforms it into a lower-dimensional representation, often called the "code," "latent representation," or "bottleneck."
       * **Functionality:** It learns to compress the input, extracting the most important features and discarding redundant information. It typically consists of several layers that progressively decrease in size.
   1. **Decoder:**
       * **Purpose:** This part takes the compressed latent representation generated by the encoder and attempts to reconstruct the original input data from it.
       * **Functionality:** It learns to "decompress" the code back into a format that closely resembles the original input. Its structure often mirrors the encoder, with layers progressively increasing in size.  
  The autoencoder is trained by minimizing the **reconstruction error**—the difference between the original input and the reconstructed output. By forcing the network to reconstruct its own input through a bottleneck layer, it learns a compact yet informative representation of the data.
- **Comparison:** Compare Autoencoders with PCA. Why/how are they different? 
	**PCA (Linear):** PCA is strictly a **linear** transformation. It finds the linear combinations of features (principal components) that capture the most variance in the data. It essentially rotates and projects the data onto a lower-dimensional hyperplane.
	**Autoencoders (Non-Linear):** Autoencoders, specifically those with non-linear activation functions (like ReLU or Sigmoid), can learn complex, **non-linear** manifolds. They can capture curved or twisted structures in the data that PCA would miss.
	An autoencoder with a **single linear hidden layer** and a squared error loss function is essentially **equivalent to PCA**. However, the true power of autoencoders comes from their ability to use **multiple** **layers and non-linearities** to model complex data structures that PCA cannot.
- **Denoising:** What are denoising autoencoders and what are they used for?
    A Denoising Autoencoder (DAE) is a specific type of autoencoder designed to be robust to noise. A DAE first corrupts the input data (e.g., by adding Gaussian noise, setting random pixels to zero, or masking parts of the input). It is then trained to predict the original, uncorrupted data point as its output.By having to "denoise" the input to reconstruct the original, DAEs learn more robust and useful feature representations that are less sensitive to noise or minor variations in the input data.
**PCA**
- Briefly explain what is PCA. What are the two equivalent views of PCA. Describe the major steps (starting with scaling).
	PCA is a linear dimensionality reduction technique. It transforms the data into a new coordinate system such that the greatest variances of the data come to lie on the first coordinates (called principal components).
	**VIEW #1 (Maximize Variance):** PCA can be defined as the orthogonal projection of the data onto a lower-dimensional linear space, known as the principal subspace, such that the variance of the projected data is maximized.
	**VIEW #2 (Minimize Projection Error):** Equivalently, it can be defined as the linear projection that minimizes the average projection cost, defined as the mean squared distance between the data points and their projections.
1. **Standardize the Data:**
       * Subtract the mean of each feature (dimension) from all data points. This centers the data around the origin.
     2. **Calculate the Covariance Matrix:**
       * Compute the covariance matrix of the standardized data. This square matrix summarizes the relationships between all pairs of features, showing how they vary together.
   3. **Compute Eigenvalues and Eigenvectors:**
       * Calculate the eigenvalues and corresponding eigenvectors of the covariance matrix. The **eigenvectors** represent the principal components (the new orthogonal axes or directions of
         maximum variance in the data). The **eigenvalues** quantify the amount of variance captured along each principal component.
   4. **Select Principal Components:**
       * Sort the eigenvalues in descending order and arrange their corresponding eigenvector accordingly. Choose the top-$k$ eigenvectors (principal components) that correspond to the largest
         eigenvalues.
   1. **Project Data to New Subspace:**
       * Transform the original (standardized) dataset by multiplying it with this projection matrix. The result is the new, lower-dimensional dataset, where each data point is now represented by its coordinates along the principal components.

**Non-Linearly Separable Data**
- Name two different machine learning approaches/models that can classify data that is not linearly separable. Explain how they work. 
    **1. Support Vector Machines (SVM) with Kernel Trick**
   * **How it works:** A standard SVM finds a linear decision boundary (hyperplane) that maximizes the margin between classes. When data is not linearly separable in the original input space, SVMs use the **"Kernel Trick"**. This technique implicitly maps the input data into a much higher-dimensional (possibly infinite) feature space. In this higher-dimensional space, the data often becomes linearly separable. The SVM then finds the optimal linear hyperplane in this new space. When this linear boundary is projected back into the original input space, it appears as a complex, non-linear decision boundary.
  **2. Neural Networks (specifically Multi-Layer Perceptrons / Deep Learning)**
   * **How it works:** Neural networks achieve non-linear classification through the use of **hidden layers** and **non-linear activation functions** (like ReLU, Sigmoid, or Tanh). A single layer perceptron can only learn linear boundaries. However, by stacking multiple layers of neurons, the network can learn to combine simple linear boundaries to form complex shapes. Each neuron in a hidden layer effectively learns a linear decision, and subsequent layers combine these decisions. The non-linear activation     functions allow the network to approximate virtually any complex function, enabling it to draw highly intricate, non-linear decision boundaries to separate the classes.

**LSTM**
- Draw a figure showing the main components of LSTM. Explain each briefly. 
    ![[Pasted image 20251130082359.png]]
    **Cell State ($c_t$):** The internal memory.
*   **Hidden State ($h_t$):** The output.
*   **Gates:** 
    *   **Input Gate ($i_t$):** Controls how much new information flows into the memory cell.
    *   **Forget Gate ($f_t$):** Controls how much of the previous memory cell content is retained.
    *   **Output Gate ($o_t$):** Controls how much of the internal memory is exposed as the output hidden state.
- What are the advantages of LSTM over a regular recurrent neural network? The primary advantage of Long Short-Term Memory (LSTM) networks over regular Recurrent Neural Networks (RNNs) is their ability to effectively **learn and retain long-term dependencies** in sequential data.
  Here are the specific advantages:
   1. **Mitigates the Vanishing Gradient Problem:**
       * **Regular RNNs:** During backpropagation through time (BPTT), gradients can become exponentially small as they are propagated back through many time steps. This causes the network to "forget" information from earlier in the sequence, making it difficult to learn relationships between distant events.
       * **LSTMs:** They introduce a unique internal structure with "gates" (input, forget, and output gates) and a "cell state" that acts as a gradient superhighway. This allows gradients to flow through time largely unchanged, enabling the network to learn from data points that are far apart in the sequence.
   2. **Selective Information Flow (Gating Mechanisms):**
       * **Regular RNNs:** At each step, the hidden state is completely overwritten by a function of the new input and the previous hidden state. It struggles to differentiate between important and irrelevant information over long periods.
       * **LSTMs:** The gating mechanisms give the network precise control over what information to keep, what to discard (forget), and what to output at each time step.
           * **Forget Gate:** Decides what information from the previous cell state is no longer relevant and should be removed.
           * **Input Gate:** Decides what new information is important and should be stored in the cell state.
           * **Output Gate:** Decides what part of the current cell state should be output to the next hidden state.
   2. **Maintaining a Constant Error Carousel (CEC):**
       * The central unit of an LSTM is the "cell state," which essentially loops back to itself with a weight of 1. This creates a "Constant Error Carousel," allowing error signals to circulate within the cell for a long time without vanishing or exploding, effectively preserving th  memory of past inputs.
  **In summary:** LSTMs are superior for tasks involving long sequences (like language modeling, machine translation, or speech recognition) because they can "remember" relevant context over much longer intervals than standard RNNs.
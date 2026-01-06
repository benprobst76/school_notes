 Outputs are categorical and inputs are anything. The goal is to select the correct class for new inputs. Example - binary choice 1 and 0, image classification, spam email or not.

**Features:** We need to represent the inputs and outputs that we know about as a matrix. Categorical or continuous data that is used to determine the categorical output. 

- This puts the data in a feature space. Traditionally we design good features to build a feature space
- Once in a matrix, normalization must be done. If one feature has a broad range of values it will dominate the classifiers _Euclidean distance_ which is not good
- **Euclidean distance:** Many classifiers need to compute the distance between datapoints
- Example [[K-Nearest-Neighbour]], [[Gaussian-Classifier]], [[Naïve-Bayes-Classifier]], [[Linear-Classifier]] [[Logistic-Regression]], and [[Decision-Trees]]

### Extended Feature Spaces
Up to now, our common approach to different classification problems is:  
- We first represent the input (a datapoint) of a problem as a vector x  
- Then we use some geometric or linear algebraic method to perform classification.  
We can often make our algorithms much more powerful by mapping  the data into a higher dimensional space which includes some nonlinear functions of the original features.  
- For example, if we have an input vector $x =(x_1,x_2,x_3)$ we can enrich it as $\phi(x)=(1,x_1,x_2,x_3,x_1^2,x_2^2,x_3^2,x_1x_2,x_2x_3,x_1x_3)$ 
- Mapping can make non linearly separable data to be linearly separable in a higher dimensional space
- In the [[Perceptron]] algorithm the notation $\phi(x)$ is used. Now here is one scenario of constructing $\phi(x)$ 
We have mapped our data $x$ into an extended, higher dimensional feature space using nonlinear mapping, and then we can run our classification algorithm in that new space. $\phi(x)$ is often called the image of $x$ and the point $x$ can be called the pre-image of $\phi(x)$.
The dimensionality of the extended feature space may be ultra-high or even infinite. Explicitly mapping datapoints to a higher dimensional space may not be practical or even  
possible. So we can use the [[Kernel-Method]]


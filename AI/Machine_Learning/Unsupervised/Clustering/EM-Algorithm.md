The iterative E-step and M-step algorithm is called Expectation-Maximization (EM) algorithm. The EM algorithm is an optimization method used in situations when we have some unobserved variables.  
- E step: Estimate “expectation” of “missing” or “unobserved” variables from observed data and current parameters.  
	- In [[Mixture-of-Gaussians]], we compute the “soft assignment” weights $Υ(z_{nk})$.  
- M step: Using this “complete” data, find the maximum likelihood parameter estimates.  
	- In Mixture of Gaussians, based on the assignment of points to different clusters, we use regular maximum likelihood solution to estimate means $μ_k$ and covariances $Σ_k$.

Many people confuse EM with Mixture of Gaussians but they are different. 
- EM is an optimization strategy for objective functions when we have some latent variables
- EM is not a model such as Mixture of Gaussians and [[K-Means-Clustering]]; it is used in these models to help optimize these models

Th EM algorithm can be applied to many problems with latent variables:  
- [[Mixture-of-Gaussians]] 
- [[Hidden-Markov-Models]]  
- Mixtures of Experts  
- [[Classification]] with some class labels missing in training data
In short remember to resort to the EM algorithm when you have some missing input, labels, or latent variables.
#### Multiple Solutions
We have seen that if we use different starting cluster centres, the EM algorithm may get different solutions. The EM optimization algorithm guarantees the model’s convergence to extrema but does not guarantee finding global extrema. (Often, we use different initializations, run the algorithms multiple times, and pick the solution with minimal error to try to avoid local  
extrema.)  
![[Pasted image 20251022101446.png]]

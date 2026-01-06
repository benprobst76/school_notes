A class-conditional generative model. In [[Naïve-Bayes-Classifier]] the distributions of p(x|Ck) and p(Ck) are discrete and the distributions are specified by probability distribution tables. In Gaussian/normal distribution p(x|Ck) is a continuous probability distribution.
![[Pasted image 20251017100047.png]]
In class-conditional Gaussian classifiers we assume the class conditional distribution p(x|Ck) is Gaussian.
If we can learn the class-conditional density p(x|Ck) through training we are able to predict the label for a datapoint x.
![[Pasted image 20251017100103.png]]
#### Covariance Matrix
µ is the centre of the gaussian distribution, ∑ decides the orientation 
![[Pasted image 20251017100115.png]]
Suppose we have two features “the hours a student spent on a class” and “marks received for the class”. These to features are not independent; they co-vary. In Naive Bayes we assumed features are independent within a class.
![[Pasted image 20251017100122.png]]
Now we can see how a class-conditional Gaussian classifier works. During prediction: given a datapoint x, we can compute p(x|Ck) since this is Gaussian and the mean vector and covariance matrix ∑ have been trained in the training stage. Also p(Ck) has been obtained during training. So we can use the [[Bayes Theorem]] to compute p(Ck|x).
![[Pasted image 20251017100258.png]]
If two class-conditional Gaussian p(x|C1) and p(x|C2) have different mean vectors µ1, µ2 but share a covariance matrix ∑, the decision boundary is a linear boundary.   

**Training:** To find p(Ck) count the training examples like in Naive Bayes. To find p(x|Ck) assume the classes share the same covariance matrix ∑. Note that the learning phase aims to obtain µ1 and µ2 and ∑ given the training data. Use the following formula: 
![[Pasted image 20251017100319.png]]
The shared covariance matrix is a weighted sum of S1 and S2 which in turn are covariance matrix estimated using the datapoints in the two classes. 
![[Pasted image 20251017100329.png]]

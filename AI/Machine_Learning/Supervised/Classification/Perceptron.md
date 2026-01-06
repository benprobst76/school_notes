The perceptron classifier is a discriminative model.
If the output is 1 it is classified to the positive class or -1 for the negative class
  // it is not inside the boundary 
  // adjust the border slightly 
Perceptron aims to put a decision boundary to minimize an error function know as perception  criterion shown above.

With the criterion determined to find the boundary a widely used optimization algorithm, stochastic gradient descent (SGD) is often applied to minimize errors which updates model parameters at each training data point. Such an algorithm is often called an online algorithm. 

The perceptron convergence theorem states that if there exists an exact solution I.e. if the training data is linearly separable then the perceptron learning algorithm is guaranteed to find an exact solution in a finite number of steps. If the data is not linearly separably the data will not converge. 

Perceptron is a one-layer neural network and was criticized in a book that was misinterpreted as demonstrating neural networks could only learn solutions to linearly separable problems.

Single-layer networks like perceptron has these limitations but multiple-layer networks can classify examples that are not linearly separable. 
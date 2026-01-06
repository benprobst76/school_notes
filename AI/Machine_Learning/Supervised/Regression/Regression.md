**Regression** is a type of [[Supervised-Machine-Learning]] where the goal is to predict a **continuous numerical value** based on input features. Unlike classification, which predicts discrete categories, regression models predict quantities that can take on any value within a given range. This makes regression suitable for tasks like forecasting, estimation, and understanding relationships between variables.
The process typically involves:
1.  **Training Data**: A dataset containing input features and their corresponding known continuous output values.
2.  **Learning Algorithm**: An algorithm that analyzes the training data to learn the underlying relationship between inputs and outputs.
3.  **Hypothesis/Model**: The output of the learning algorithm, which is a function (or model) that can take new, unseen input features and predict their continuous output values.
The learning algorithm's primary job is to find the optimal parameters (coefficients, weights, etc.) for this hypothesis function, such that the predicted outputs are as close as possible to the actual outputs in the training data, and ideally, generalize well to new data.
### Types of Regression Models
While the core goal remains the same, various regression models exist, each with different assumptions and complexities:

*  [[Constant-Regression]]: This is the simplest form of regression, where the model predicts a single constant value (e.g., the mean of the training outputs) for all inputs, regardless of the input features. It serves as a baseline and assumes no relationship between inputs and outputs.

*  [[Linear-Regression]]: A widely used model that assumes a linear relationship between the input features and the continuous output. It tries to find the best-fitting straight line (or hyperplane in higher dimensions) that minimizes the distance between the predicted and actual output values.

*  [[High-Order-Polynomial-Regression]]: An extension of linear regression where the relationship between the input features and the output is modeled as an $n$-th degree polynomial. This allows the model to capture non-linear relationships by introducing polynomial terms (e.g., $x^2, x^3$) of the input features. While more flexible than linear regression, it can be prone to overfitting if the polynomial degree is too high. 
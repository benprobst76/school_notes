Logistic Regression is a fundamental [[Classification]] algorithm, not a regression algorithm as its name might suggest. It is a **linear model** used primarily for **binary classification**—tasks where the output is one of two classes (e.g., Spam/Not Spam, Yes/No).
## Why Not Linear Regression for Classification?
If we use [[Linear-Regression]] for a classification problem, the model's output can be any real number. However, for classification, we need a probability that lies between 0 and 1. Logistic Regression solves this by passing the output of a linear equation through a "squashing" function, the **sigmoid function**.
## The Sigmoid (Logistic) Function
The sigmoid function takes any real-valued number and maps it to the range (0, 1).$$ \sigma(z) = \frac{1}{1 + e^{-z}} $$Here, `z` is the output of a linear model: $z = w^T x + b$. The output of the sigmoid function, $\sigma(z)$, is interpreted as the estimated probability that the output `y` is 1, given the input `x`.
$$ P(y=1 | x; w, b) = \sigma(w^T x + b) $$
![[Pasted image 20251016175736.png]]
## Decision Boundary
To make a concrete prediction, we set a threshold on the probability. The standard threshold is 0.5.
*   If $P(y=1|x) \ge 0.5$, predict class 1.
*   If $P(y=1|x) < 0.5$, predict class 0.
Because of the nature of the sigmoid function, $\sigma(z) \ge 0.5$ when $z \ge 0$. This means our decision boundary is the line where the linear part equals zero:
$$ w^T x + b = 0 $$
This is a linear decision boundary that separates the two classes.
## The Cost Function: Log Loss
We can't use the Mean Squared Error cost function from linear regression because it would result in a non-convex cost function with many local minima. Instead, Logistic Regression uses **Log Loss** (also known as Binary Cross-Entropy).
For a single training example, the cost is:
$$ \text{Cost}(h(x), y) = -y \log(h(x)) - (1-y) \log(1 - h(x)) $$
where $h(x) = \sigma(z)$ is the model's prediction.
* If the true class `y` is 1, the cost is $-\log(h(x))$. This cost is high if the model predicts a value close to 0.
* If the true class `y` is 0, the cost is $-\log(1 - h(x))$. This cost is high if the model predicts a value close to 1.
The total cost function `J(w,b)` for the entire dataset is the average of this cost over all `m` training examples:
$$ J(w,b) = -\frac{1}{m} \sum_{i=1}^{m} [y^{(i)} \log(h(x^{(i)})) + (1-y^{(i)}) \log(1 - h(x^{(i)}))] $$
## Training with Gradient Descent
The goal is to find the parameters `w` and `b` that minimize the cost function `J(w,b)`. This is done using an optimization algorithm like **Gradient Descent**. We repeatedly update the parameters in the opposite direction of the gradient of the cost function.

The partial derivatives of the cost function are surprisingly simple (thanks to the properties of the sigmoid function, where $\sigma'(z) = \sigma(z)(1-\sigma(z))$):
$$ \frac{\partial J}{\partial w_j} = \frac{1}{m} \sum_{i=1}^{m} (h(x^{(i)}) - y^{(i)}) x_j^{(i)} $$
$$ \frac{\partial J}{\partial b} = \frac{1}{m} \sum_{i=1}^{m} (h(x^{(i)}) - y^{(i)}) $$

The update rules are:
$$ w_j := w_j - \alpha \frac{\partial J}{\partial w_j} $$
$$ b := b - \alpha \frac{\partial J}{\partial b} $$
where $\alpha$ is the learning rate.
## Multiclass Classification
Logistic Regression can be extended to handle more than two classes:
1.  **One-vs-Rest (OvR):** Train K separate binary logistic regression classifiers, where each classifier is responsible for recognizing one of the K classes against all other classes.
2.  **Softmax Regression (Multinomial Logistic Regression):** A generalization that uses the **softmax function** instead of the sigmoid. The softmax function outputs a probability distribution over all K classes, ensuring the probabilities sum to 1.
## Regularization
To prevent overfitting, [[Regularization]] techniques like L1 and L2 can be added to the logistic regression cost function. This adds a penalty term based on the magnitude of the model parameters `w`.
 

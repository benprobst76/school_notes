Often used to control over fitting. It adds a penalty term to the error function in order to discourage the coefficients w from reaching large values.

### What is Overfitting and Why Regularize?
In machine learning, **overfitting** occurs when a model learns the training data too well, including its noise and random fluctuations, rather than the underlying patterns. An overfit model performs exceptionally well on the training data but poorly on new, unseen data because it has essentially memorized the training examples instead of generalizing from them. This often happens when models are too complex for the amount of training data available, leading to very large and specific coefficient values ($w$) that perfectly fit the training points but are not robust.

**Regularization** is a technique designed to prevent overfitting by making the model simpler and more generalizable. It does this by adding a penalty to the model's complexity during training.

### How Regularization Works: The Penalty Term
The core idea is to modify the standard error (or loss) function that a model tries to minimize. Instead of just minimizing the error between the model's predictions and the true values, we add a **penalty term** that grows larger as the model's complexity increases. This forces the learning algorithm to find a balance between fitting the training data well and keeping the model simple.

The most common way to define model complexity is through the magnitude of its coefficients ($w$). Large coefficients often indicate a complex model that is highly sensitive to small changes in input, making it prone to overfitting. By penalizing large coefficients, regularization encourages the model to use smaller, more stable weights.

Consider the error function with a regularization term:
$$ E(w) = \frac{1}{2} \sum_{n=1}^N{y(x_n,w)-t_n}^2 + \frac{\lambda}{2} ||w||^2 $$
*   The first part, $\frac{1}{2} \sum_{n=1}^N{y(x_n,w)-t_n}^2$, is the standard **sum of squared errors** (or loss function), which measures how well the model fits the training data.
*   The second part, $\frac{\lambda}{2} ||w||^2 =$, is the **regularization term**. It penalizes large values of the weights $w$.
### The Role of $\lambda$ (Lambda)
$\lambda$ (lambda) is the **regularization parameter** (also known as a hyperparameter). It controls the strength of the regularization:
*   **Small $\lambda$**: The penalty for large coefficients is small, so the model focuses more on minimizing the training error. This can lead to overfitting if $\lambda$ is too small or zero (no regularization).
*   **Large $\lambda$**: The penalty for large coefficients is significant, forcing the model to keep the coefficients small. This makes the model simpler and less prone to overfitting, but if $\lambda$ is too large, it can lead to ***underfitting*** (where the model is too simple and cannot capture the underlying patterns in the data).
### Effects of Regularization
![[Pasted image 20251022081631.png]]
As in the table of coefficients, as $\lambda$ increases, the magnitude of the coefficients generally decreases, leading to a smoother, less complex model.
![[Pasted image 20251022081043.png]]
Table of coefficients w* for M=9 polynomials with various values the regularization parameter $\lambda$. Note that $ln\lambda=-\infty$ corresponds to a model with no regularization, as the value of $\lambda$ increases the typical magnitude of the coefficients get smaller 

### Different Regularization Terms (L1 vs. L2)
There is a more general form of the equation which is: $$ E(w) = \frac{1}2\sum_{n=1}^N\{y(x_n,w)-t_n\}^2 + \frac{\lambda}{2} ||w||^q $$
The regularization term can be rewritten with more details:
$$ E(w) = \frac{1}2\sum_{n=1}^N\{y(x_n,w)-t_n\}^2 + \frac{\lambda}{2}\sum_{j=1}^{D}|w_j|^q$$
N is the number of training data points and D is the dimensionality of w.
The most common choices for $q$ are:
*   **$q=2$ (L2 Regularization / Ridge Regression)**:
    $$ \frac{\lambda}{2}\sum_{j=1}^{D}|w_j|^2 = \frac{\lambda}{2} ||w||_2^2 $$
    This is the form shown in the initial equation. L2 regularization penalizes the square of the magnitude of the coefficients. It tends to shrink the coefficients towards zero, but rarely makes them exactly zero. This means all features are generally kept in the model, but their influence is reduced.

*   **$q=1$ (L1 Regularization / Lasso Regression)**:
    $$ \frac{\lambda}{2}\sum_{j=1}^{D}|w_j|^1 = \frac{\lambda}{2} ||w||_1 $$
    L1 regularization penalizes the absolute value of the magnitude of the coefficients. A key property of L1 regularization is that it can lead to **sparse models**, meaning it tends to drive some coefficients exactly to zero. This effectively performs **feature selection**, as features with zero coefficients are excluded from the model.

![[Pasted image 20251022082356.png]]
### Regularization as Constrained Optimization
The regularization terms can also be viewed as a form of **constrained optimization**. Minimizing the error function with a regularization term is mathematically equivalent to minimizing the original sum of squared errors subject to a constraint on the magnitude of the weights.
For example, minimizing:
$$ E(w) = \frac{1}{2}\sum_{n=1}^N\{y(x_n,w)-t_n\}^2 + \frac{\lambda}{2}\sum_{j=1}^{D}|w_j|^q$$
is equivalent to minimizing:
$$\frac{1}{2}\sum_{n=1}^N\{y(x_n,w)-t_n\}^2$$
subject to the following constraint:
$$\sum_{j=1}^D|w_j|^q \le \eta$$
Here, $\eta$ is a constant that is inversely related to $\lambda$. Larger $\lambda$ corresponds to a tighter constraint (smaller $\eta$), forcing the weights to be smaller. **Lagrange Multipliers** can be used to convert between these two forms (the unconstrained optimization with a penalty term and the constrained optimization).
### Choosing the Right Regularizer
![[Pasted image 20251022082608.png]]
One of the above regularizers (L1 or L2) can be used, or even a combination (Elastic Net). The choice of the regularization parameter $\lambda$ (and whether to use L1, L2, or both) is crucial. This is typically done using a **validation set** (or cross-validation). By training the model with different values of $\lambda$ and evaluating its performance on the validation set, you can find the optimal $\lambda$ that provides the best balance between bias and variance, leading to good generalization performance.
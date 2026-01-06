The Naïve Bayes Classifier is a probabilistic machine learning model used for classification tasks. It is a **Generative Model**, meaning it models the joint probability $p(\mathbf{x}, C_k)$ of the input features $\mathbf{x}$ and the class labels $C_k$.
## The Naïve Bayes Assumption
The "Naïve" part of the name comes from the strong (and often unrealistic) independence assumption it makes.
**Assumption:** Conditioned on the class $C_k$, all features (variables) in the input vector $\mathbf{x} = [x_1, x_2, \dots, x_n]$ are **mutually independent**.
Mathematically, this means:
$$
 P(\mathbf{x} | C_k) = P(x_1, x_2, \dots, x_n | C_k) = \prod_{i=1}^n P(x_i | C_k)
$$
 While this assumption rarely holds true in real-world data (e.g., in text, words are often correlated), the classifier often performs surprisingly well in practice.

## Mathematical Formulation

To make a prediction, we want to find the class $C_k$ that maximizes the posterior probability $P(C_k | \mathbf{x})$. Using **Bayes' Theorem**:

$$
 P(C_k | \mathbf{x}) = \frac{P(\mathbf{x} | C_k) P(C_k)}{P(\mathbf{x})}
$$

Substituting the independence assumption:

$$
 P(C_k | \mathbf{x}) = \frac{P(C_k) \prod_{i=1}^n P(x_i | C_k)}{P(\mathbf{x})}
$$

Since the denominator $P(\mathbf{x})$ is constant for all classes $k$, we can ignore it for prediction purposes. We simply choose the class that maximizes the numerator:

$$
 \hat{y} = \underset{k}{\operatorname{argmax}} \left( P(C_k) \prod_{i=1}^n P(x_i | C_k) \right)
$$

### Components to Estimate
To use this model, we simply need to estimate two types of probabilities from the training data:
1.  **Class Priors $P(C_k)$:** The probability of each class occurring in the dataset.
2.  **Feature Likelihoods $P(x_i | C_k)$:** The probability of feature $i$ taking a specific value given that the class is $k$.

## Example: Predicting Play vs. Not Play

Consider a dataset where we want to predict if we should play tennis ($C_k \in \{ \text{Yes, No} \}$) based on weather features: **Outlook, Temperature, Humidity, Wind**.

### Step 1: Training (Estimating Probabilities)
From the training data, we build probability distribution tables (Likelihoods).
![[Pasted image 20251017095956.png]]

### Step 2: Prediction
**Query Instance:**
*   Outlook: Sunny
*   Temperature: Cool
*   Humidity: High
*   Wind: Strong

We need to compare $P(\text{No} | \mathbf{x})$ and $P(\text{Yes} | \mathbf{x})$.

**1. Calculate for Class "No":**
$$
 \begin{aligned}
 P(\text{No} | \mathbf{x}) &\propto P(\text{No}) \times P(\text{Sunny} | \text{No}) \times P(\text{Cool} | \text{No}) \times P(\text{High} | \text{No}) \times P(\text{Strong} | \text{No}) \\
 &\propto P(\text{No}) \times P(x_1|\text{No}) \times P(x_2|\text{No}) \times P(x_3|\text{No}) \times P(x_4|\text{No})
 \end{aligned}
$$

**2. Calculate for Class "Yes":**
$$
 \begin{aligned}
 P(\text{Yes} | \mathbf{x}) &\propto P(\text{Yes}) \times P(\text{Sunny} | \text{Yes}) \times P(\text{Cool} | \text{Yes}) \times P(\text{High} | \text{Yes}) \times P(\text{Strong} | \text{Yes})
 \end{aligned}
$$

![[Pasted image 20251017100013.png]]

**3. Decision:**
Compare the calculated scores. Whichever class yields the higher value is the predicted label.

![[Pasted image 20251017100029.png]]

## Pros and Cons

**Pros:**
*   **Fast and Efficient:** Training is simply counting frequencies. Prediction is very fast.
*   **Works well with small data:** Converges quicker than discriminative models like Logistic Regression if the independence assumption holds.
*   **Handles high dimensions:** Effective for text classification (e.g., Spam filtering).

**Cons:**
*   **Independence Assumption:** If features are highly correlated, the prediction confidence might be inaccurate (often too confident).
*   **Zero Frequency Problem:** If a categorical variable has a category in the test set that was not observed in the training set, the probability will be 0. (Solved using smoothing, e.g., Laplace Smoothing).
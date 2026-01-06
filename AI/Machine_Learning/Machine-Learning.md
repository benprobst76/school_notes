> Arthur Samuel (1959)
> Field of study that gives computers the ability to learn without being explicitly programmed.

Instead of writing a program by hand, we can let machines learn from data. Giving instructions/rules to a computer by writing a program is far from enough in many applications where the boundaries between classes can be complicated and require decisions that combine multiple features.

**Examples:** Recognizing patterns (Image recognition, speech recognition), generating patterns (generating a story or song), recognizing anomalies (unusual sequence of transactions, or topics on social media), prediction (future stock prices, self-driving cars).

We need to collect many examples, each composed of input information and the corresponding output. A machine learning algorithm then takes these examples and produces a program/model that learns to predict the output given an input.

## Learning Paradigms
There are three main paradigms for machine learning:
### 1. Supervised Learning
In [[Supervised-Machine-Learning|Supervised Learning]], the model learns from labeled data, meaning each data point is tagged with a correct output. The goal is to learn a mapping function that can predict the output for new, unseen data.
**Key Tasks:**
*   **[[Classification]]**: The output variable is a category. The goal is to predict the class label of a new instance.
    *   **Models:**
        *   [[Logistic-Regression]]
        *   [[K-Nearest-Neighbour]]
        *   [[Support-Vector-Machine]]
        *   [[Decision-Trees]]
        *   [[Naïve-Bayes-Classifier]]
        *   [[Perceptron]]
*   **[[Regression]]**: The output variable is a continuous value. The goal is to predict a real-valued output.
    *   **Models:**
        *   [[Linear-Regression]]
        *   [[High-Order-Polynomial-Regression]]
*   **[[Time-Series-Prediction]]**: A special case of regression where the data points are indexed in time order.
    *   **Models:**
        *   [[Markov-Models]]
        *   [[Hidden-Markov-Models]]

### 2. Unsupervised Learning
In [[Unsupervised-Machine-Learning|Unsupervised Learning]], the model works with unlabeled data and tries to find patterns and structure on its own.
**Key Tasks:**
*   **[[Clustering]]**: The goal is to group a set of objects in such a way that objects in the same group (or cluster) are more similar to each other than to those in other groups.
    *   **Algorithms:**
        *   [[K-Means-Clustering]]
        *   [[Hierarchical-Clustering]]
        *   [[Mixture-of-Gaussians]] (often using the [[EM-Algorithm]])
*   **[[Dimensionality-Reduction]]**: The goal is to reduce the number of random variables under consideration by obtaining a set of principal variables.
### 3. Reinforcement Learning
In [[Reinforcement-Learning|Reinforcement Learning]], a model (or "agent") learns by interacting with an environment. The agent receives rewards or penalties for the actions it performs, and its goal is to learn a policy that maximizes the cumulative reward.

---

## Model Categories
Machine learning models can also be categorized based on their underlying structure and probabilistic approach.
### Parametric vs. Non-parametric Methods
* **Parametric Methods**: These models, also known as model-based methods, summarize data with a fixed number of parameters, regardless of the training data size. They make assumptions about the data's distribution (e.g., that it's linear).
    *   **Examples**: [[Linear-Regression]], [[Logistic-Regression]], and simple [[Neurons]].
* **Non-parametric Methods**: Also called instance-based or memory-based learning. In these models, the number of parameters is not fixed and can grow with the number of training examples. They make fewer assumptions about the data distribution.
    *   **Examples**: [[K-Nearest-Neighbour]] (where the "parameters" are the entire training set), [[Support-Vector-Machine]], and [[Decision-Trees]].

### Discriminative vs. Generative Models
This distinction is about how a model learns the boundaries between classes.
* **Discriminative Models**: These models learn the decision boundary between classes directly. They model the conditional probability `p(y|x)`. Given an input `x`, they directly predict the class `y`.
    *   **Examples**: [[Logistic-Regression]], [[Support-Vector-Machine]], [[Perceptron]].
* **Generative Models**: These models learn the distribution of individual classes. They model the joint probability `p(x, y)` or the conditional probability `p(x|y)` and the prior `p(y)`. By learning how the data for each class is generated, they can then use [[Bayes Theorem]] to find the posterior `p(y|x)`. Because they model the data distribution, they can also be used to generate new data points.
    *   **Examples**: [[Naïve-Bayes-Classifier]], [[Gaussian-Classifier]], [[Hidden-Markov-Models]], [[Mixture-of-Gaussians]].

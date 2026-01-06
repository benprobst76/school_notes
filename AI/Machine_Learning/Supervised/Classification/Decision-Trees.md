A decision tree is a non-parametric supervised learning method used for both [[Classification]] and [[Regression]]. It creates a model that predicts the value of a target variable by learning simple decision rules inferred from the data features. Each internal node represents a test on a feature, each branch represents the outcome of the test, and each leaf node contains the final prediction (a class label or a continuous value).

![[Pasted image 20251029141537.png]]

## How Decision Trees are Built
Decision tree algorithms almost always use a **greedy approach**. This means they make the best possible split at each step and do not go back to change previous splits. Finding the globally optimal tree is computationally intractable (NP-hard).

The general algorithm (e.g., ID3) is as follows:
1.  Start with all training data at the root node.
2.  Find the best feature and split-point that divides the data into the "purest" possible child nodes. The "best" split is the one that maximizes the **Information Gain**.
3.  Create a child node for each outcome of the split and move the corresponding data points into it.
4.  Repeat this process recursively for each child node.
5.  Stop splitting when a node is "pure" (all its data belongs to one class), or when a pre-defined stopping criterion is met (e.g., maximum depth is reached).

## Splitting Criteria: Impurity and Information Gain=
The core of the algorithm is deciding how to split the data. This is done by measuring the **impurity** of a node. A node is pure if all its samples belong to the same class. The goal is to find a split that reduces impurity the most. This reduction is called **Information Gain**.

**Information Gain** = Impurity(parent) - Weighted Average Impurity(children)
$$ \text{Gain}(S, A) = \text{Impurity}(S) - \sum_{v \in \text{Values}(A)} \frac{|S_v|}{|S|} \text{Impurity}(S_v) $$

There are three common measures of impurity:
### 1. Gini Impurity
Used by the **CART** algorithm. It measures the probability of misclassifying a randomly chosen element if it were randomly labeled according to the class distribution in the node.
$$ \text{Gini}(S) = 1 - \sum_{i=1}^{k} (p_i)^2 $$
*   `p_i` is the probability of class `i` in the node.
*   Gini = 0 for a pure node.
*   Gini = 0.5 for a binary classification node with a 50/50 split.
### 2. Entropy
Used by the **ID3** and **C4.5** algorithms. Entropy is a measure of uncertainty or disorder.
$$ \text{Entropy}(S) = - \sum_{i=1}^{k} p_i \log_2(p_i) $$
*   Entropy = 0 for a pure node.
*   Entropy = 1 for a binary classification node with a 50/50 split.

### 3. Misclassification Error
The simplest impurity measure. It's the proportion of samples that would be misclassified if the node was labeled with its majority class.
$$ \text{Error}(S) = 1 - \max(p_i) $$
In practice, Gini Impurity and Entropy are preferred because they are more sensitive to changes in the node's probability distribution, leading to better splits.

## Decision Tree Variants
Different algorithms use different impurity measures and have different capabilities.

*   **ID3 (Iterative Dichotomiser 3):**
    *   Uses **Entropy** and Information Gain.
    *   Cannot handle numerical features or missing values.
    *   Prone to overfitting.

*   **C4.5 (Successor to ID3):**
    *   Improves on ID3 by using **Gain Ratio** (which normalizes Information Gain) to prevent bias towards features with many unique values.
    *   Can handle numerical features and missing values.
    *   Includes **post-pruning** to combat overfitting.

*   **CART (Classification and Regression Trees):**
    *   Uses **Gini Impurity** for classification and Mean Squared Error for regression.
    *   Creates only **binary splits**.
    *   The most common algorithm used in modern libraries (e.g., Scikit-learn).

## Preventing Overfitting: Pruning
Because of their greedy nature, decision trees are very prone to overfitting the training data. **Pruning** is a technique used to make the model simpler and more generalizable.
1.  **Pre-pruning (Early Stopping):** Stop growing the tree early by setting constraints, such as:
    *   `max_depth`: Maximum depth of the tree.
    *   `min_samples_leaf`: Minimum number of samples a leaf node must have.
    *   `min_samples_split`: Minimum number of samples a node must have to be considered for splitting.
2.  **Post-pruning:** Grow the tree to its full depth, then remove branches that provide little predictive power on a validation set. This is often more effective than pre-pruning.

## Pros and Cons
### Pros
*   **Easy to interpret and visualize.**
*   Requires little data preparation (no need for feature scaling).
*   Can handle both numerical and categorical data.
*   Non-parametric: makes no assumptions about the data distribution.
### Cons
*   **Prone to overfitting.**
*   Can be unstable: small variations in the data can result in a completely different tree.
*   Greedy algorithms may not find the globally optimal tree.
*   Can be biased if some classes dominate.
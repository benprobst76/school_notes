
This directory serves as a comprehensive collection of notes on Artificial Intelligence, with a primary focus on Machine Learning and Deep Learning. The notes cover fundamental concepts, algorithms, and practical examples within these domains. These notes are maintained in an Obsidian vault.

## Directory Overview

This directory is organized to provide a structured learning path through various AI topics. It contains detailed explanations, definitions, and some code examples to illustrate key concepts. The structure generally follows a convention where folder names use underscores (`_`) and file names use hyphens (`-`). Notes can be cross-referenced using Obsidian's `[[link]]` syntax.

## Key Files

### Assignments
* **[[Assignment-3]]**: Notes or solution for the third assignment.
* **[[K-Medians & K-Medoids]]**: Covers clustering algorithms using medians or medoids for robustness.
* **[[Training to Recognize Handwritten Digits]]**: This file presents a practical case study on training classifiers for handwritten digit recognition. It includes MATLAB code snippets for implementing and testing [[Gaussian-Classifier]] and [[Naïve-Bayes-Classifier]] classifiers, along with a performance comparison of these methods.

### Deep Learning
* **[[Deep-Learning]]**: Provides an introduction to Deep Learning, outlining its core principles, applications in areas like natural language processing and image recognition, and discussing the current challenges and gaps between human and artificial intelligence.
* **[[Improving-Model-Performance]]**: Discusses techniques to enhance model accuracy and generalization.
* **Neural Networks**:
    * **[[Attention-Models]]**: Covers attention mechanisms in neural networks.
    * **[[Autoencoders]]**: Explains autoencoder architectures for unsupervised learning.
    * **[[Convolutional]]**: Details Convolutional Neural Networks (CNNs) for processing grid-like data such as images.
    * **[[Feed-Forward]]**: Describes standard feed-forward neural networks.
    * **[[Neurons]]**: Explains the fundamental unit of neural networks.
    * **[[Recurrent]]**: Covers Recurrent Neural Networks (RNNs) for sequential data.

### Exam
* **[[Question-Bank]]**: A collection of questions for exam preparation.

### Machine Learning
* **[[Machine-Learning]]**: This file introduces the foundational concepts of Machine Learning, including its definition, examples of applications, and an overview of different learning paradigms such as [[Supervised-Machine-Learning]], [[Unsupervised-Machine-Learning]], and [[Reinforcement-Learning]]. It also delves into topics like [[Cross-Validation]], parametric vs. non-parametric methods, the [[Perceptron]] algorithm, and the distinction between discriminative and generative models.
* **[[Reinforcement-Learning]]**: Covers learning agents that take actions in an environment to maximize cumulative reward.

#### Supervised Learning
* **[[Supervised-Machine-Learning]]**: Focuses on Supervised Machine Learning, detailing its process from data collection to model testing. It highlights key tasks within supervised learning, such as [[Classification]], [[Regression]], and [[Time-Series-Prediction]].
* **Classification**:
    * **[[Classification]]**: General overview of classification tasks.
    * **[[Decision-Trees]]**: Hierarchical models for classification and regression.
    * **[[Gaussian-Classifier]]**: Probabilistic classification based on Gaussian distributions.
    * **[[K-Nearest-Neighbour]]**: Instance-based learning algorithm.
    * **[[Linear-Classifier]]**: Classifiers using linear decision boundaries.
    * **[[Logistic-Regression]]**: Probabilistic model for binary classification.
    * **[[Naïve-Bayes-Classifier]]**: Probabilistic classifier based on Bayes' theorem with independence assumptions.
    * **[[Perceptron]]**: A simple linear binary classifier.
* **Kernel Machines**:
    * **[[Kernel-Method]]**: Introduction to kernel methods.
    * **[[Support-Vector-Machine]]**: SVMs for classification and regression.
* **Regression**:
    * **[[Constant-Regression]]**: Baseline regression models.
    * **[[High-Order-Polynomial-Regression]]**: Fitting polynomial curves to data.
    * **[[Linear-Regression]]**: Modeling the relationship between scalar response and explanatory variables.
    * **[[Regression]]**: Overview of regression analysis.
    * **[[Regularization]]**: Techniques like Lasso and Ridge to prevent overfitting.
* **Time Series Prediction**:
    * **[[Hidden-Markov-Models]]**: Statistical Markov models with unobserved (hidden) states.
    * **[[Markov-Models]]**: Stochastic models for randomly changing systems.
    * **[[Time-Series-Prediction]]**: Techniques for predicting future values based on previously observed values.

#### Unsupervised Learning
* **[[Unsupervised-Machine-Learning]]**: Explores Unsupervised Machine Learning, explaining its goal of discovering hidden patterns and structures in data without explicit labels. It covers concepts like Auto-Regressive Learning and [[Clustering]].
* **[[Dimensionality-Reduction]]**: Techniques to reduce the number of random variables under consideration.
* **Clustering**:
    * **[[Clustering]]**: Overview of clustering methods.
    * **[[EM-Algorithm]]**: Expectation-Maximization algorithm for finding maximum likelihood estimates.
    * **[[Hierarchical-Clustering]]**: Method of cluster analysis which builds a hierarchy of clusters.
    * **[[K-Means-Clustering]]**: Partitioning observations into k clusters.
    * **[[Mixture-of-Gaussians]]**: Probabilistic model assuming all data points are generated from a mixture of a finite number of Gaussian distributions.

#### Validation
* **[[Cross-Validation]]**: Resampling procedure used to evaluate machine learning models.

### Configuration
*  **`Table of Contents.base`**: This file appears to be a configuration file, likely used by a note-taking application to generate a dynamic table of contents or organize the notes based on specific criteria.

### Guidellines
Any math should be returned as latex that can be easily copy and pasted into a $$ $$
block. When math spans multiple lines use the \begin{aligned} and \end{aligned} latex functions. Any code should be returned as a code block 
```
```
Without any number lines. Notes created should be clear and explanatory.  When asked to reformat notes, rewrite them so that they are in proper markdown format and are optimized to be used in obsidian. Do not include a line break after paragraphs, headers or sections. Also when asked to reformat include extra details or examples for concepts if it helps makes the notes clearer and easier to understand. 
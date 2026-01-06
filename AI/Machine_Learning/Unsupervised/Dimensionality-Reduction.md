Dimensionality Reduction is the process of reducing the number of features (or dimensions) in a dataset. It is a key technique in [[Unsupervised-Machine-Learning]] and data preprocessing.
## Why Reduce Dimensions? The Curse of Dimensionality
As the number of features in a dataset grows, the amount of data needed to generalize accurately grows exponentially. This phenomenon is known as the **curse of dimensionality**. In high-dimensional spaces, data points become very sparse, making it difficult for algorithms to find meaningful patterns.
**Goals of Dimensionality Reduction:**
*   **Reduce computational cost:** Fewer dimensions mean faster training times for machine learning models.
*   **Improve model performance:** By removing irrelevant or redundant features (noise), the model can often generalize better.
*   **Data Visualization:** Visualizing data in 2D or 3D to gain insights.
*   **Reduce storage space.**	
	![[Pasted image 20251022101647.png]]

## Types of Dimensionality Reduction
There are two main approaches:
1.  **Feature Selection:** This involves selecting a subset of the original features and discarding the rest. Methods can be categorized as filter, wrapper, or embedded methods.
2.  **Feature Extraction:** This involves creating a new, smaller set of features by combining the original features. These new features are projections of the original data onto a lower-dimensional space.
---
## Feature Extraction Techniques
### 1. Principal Component Analysis (PCA)
PCA is the most common linear dimensionality reduction technique. It transforms the data into a new coordinate system such that the greatest variances of the data come to lie on the first coordinates (called principal components).

> **VIEW #1 (Maximize Variance):** PCA can be defined as the orthogonal projection of the data onto a lower-dimensional linear space, known as the principal subspace, such that the variance of the projected data is maximized.

> **VIEW #2 (Minimize Projection Error):** Equivalently, it can be defined as the linear projection that minimizes the average projection cost, defined as the mean squared distance between the data points and their projections.
#### PCA Algorithm Steps:
1.  **Standardize the data:** Subtract the mean from each feature to center the data around the origin.
    *   Given a dataset with features $x^{(1)}$ and $x^{(2)}$:
        ![[Pasted image 20251022105040.png]]
        ![[Pasted image 20251022105130.png]]  
    * Mean-adjusted data:
        ![[Pasted image 20251022105147.png]]
2.  **Calculate the Covariance Matrix:** This matrix shows the covariance between each pair of features.
    $$cov=
       \begin{bmatrix}
        0.61655556 & 0.61544444 \\
        0.61544444 & 0.71655556
        \end{bmatrix}$$
3.  **Compute [[Eigenvalues & Eigenvectors]]:** Calculate the eigenvectors and eigenvalues of the covariance matrix. The eigenvectors represent the principal components (the directions of maximum variance), and the eigenvalues represent the magnitude of the variance along those components.
    $$\begin{aligned}
    & \lambda_1 = 1.28402771, \space v_1=\begin{pmatrix}0.677873399\\0.735178956\end{pmatrix} \\
    & \lambda_2 = 0.490833989, \space v_2=\begin{pmatrix}-0.735178956\\0.677873399\end{pmatrix} \\
    \end{aligned}$$
4.  **Select Principal Components:** Sort the eigenvectors by their corresponding eigenvalues in descending order. To reduce dimensionality from D to M, select the top M eigenvectors. These are your new basis vectors.
    ![[Pasted image 20251022110424.png]]
5.  **Project the Data:** Transform the original data onto the new subspace defined by the selected principal components.
    *   `TransformedData = MeanAdjustedData × BasisOfNewSpace`
    *   Projected data in the new 1D space:
        ![[Pasted image 20251022111259.png]]

#### Reconstructing Data
You can transform the reduced data back to the original space, but there will be some information loss if you used fewer components than the original number of dimensions.
*   $ReconstructedMeanAdjustedData = TransformedData\space × \space BasisOfNewSpace^T$
*   `ReconstructedOriginalData = ReconstructedMeanAdjustedData + OriginalMean`
*   Reconstruction from 1 principal component:
    ![[Pasted image 20251022112107.png]]
*   This is useful for data compression, as seen in image reconstruction:
    ![[Pasted image 20251022112224.png]]

### 2. Linear Discriminant Analysis (LDA)
Unlike PCA, LDA is a **supervised** dimensionality reduction technique. Its primary goal is to find a feature subspace that **maximizes the separability between classes**. It projects the data in a way that makes it easiest to classify. It's often used as a preprocessing step for classification tasks.

### 3. t-SNE (t-Distributed Stochastic Neighbor Embedding)
t-SNE is a **non-linear** technique used primarily for **data visualization**. It is exceptionally good at revealing underlying structure in high-dimensional data, such as clusters.

It works by modeling the similarity between high-dimensional points as a probability distribution and then finding a low-dimensional (2D or 3D) embedding that creates a similar probability distribution. While powerful for visualization, it's computationally intensive and the resulting cluster sizes and distances between clusters may not be meaningful.

### 4. Autoencoders
Autoencoders are a **non-linear** technique based on neural networks. An autoencoder consists of two parts:
*   An **encoder** that compresses the input data into a low-dimensional latent representation (the "bottleneck").
*   A **decoder** that reconstructs the original data from this latent representation.

The network is trained to minimize the reconstruction error. After training, the encoder part can be used on its own to transform data into the low-dimensional space.


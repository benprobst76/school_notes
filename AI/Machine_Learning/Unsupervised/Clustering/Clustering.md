Clustering is a fundamental task in [[Unsupervised-Machine-Learning]], meaning it operates on data that does not require explicit labels. The primary objective of clustering is to partition a set of data points into groups (clusters) such that data points within the same group are more similar to each other than to those in other groups.

## Core Concepts

### Goal
The main goal is to group data cases into a finite number of clusters. Ideally, within each cluster, all cases share very similar input characteristics.
*   **Inputs**: Can be continuous (e.g., height, weight) or categorical (e.g., color, genre).
*   **Prototypes**: Clustering often involves identifying a prototype to represent each group, such as the centroid (mean) of a cluster.

### Distance Measures
All clustering approaches require a metric to quantify the similarity or dissimilarity between data points. A common choice is the **Euclidean distance**. For two points $\mathbf{x}$ and $\mathbf{y}$ in an $n$-dimensional space, the Euclidean distance is defined as:
$$ d(\mathbf{x}, \mathbf{y}) = \sqrt{\sum_{i=1}^{n} (x_i - y_i)^2} $$
Other metrics include Manhattan distance, Cosine similarity, etc., depending on the data type.

## Approaches to Clustering

There are various methodologies for defining and finding clusters, often categorized by how the clusters are formed.

### 1. Partitioning Methods (Fixed Number of Clusters)
These methods require the user to specify the number of clusters ($K$) beforehand. The algorithm then iteratively reassigns data points to clusters to optimize a criterion.
*   **Example**: [[K-Means-Clustering]] partitions data into $K$ distinct clusters by minimizing the variance within each cluster.

### 2. [[Hierarchical-Clustering]]
Hierarchical methods build a tree of clusters (a dendrogram). They do not require pre-specifying the number of clusters. This category is split into two main types:

#### Agglomerative Clustering (Bottom-Up)
Agglomerative clustering is a "bottom-up" approach.
*   **Initialization**: Treat each data point as a single cluster. Thus, if you have $N$ data points, you start with $N$ clusters.
*   **Process**: At each step, merge the two clusters that are closest to each other based on a defined linkage criterion (e.g., single linkage, complete linkage, average linkage).
*   **Result**: This repeats until all clusters are merged into one single cluster containing all data points.

#### Divisive Clustering (Top-Down)
Divisive clustering is a "top-down" approach.
*   **Initialization**: Start with all data points belonging to one single giant cluster.
*   **Process**: At each step, split a cluster into two smaller clusters. This usually involves selecting the cluster with the highest variance (or "widest" diameter) and partitioning it to maximize separation.
*   **Result**: This repeats until each cluster contains only a single data point.

### 3. Probabilistic Methods
These assume that data points are generated from a mixture of underlying probability distributions.
*   **Example**: [[Mixture-of-Gaussians]] uses the [[EM-Algorithm]] to assign soft probabilities of a point belonging to a cluster rather than hard assignments.

## Applications
*   **News Aggregation**: Grouping emerging news stories or tweets into topics.
*   **Customer Segmentation**: Grouping customers based on purchasing behavior for targeted marketing.
*   **Image Compression**: Reducing the number of colors in an image by grouping similar colors.


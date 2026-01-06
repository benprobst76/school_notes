Hierarchical Clustering is a method of [[Clustering|cluster analysis]] that seeks to build a hierarchy of clusters. Unlike methods like [[K-Means-Clustering]], it does not require the number of clusters to be specified beforehand. The result is a tree-based representation of the data points, called a **dendrogram**.
## The Dendrogram
The primary output of hierarchical clustering is a dendrogram, which graphically represents the nested clustering structure. The y-axis of the dendrogram represents the distance or dissimilarity between clusters. By cutting the dendrogram at a certain height, you can obtain a specific number of clusters.
![[Pasted image 20251022092033.png]]
*A dendrogram shows how clusters are merged (or split) at different levels of similarity.*

There are two main strategies for hierarchical clustering:
### 1. Agglomerative Clustering (Bottom-Up)
This is the more common approach. It starts with each data point in its own cluster and then successively merges the most similar pairs of clusters until only a single cluster containing all data points remains.
**The algorithm proceeds as follows:**
1.  Assign each data point to its own cluster.
2.  Compute the proximity (distance) between all pairs of clusters.
3.  Merge the two closest clusters into a new cluster.
4.  Recompute the proximity between the new cluster and all other clusters.
5.  Repeat steps 3 and 4 until only one cluster is left.
#### Linkage Criteria
A key component of agglomerative clustering is the **linkage criterion**, which defines how the distance between two clusters is measured. The choice of linkage criterion can significantly affect the final result.
*   **Single Linkage (MIN):** The distance between two clusters is the distance between the two closest points in the different clusters. This can lead to a "chaining" effect where clusters are merged if just one pair of points is close, which can result in long, stringy clusters.
*   **Complete Linkage (MAX):** The distance between two clusters is the distance between the two farthest points in the different clusters. This tends to produce more compact, spherical clusters.
*   **Average Linkage:** The distance between two clusters is the average distance between every pair of points in the two clusters. It's a compromise between the sensitivity of single linkage and the compactness of complete linkage.
*   **Ward's Method:** The distance is the increase in the total within-cluster variance that would result from merging the two clusters. It aims to merge clusters that lead to the minimum increase in variance, often resulting in compact, equally sized clusters.
### 2. Divisive Clustering (Top-Down)
This approach is the opposite of agglomerative clustering. It starts with all data points in a single cluster and, at each step, splits the least coherent cluster into two. The process continues until every data point is in its own cluster.

Divisive algorithms are computationally more expensive (as they need to check all possible splits at each step) and are less commonly used than agglomerative methods.

## Advantages and Disadvantages
### Advantages
*   **No pre-specified number of clusters:** The number of clusters can be chosen by inspecting the dendrogram.
*   **Visual and interpretable:** The dendrogram provides a clear visualization of how the data is structured.
*   **Captures nested structures:** It can reveal hierarchies in the data that might be missed by other algorithms.
### Disadvantages
*   **Computationally expensive:** The time complexity is typically at least O(n^2 log n) or O(n^3) for most agglomerative methods, making them unsuitable for very large datasets.
*   **Greedy approach:** The decisions made at each step (to merge or split) are final and cannot be undone, which can lead to suboptimal results.
*   **Sensitivity to linkage criteria:** The choice of linkage method and distance metric can produce very different results.  
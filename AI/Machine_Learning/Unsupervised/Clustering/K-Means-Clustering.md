For a pre-defined number of clusters K we first randomly initialize a centre for each cluster. And then alternate between two steps:
- E step: For all data points assign each to the cluster whose centre is closest to this data point
- M step: Update each clusters centre to be the mean of all points assigned to that cluster
To determine the value for K we can just try with different K values and select the best (cross-validation). The best is determined by comparing the total variation within the cluster. The K that results in the greatest reduction in variation (not the lowest total variation) is the best. This is called the elbow in the plot 
For K = 2 we can partition the data into two with a linear line.
Example with K = 2:
![[Pasted image 20251008100236.png]]
In general, assume we have K cluster, and each cluster has a centre (a.k.a. prototype) $μ_k$ , where $k ∊ 1, ..., K$.
For each data point $x_n$, we introduce a set of binary indicator variables $r_{nk} ∈ \{0, 1\}$, describing which of the K clusters the data point $x_n$ is assigned to, so that if the data point $x_n$ is assigned to  cluster k then $r_{nk} = 1$, but $r_{nj} = 0$ for all $j ≠ k$. 
**The goal of K-means:** find an assignment of data that points to clusters, as well as a set of centres $\{μ_k\}$ (each cluster has a centre),  such that the sum of the squared Euclidean distances of each data point to its closest cluster centre $μ_k$ is a minimum.  $$ J = \sum_{n=1}^{N} \sum_{k=1}^{K}r_{nk}||x_n - \mu_k||^2$$
Where N is the number of data points. K-means minimizes the above error function by finding $\{\mu_k\}$ and $\{r_{nk}\}$

Optimizing $r_{nk}$: we observe that the terms involving different n are independent, so we can optimize for each n separately, by choosing $r_{nk}$ to be 1 for whichever value of k gives the minimum value of $||x_𝑛 − u_𝑘||^2$. $$r_{nk} = \begin{cases}
1 & \text{if } k = \arg\min_j \|\mathbf{x}_n - \boldsymbol{\mu}_j\|^2 \\
0 & \text{otherwise.}
\end{cases} $$

I.e, assign each point to the cluster whose centre is closest to this point. 

Optimizing $μ_k$ with $r_{nk}$ fixed: set derivative of J (with regard to $μ_k$ ) to be zero: $$ 2\sum_{n=1}^N r_{nk}(x_n - \mu_k) = 0 $$
we get: $$ \mu_k = \dfrac{\sum_n r_{nk}x_n}{\sum_nr_{nk}}$$
That is, “set $μ_k$ to the mean of all points assigned to cluster k”. For K  clusters, we got K means, which is where the name “K-means” comes  from :). And now we also know why a centre is a mean (because K-means uses the squared Euclidean distance). 

Formally k-means algorithm can be written with the following equations in two steps:
- E step: Assign each datapoint to the cluster whose centre is closest to that data point: $$r_{nk} = \begin{cases}
1 & \text{if } k = \arg\min_j \|\mathbf{x}_n - \boldsymbol{\mu}_j\|^2 \\
0 & \text{otherwise.}
\end{cases} $$
- M step: Update each clusters centre to be the mean of all points assigned to that cluster: $$  \mu_k = \dfrac{\sum_n r_{nk}x_n}{\sum_nr_{nk}} $$
Since the initial centre of the clusters are chosen at random we can end up with a poor result. So we need to run the algorithm multiple times with different random centre points for K clusters and compare the variance. One strategy is to pick the centres for K to match up directly with a datapoint(The centre of a cluster is a datapoint).

You can set first $\mu_1$ randomly and iteratively set other $\mu_i$ to be furthest from the set of $\{\mu_k\}$ you have already initialized. A furthest first strategy.
- If there is a tie add points to the smaller cluster first
We have used the squard Euclidean distance but we can also use different distance functions like this one: $$ J = \sum_{n=1}^{N} \sum_{k=1}^{K}r_{nk}||x_n - \mu_k||^2$$
In gerneral if you use different distances the assignment step E is still the same, just assign each point to the cluster whose centre is closest to this point. But if you use some strange distances updating the cluster centres in step M might be hard .

---
We can use a tree data structure to speed up the algorithm so that nearby points are in the same subtree.  
To avoid a local minima use random restarts; spilt and merge clusters.
### K-Medians
In the assignment E step, assign each point to the cluster whose centre is closest to this point. In the M step for all points assigned to cluster k just take the median along each dimensions of features; we get the centre of cluster k
### K-Medoids
Update the new cluster centre to one of the data points assigned to that cluster, to minimize a predefined distance between datapoints in that cluster and the selected centre (e.g., squared Euclidean). 
- For k-medoids we have to try every possible point. Computationally expensive. 
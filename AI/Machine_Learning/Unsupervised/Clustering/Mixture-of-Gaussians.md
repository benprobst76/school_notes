In [[K-Means-Clustering]] it assigns a data point to one of the K clusters known as 1-of-K coding schema. But we can allow a data point to belong to multiple clusters with some probability like a soft assignment.  ![[Pasted image 20251022092906.png]]
Revisit [[Gaussian-Classifier]]
Mixture of Gaussians assumes the data points in each cluster has a Gaussian distribution. $$N(x|\mu_k,\sum_k)$$In the E step instead of "hard assignment" we do "soft assignment" to give a data point some probability to belong to different clusters. In the M step each centre is moved to the weighted mean of the data, with weights given by "soft assignments".![[Pasted image 20251022093346.png]]
Initialize the means $\mu_k$, covariances $\sum_k$, and mixing coefficients $\pi_k$. The mixing coefficients specify which Gaussian "contributes" more.
### [[EM-Algorithm]] Process
1. E Step: Soft assignment for a data point $x_n$, $Y(z_{nk})$ computes the probability of $x_n$ belonging to the cluster k $$Y(z_{nk})=\frac{\pi_kN(x_n|\mu_k,\sum_k)}{\sum_{j=1}^K\pi_jN(x_n|\mu_j,\sum_j)}$$ it is easy to see that for a data point $x_n,\sum_{k=1}^KY(z_{nk})=1$
2. M Step: Given the assignment, the M step finds cluster centres $μ_k$, the covariance matrixes $Σ_k$, and the mixing coefficients $π_k$. We can see the centres are moved to the weighted mean of the data, with weights given by soft assignments $Υ(z_{nk})$. $$\begin{aligned}
&\pi_k=\frac{\sum_nY(z_{nk})}{N} \\
&\mu_k=\frac{\sum_nY(z_{nk})x_n}{\sum_nY(z_{nk})} \\
&\sum_k=\frac{\sum_nY(z_{nk})(x_n-\mu_k)(x_n-\mu_k)^T}{\sum_nY(z_{nk})}
\end{aligned}$$
3. Repeat E and M step until the convergence criterion is satisfied
4. At the last step we assign each datapoint $x_n$ to the cluster k that has the largest $Y(z_{nk})$ i.e. $k=argmax_jY(z_{nj})$ 
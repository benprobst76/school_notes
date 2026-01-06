A support vector machine (SVM) is a kernelized maximum-margin hyperplane classifier. The maximum margin principle is: For linearly separable data, of all the hyperplanes that separate the data without misclassifying any data points, pick the hyperplane that maximizes the margin.  Consider linearly separable data.
![[Pasted image 20251017100439.png]]
When $y(x_n)$ is negative $t_n$ is negative and when $y(x_n)$ is positive $t_n$ is positive. 
Now maximum margin means that we wish to optimize the parameters w and b so that: $$arg max\{\frac{1}{||w||}min_n[t_n(w^T\phi(x_n)+b)]\}$$
The goal is to convert it into an equivalent problem that is easier. The trick is to think about rescaling w → κw and b → κb,  the distance from any point $x_n$ to the decision surface $\frac{|y(x_n)|}{||w||}$ is unchanged. (consider $2x_1+3x_2+1=0$ is the same hyperplane/line as $6x_1+9x_2+3=0$). We can use this to set the following points closest to the decision boundary. $$min_n[t_n(w^T\phi(x_n)+b)>=1$$
Now all the data points satisfy $t_n(w^T\phi(x_n)+b) >=1$ and the problem becomes:
objective $argmax\{\frac{1}{||w||}\}$ subject to constraint $t_n(w^T\phi(x_n)+b)>=1$

Data points satisfying equality are said to be active (they are support vectors lying on the two maximum margin hyperplanes), whereas for the remainder they are said to be inactive.

We rewrite the objective to be $argmin\frac{1}{2}\{||w||^2\}$. The two objectives are the same; w and b that satisfy the first formula is same as w and b that satisfy the second. The reason to use the second is that now we can call $\frac{1}{2}||w||^2$ an error. We cannot maximize an error but we can minimize an error. The constant 1/2 is added for the convenience of computing the first derivative. 


Use Lagrange multiplier to solve this constrained optimization problem. We introduce Lagrange multipliers $\alpha_n \ge 0$ for each constraint $t_n(w^T\phi(x_n)+b) \ge 1$. The Lagrangian function is then:
$$L(w, b, \alpha) = \frac{1}{2}||w||^2 - \sum_{n=1}^N \alpha_n [t_n(w^T\phi(x_n)+b) - 1]$$
To find the optimal $w$ and $b$, we set the derivatives of $L$ with respect to $w$ and $b$ to zero:
$\frac{\partial L}{\partial w} = w - \sum_{n=1}^N \alpha_n t_n \phi(x_n) = 0 \implies w = \sum_{n=1}^N \alpha_n t_n \phi(x_n)$

$\frac{\partial L}{\partial b} = - \sum_{n=1}^N \alpha_n t_n = 0 \implies \sum_{n=1}^N \alpha_n t_n = 0$

Substituting these back into the Lagrangian gives us the **dual formulation** of the SVM optimization problem, which depends only on the Lagrange multipliers $\alpha_n$:$$\tilde{L}(\alpha) = \sum_{n=1}^N \alpha_n - \frac{1}{2} \sum_{n=1}^N \sum_{m=1}^N \alpha_n \alpha_m t_n t_m \phi(x_n)^T \phi(x_m)$$
This dual problem is maximized with respect to $\alpha_n$ subject to the constraints $\alpha_n \ge 0$ and $\sum_{n=1}^N \alpha_n t_n = 0$.

The crucial aspect of the dual formulation is that the data points only appear in the form of dot products $\phi(x_n)^T \phi(x_m)$. This is where the **kernel trick** comes into play: we can replace $\phi(x_n)^T \phi(x_m)$ with a kernel function $K(x_n, x_m)$, allowing us to implicitly work in a high-dimensional feature space without explicitly computing the feature vectors.

Furthermore, the Karush-Kuhn-Tucker (KKT) conditions for this optimization problem state that for the optimal solution, $\alpha_n [t_n(w^T\phi(x_n)+b) - 1] = 0$. This implies:
*   If $t_n(w^T\phi(x_n)+b) > 1$, then $\alpha_n = 0$. These data points are not on the margin and do not influence the decision boundary.
*   If $t_n(w^T\phi(x_n)+b) = 1$, then $\alpha_n > 0$. These are the **support vectors**, the data points that lie on the margin and are critical for defining the decision boundary.

#### Summary of Training SVM  
- The original form of the objective is hard to optimize.  
- We need to convert it into an equivalent form that is much easier to solve.  
- The conversion also gives us the dual form with dot-product of data points, so the [[Kernel-Method]] can be applied.  
- Even more: data points that are not among support vectors can be discarded once the models are trained.

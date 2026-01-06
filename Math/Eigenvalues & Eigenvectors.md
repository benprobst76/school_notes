$$Av=\lambda v$$
If a matrix A, vector v and scalar $\lambda$ satisfy the above equation then v is an eigenvector of A. ( In [[Machine-Learning]] class always scale the length of eigenvector to be the unit length 1). $\lambda$ is called the eigenvalue associated with v. ![[Pasted image 20251022103944.png]]
(3) For other vectors (e.g., the red vector), the direction will be changed by the transformation.
(4) Eigenvalue controls how much v is scaled. If eigenvalue is 1, no scaling is performed (as the Mona Lisa shown on the left).

For any eigenvector v of A and scalar a: $Aav=\lambda av$
so you can always choose eigenvectors to have length 1: $\sqrt{v_1^2+...v_n^2}=1$  where $v=(v_1,v_2...v_n)$
Most machine learning or statistics tools give eigenvectors of length 1 when you use them to obtain eigenvectors for a matrix. If A has multiple eigenvectors and if they are orthogonal to one another they can be used as a new basis for a n-dimensional vector space. 
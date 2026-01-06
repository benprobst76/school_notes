Find the line or hyperlink which can best under some criteria operate two classes 
![[Pasted image 20251016163209.png]]
The vector wT controls the decision boundary; it is a vector perpendicular to the decision boundary. w0 is called bias. The model has fixed d + 1 parameters where d is the dimension of a data point, I.e. number of features. There are many different criteria to place the hyperplane.

We can assign an input vector x to class $C_1$ if y(x) > 0 and to class $C_2$ otherwise.

Note that we can augment x and w (both are column vectors) to absorb bias so we don’t have to treat bias separately. Instead the equation can be written as $$ y(x) = w^Tx $$where  $w^T = (w^T,w_0)$  and  $x = (x^T, 1)^T$

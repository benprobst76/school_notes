Training stage: In this case just remember the data
- Validation stage: finding the best K
- Testing stage: Given a test point **_x_** find the sphere around **_x_** enclosing k points then classify **_x_** according to the majority of the k neighbours. Choose an odd number k to avoid ties. 
![[Pasted image 20251016162955.png]]
- If k is too small the data has too much noise. (Not ignore outliers)
- Overfitting: a learning algorithm corresponds too closely or exactly to a particular set of data and may therefore fail to fit additional data or predict future observations reliably
- If k is too large the model does not learn much from the data and puts all the datapoints in the largest class 
- KNN learning is very cheap; you just need to remember all the data points but prediction is expensive; you need to find k nearest neighbours from a large set of N datapoints for each prediction. To make it more efficient you can use additional data structures like k-d trees and locality sensitive hashing.
- If the data is in a low dimensional space KNN often works well but in high dimensions almost all points are far away from each other. 
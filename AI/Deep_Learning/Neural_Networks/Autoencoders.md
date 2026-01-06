An autoencoder is an unsupervised neural network designed to learn efficient data encodings (representations) in an unsupervised manner. The goal of an autoencoder is to learn a representation (encoding) for a set of data, typically for dimensionality reduction, by training the network to ignore signal "noise".
## Autoencoders and PCA
Autoencoders share a conceptual link with Principal Component Analysis (PCA).
### PCA Explained
PCA takes D-dimensional data and finds the M orthogonal directions in which the data have the most variance. These M principal directions form a lower-dimensional subspace. We can represent a D-dimensional data point by its projections onto the M principal directions, though this process loses information about where the data point is located in the remaining orthogonal directions.
**Visual Representation of PCA (D=2, M=1):**
![[Pasted image 20251119140030.png]]
In the context of reconstruction, if we use the green point to represent the red point, the loss or "reconstruction" error is the squared distance between the red and green points. The reconstruction error is the sum over all these unrepresented directions of the squared differences of the data point and its projection.
### Linear Autoencoder
We can design a feedforward neural network aiming to make the output identical to the input, utilizing a hidden layer. If both the hidden and output layers are linear, the network will learn hidden units that are a linear function of the data and minimize the squared reconstruction error. This behavior is precisely what PCA accomplishes.
**Linear Autoencoder Architecture:**
![[Pasted image 20251119140153.png]]
## Generalizing Autoencoders
The linear model can be generalized by incorporating non-linear activation functions and multiple layers, resulting in a more powerful model. The network is trained to enable the middle hidden layer (often called the "code" or "bottleneck" layer) to capture the most salient information from the input data, allowing for its reconstruction with minimal errors.
An autoencoder is fundamentally a neural network trained to copy its input to its output. The primary objective is for the network to remember the most salient information to reconstruct the data with the fewest errors possible.
### Components of an Autoencoder
- **Encoder:** The input-to-hidden part of the network, responsible for transforming the input data into a lower-dimensional representation (the code).
- **Decoder:** The hidden-to-output part, responsible for reconstructing the original input from the learned code.
Autoencoders are versatile and can be used for dimensionality reduction, similar to PCA, as well as for feature learning, where the learned representations in the hidden layer can serve as meaningful features for other tasks.
## The Problem of Over-Capability
A critical question arises: If the encoder and decoder are too capable (i.e., have high capacity), is it beneficial?
It is often *not* a good thing; in fact, it can be detrimental.
**Why?** An overly capable encoder and decoder might simply learn to perform an identity mapping, copying the input to the output without extracting any salient information about the data into the code layer. This defeats the purpose of dimensionality reduction or feature learning.
**Solution: Regularization**
To mitigate this, we regularize the network to restrict the complexity or capability of the encoder and decoder. Regularization encourages the autoencoder to extract only the most salient information into the code layer, which is then used to reconstruct the data. Common regularization techniques include:
- **Sparsity:** Encouraging only a small number of hidden units to be active simultaneously.
- **Denoising:** Training the autoencoder to reconstruct the original input from a corrupted version.
- **Contractive:** Making the hidden layer robust to small perturbations in the input.
**Autoencoder with Regularization Concept:**
![[Pasted image 20251119140310.png]]
## Denoising Autoencoders (DAE)
A Denoising Autoencoder (DAE) is a specific type of autoencoder designed to be robust to noise.
A DAE first corrupts the input data (e.g., by adding Gaussian noise, setting random pixels to zero, or masking parts of the input). It is then trained to predict the original, uncorrupted data point as its output.
**Procedure for DAE Training:**
1. Choose a training sample from the dataset.
2. Obtain a corrupted version of this sample using a predefined corruption process.
3. Use the pair (corrupted input, original input) to train the autoencoder, where the network learns to reconstruct the original input from its corrupted counterpart.
**Concept:**
Input (Corrupted) -> Encoder -> Code -> Decoder -> Output (Original)
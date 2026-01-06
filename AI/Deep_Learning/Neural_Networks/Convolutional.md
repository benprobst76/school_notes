Yann LeCun and his collaborators developed a groundbreaking approach to handwritten digit recognition using back propagation within a [[Feed-Forward#Step 3 Backward Propagation (Backprop)|feed forward]] neural network. This architecture, known as **LeNet** or **ConvNet**, introduced several key innovations:
*   **Multiple Hidden Layers**: The network utilized several layers to process information hierarchically.
*   **Shared Parameters with Filters (Kernels)**: Instead of unique connections for every neuron, CNNs employ filters (also called kernels) that apply the same set of weights across different regions of the input, drastically reducing the number of parameters.
*   **Subsampling Operation**: Downsampling layers (pooling layers) are used to reduce the spatial dimensions of the feature maps, making the model more robust to variations and reducing computational cost.
These innovations have led to impressive performances in various domains, including image recognition, speech processing, and natural language understanding.
![[Pasted image 20251119134257.png]]
### Why Convolutional Networks?
For many tasks, especially those involving high-dimensional inputs like images, a fully connected network can be computationally expensive and prone to overfitting due to the large number of parameters. Consider the task of training computers to understand or model an image:
*   **Localized Patterns**: Many meaningful patterns in images are much smaller than the entire image (e.g., edges, corners, textures).
*   **Spatial Invariance**: The same pattern can appear in different locations within an image (e.g., an eye can be on the left or right side of a face). A standard fully connected network would need to learn this pattern independently at each possible location.
Convolutional Neural Networks address these issues by allowing local detectors to **share the same parameters**. This means a single "small" detector (filter) can be learned and then applied across the entire image to identify local features, regardless of their position.
### The Convolutional Stage
The first key component of a CNN is the convolutional stage, where a **filter** (or kernel) slides over the input data to detect local features.
![[Pasted image 20251119134546.png]]
Each filter is typically a small matrix (e.g., 3x3 or 5x5) responsible for detecting specific, small patterns such as edges, textures, or corners. The values within these filter matrices are the network parameters that are learned during the training process.
The operation performed is essentially a **dot product** (or weighted sum) between the filter and a small receptive field of the input. Each pixel in the input region is multiplied by its corresponding weight in the filter, and these products are summed. While this initial dot product provides a linear transformation, a non-linear activation function (like [[Neurons#Rectified Linear Units (ReLU) Neurons|ReLU]]) is typically applied immediately after to introduce non-linearity into the model.
### Fewer Parameters in CNNs
One of the significant advantages of CNNs over fully connected networks is the drastic reduction in the number of parameters, achieved through two main mechanisms:
1.  **Sparse Connectivity**: In a CNN, each output unit (neuron in a feature map) is connected only to a small, local region of the input (its receptive field), rather than to all input units. For example, if a 3x3 filter is used, an output unit is connected to only 9 input pixels, not the entire image.
    ![[Pasted image 20251119134656.png]]
    Compared to a fully connected network where each neuron would connect to all 36 inputs (in this example), the first output unit here is connected to only 9 inputs.
2.  **Weight Sharing**: The same filter (and thus the same set of weights) is applied across all spatial locations of the input. This means that if a filter detects a vertical edge in one part of the image, it can detect the same vertical edge in another part of the image using the identical learned weights. This significantly reduces the total number of unique parameters the network needs to learn.
The concept of weight sharing also extends beyond 2D images. A filter can be applied to 1D sequences (e.g., text, audio) or 3D data (e.g., video).
![[Pasted image 20251119134805.png]]
In summary, **convolution shares the same parameters across all spatial locations**, whereas traditional matrix multiplication in fully connected layers does not share any parameters.
### Subsampling (Pooling)
After the convolutional stage, a subsampling or pooling operation is often applied. The primary goals of pooling are:
*   **Dimensionality Reduction**: To make the image representations smaller, which reduces the number of parameters in subsequent layers.
*   **Computational Efficiency**: Smaller representations lead to less expensive computations.
*   **Increased Receptive Field**: By reducing the spatial dimensions, neurons in subsequent convolutional layers can cover a wider range of the original input image.
*   **Feature Robustness**: To make the learned features more robust to small translations and distortions in the input.
#### Max Pooling
**Max pooling** is a common type of subsampling. It divides the input feature map into a set of non-overlapping rectangles and, for each such sub-region, outputs the maximum value.
![[Pasted image 20251119134947.png]]
Max pooling introduces a degree of **invariance to image translation**. As illustrated in the figure:
*   The bottom row shows the input to a max pooling layer, and the top row shows its output.
*   If the input is shifted slightly (e.g., by one pixel to the right), as shown in the bottom figure, many of the individual pixel values in the input change. However, due to the max operation, fewer values in the output of the max pooling layer change. This means that the network becomes less sensitive to the exact position of a feature, recognizing it even if its location varies slightly.
#### Average Pooling
Another widely used pooling technique is **average pooling**. Instead of taking the maximum value within a region, average pooling calculates the average of all values within the receptive field. While max pooling focuses on the most prominent features, average pooling provides a more smoothed or generalized representation of the features in a region.
### Example Feature Maps
LeCun et al. (1990) provided illustrative examples of feature maps. The figure below shows feature maps after different stages of a convolutional network:
![[Pasted image 20251119135056.png]]
*   **Column 2 and 4**: Represent outputs after a convolutional stage, showing various features extracted by different filters.
*   **Column 3 and 5**: Represent outputs after a subsampling (pooling) stage, showing the reduced and more robust feature maps.
Notice how the four feature maps in Column 2, generated by different filters, focus on distinct aspects of the input image (the left-most image), highlighting different patterns like edges or corners.
### Challenges and Datasets: Beyond Handwritten Digits
While CNNs achieved significant success in handwritten digit recognition (e.g., on datasets like MNIST), recognizing objects in complex photographs from the web presents much greater challenges:
*   **Increased Number of Classes**: Real-world object recognition often involves thousands of distinct classes (e.g., different types of animals, vehicles, household items), as opposed to just 10 digits.
*   **Higher Resolution Images**: Web photographs are typically much larger in resolution (e.g., 1024x1024 pixels) compared to small handwritten digit images (e.g., 28x28 pixels). This significantly increases the amount of raw data to process.
*   **Variability**: Objects in real-world images can appear under vast variations in lighting, pose, scale, occlusion, background clutter, and artistic style.
#### ImageNet
**ImageNet** is a critical dataset that emerged to address these challenges and drive progress in large-scale visual recognition.
*   **Scale**: It comprises approximately 14 million images categorized into about 20,000 classes.
*   **ILSVRC**: The ImageNet Large-Scale Visual Recognition Challenge (ILSVRC) utilized a subset of ImageNet, specifically 1.2 million training images across 1000 object classes, to benchmark computer vision models. This challenge was instrumental in the widespread adoption and advancement of CNNs.
*   **Resource**: More information can be found at [https://www.image-net.org/](https://www.image-net.org/).
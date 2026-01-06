## Training [[Classification#Gaussian Classifier]]

```
% This script calculates the mean image for each of the 10 digit classes
% from the 'digits_train' data and visualizes them as 8x8 images while
% calculating the estimated shared variance

% Get the dimensions of the training data
[num_features, num_samples, num_classes] = size(digits_train);

% A matrix to store the mean vectors for each class
mu_means = zeros(num_features, num_classes);

% Calculate the mean image across the samples for each class
for k = 1:num_classes
	mu_means(:, k) = mean(digits_train(:, :, k), 2);
end

% Initialize the numerator of variance formula
total_sum_sq_diff = 0;

% Create figure to display the images
figure;
sgtitle('Mean Image for Each Digit Class', 'FontSize', 16, 'FontWeight', 'bold');

% For each class again display its mean image and compute the sum of
% squared differences
for k = 1:num_classes

	% Get all samples for the current class and calculate the differnece
	class_data = digits_train(:, :, k);	
	class_mean = mu_means(:, k);
	differences = class_data - class_mean;
	
	% Sum them up for the class
	sum_sq_diff_class = sum(differences.^2, 'all');
	total_sum_sq_diff = total_sum_sq_diff + sum_sq_diff_class;
	
	% Create a subplot and reshpae the vector into a matrix for display
	subplot(2, 5, k);
	mean_image = reshape(mu_means(:, k), 8, 8);
	imagesc(mean_image'); axis equal; axis off; colormap gray;
	
	% Rename class 10 to 0
	if k == 10
		title('Digit: 0', 'FontSize', 12);
	else
		title(['Digit: ', num2str(k)], 'FontSize', 12);
	end
end

% Compute the final estimate for the shared variance
M_total_samples = num_samples * num_classes;
denominator = num_features * M_total_samples;
sigma_sq_hat = total_sum_sq_diff / denominator;

fprintf('Estimated shared variance (sigma^2): %f\n', sigma_sq_hat);
```

$$ σ^2 = 0.063351 $$
![[Pasted image 20251008091705.png]]
## Training [[Classification#Naive Bayes Classifier]]
```
% This script trains a Naive Bayes classifier on the digits dataset.
% It binarizes the features and then estimates the model parameters and
% visualizes the estimated eta_k parameters for each class.

% Convert features x_i to binary features b_i
binary_digits_train = digits_train > 0.5;

% Get the dimensions of the training data
[num_features, num_samples, num_classes] = size(digits_train);

% Estimate the prior probabilities (just 0.1)
total_samples = num_samples * num_classes;
priors = ones(1, num_classes) * (num_samples / total_samples);

% Allocate a matrix to store the eta parameters.
eta_ki = zeros(num_features, num_classes);

% Calculate the mean image across the samples for each class
for k = 1:num_classes
	eta_ki(:, k) = mean(binary_digits_train(:, :, k), 2);
end

% Create a figure to display the images
figure;
sgtitle('Naive Bayes \eta_k Parameters', 'FontSize', 16, 'FontWeight', 'bold');

% For each class display its eta_k vector as an image
for k = 1:num_classes

	% Create a subplot and reshape the vector into matrix for display
	subplot(2, 5, k);
	eta_image = reshape(eta_ki(:, k), 8, 8);
	imagesc(eta_image'); axis equal; axis off; colormap gray;
	
	% Rename class 10 to 0
	if k == 10
		title('Digit: 0', 'FontSize', 12);
	else
		title(['Digit: ', num2str(k)], 'FontSize', 12);
	end
end
```
![[Pasted image 20251008091747.png]]
## Test Performance
```
% This script tests the performance of both Gaussian and Naive Bayes classifiers
% on the digits_test dataset and compares their error rates.

load('assignment1.mat');
  
% Get dimensions
[num_features, num_samples_train, num_classes] = size(digits_train);
[~, num_samples_test, ~] = size(digits_test);

train_gaussian

train_naive_bayes
  
%% Test Gaussian Classifier
gaussian_errors = zeros(1, num_classes);
gaussian_predictions = zeros(num_classes, num_samples_test);

% Prior probability (uniform)
prior_prob = 1 / num_classes;

% For each class
for true_class = 1:num_classes
	% For each test sample in this class
	for sample = 1:num_samples_test
		x = digits_test(:, sample, true_class);
		
		% Calculate log posterior for each class
		log_posteriors = zeros(1, num_classes);
		for k = 1:num_classes
		% Log p(x|C_k) for Gaussian with shared variance
			diff = x - mu_means(:, k);
			log_likelihood = -0.5 * sum(diff.^2) / sigma_sq_hat;
			
			% Log p(C_k|x) = log p(x|C_k) + log p(C_k) - log p(x)
			% Since log p(x) is constant for all classes, we can ignore it
			log_posteriors(k) = log_likelihood + log(prior_prob);
		end
		
		% Predict the class with highest posterior
		[~, predicted_class] = max(log_posteriors);
		gaussian_predictions(true_class, sample) = predicted_class;
		
		% Count error if prediction is wrong
		if predicted_class ~= true_class
			gaussian_errors(true_class) = gaussian_errors(true_class) + 1;
		end
	end
end

  

%% Test Naive Bayes Classifier
nb_errors = zeros(1, num_classes);
nb_predictions = zeros(num_classes, num_samples_test);

% Binarize test data
binary_digits_test = digits_test > 0.5;
  
% For each class
for true_class = 1:num_classes
	% For each test sample in this class
	for sample = 1:num_samples_test
		b = binary_digits_test(:, sample, true_class);
		
		% Calculate log posterior for each class
		log_posteriors = zeros(1, num_classes);
		for k = 1:num_classes

			% Log p(b|C_k) = sum_i [b_i * log(eta_ki) + (1-b_i) * log(1-eta_ki)]
			log_likelihood = sum(b .* log(eta_ki(:, k)) + (1 - b) .* log(1 - eta_ki(:, k)));
			
			% Log p(C_k|b) = log p(b|C_k) + log p(C_k)
			log_posteriors(k) = log_likelihood + log(prior_prob);
		end

		% Predict the class with highest posterior
		[~, predicted_class] = max(log_posteriors);
		nb_predictions(true_class, sample) = predicted_class;
		
		% Count error if prediction is wrong
		if predicted_class ~= true_class
			nb_errors(true_class) = nb_errors(true_class) + 1;
		end
	end
end

% Create error table
fprintf('Number of Errors per Digit Class:\n');
fprintf('%-12s', 'Digit');
for d = 1:9
	fprintf('%8d', d);
end
fprintf('%8d\n', 0); % Digit 0 is class 10

fprintf('%-12s', 'Gaussian');
for k = 1:9
	fprintf('%8d', gaussian_errors(k));
end
fprintf('%8d\n', gaussian_errors(10));

fprintf('%-12s', 'Naive Bayes');
for k = 1:9
	fprintf('%8d', nb_errors(k));
end

fprintf('%8d\n', nb_errors(10));
fprintf('\n');

% Calculate and display overall error rates
total_test_samples = num_samples_test * num_classes;
gaussian_total_errors = sum(gaussian_errors);
nb_total_errors = sum(nb_errors);
gaussian_error_rate = (gaussian_total_errors / total_test_samples) * 100;
nb_error_rate = (nb_total_errors / total_test_samples) * 100;

  

fprintf('Overall Performance:\n');
fprintf('%-20s: %d / %d errors (%.2f%% error rate, %.2f%% accuracy)\n', ...
'Gaussian', gaussian_total_errors, total_test_samples, gaussian_error_rate, 100 - gaussian_error_rate);
fprintf('%-20s: %d / %d errors (%.2f%% error rate, %.2f%% accuracy)\n', ...
'Naive Bayes', nb_total_errors, total_test_samples, nb_error_rate, 100 - nb_error_rate);
```

Number of Errors per Digit Class

| Digits | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 0   |
| ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NB     | 69  | 81  | 63  | 61  | 68  | 44  | 63  | 109 | 110 | 53  |
| Gauss  | 87  | 104 | 91  | 85  | 111 | 60  | 89  | 121 | 133 | 58  |
Overall Performance: 
Gaussian : 721 / 4000 errors (18.02% error rate, 81.97% accuracy)  
Naive Bayes : 939 / 4000 errors (23.47% error rate, 76.53% accuracy)

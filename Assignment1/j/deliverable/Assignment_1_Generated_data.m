% Generate data. Bear in mind that this is a random process and not every run might result in a linearly separable dataset.
% [data cp classes] = generateData(1, 0.5, 2, 15, 15, 5, 1, 2, 1000);

% Change every class "1" to a "-1" class so that the data is in line with what it expected by the algorithm
% classes(classes == 1) = -1;
% Change every class "2" to a "1" class so that the data is in line with what it expected by the algorithm
% classes(classes == 2) = 1;

% Load the generated data file
importfile('generated_data.mat');

% Read the x and y coordinates from the generated data
data = generated_data(:,1:2);

% Read the classes from the generated data
classes = generated_data(:,3);

% Extract the x point for plotting
x = data(:,1);
% Extract the y point for plotting
y = data(:,2);
% Plot all the data points
plot_data(x, y, classes);

% Call the perceptron
[weights iterations predicted_classes] = perceptron(data, classes, 0.1, 100, 1);

% Plot the data and the decision line
plot_data_and_decision_boundary(data, classes, weights);

% Run the perceptron for a given set of learning rates with a max number of 100 iterations. This will also generate a plot of the learning_rates vs the MSEs
assignment1c(data, classes, 100);
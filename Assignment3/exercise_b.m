import_pics('data\pics.mat')

hidden_nodes = [2,3,4,5,7,10,15,25];

classGlass = classGlass';

% Reset the random seed
rng(10);
% Separate the data into 10 different data sets. Indices(x) indicates that
% element x belongs to a particular cross validation
indices = crossvalind('Kfold',class,10);

% To store the errors
errors = [];
nets = [];

% Reshape for ease of use
indices = reshape(indices(:,:),10,40);

% Split the indices for training ans test. Each line is one training set
data_training_indices = indices(1:9,:);
data_test_indices = indices(10,:);

for hidden_node = hidden_nodes,
    
    % Store the nets for every cross validation set for this number of
    % hidden nodes
    tmp_nets = [];
    
    % Store the error for every cross validation set for this number of
    % hidden nodes
    tmp_errors = [];
    
    % Go through every training set
    for i = data_training_indices',
        
        % With the indices get all the inputs for this particular set
        data = pics(i,:);
        % With the indices get all the classes for this particular set
        classes = classGlass(i);
        
        % Create neural net
        net = mlp(2576, hidden_node, 1, 'linear');

        % Apply the model to data
        y = mlpfwd(net, data);

        % Train the network using the iterative reweighted least squares (IRLS) algorithm
        net = mlptrain(net, data, classes, 100);
        
        % Calculate error of this network
        error = mlperr(net, pics(data_test_indices,:), classGlass(data_test_indices));
        
        tmp_nets = [tmp_nets net];        
        tmp_errors = [tmp_errors error];
    end
    
    % Store all the nets resulting from every complete run using a
    % particular number of hidden nodes
    nets = [nets; tmp_nets];
    
    % Store all the errors resulting from every complete run using a
    % particular number of hidden nodes
    errors = [errors; tmp_errors];
    
end

% Show the errors
errors

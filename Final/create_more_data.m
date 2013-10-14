% Number of samples
m = size(data,1);
% Number of columns
n = size(data,2);

% Generate random people around the initial people
for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    for j=1:20,
       % Data offset
       a = x - 20;
       b = x + 20;
       % X coordinates for new person with random offset regarding the
       % representative person
       new_x = a + ((rand*(b-a)) + 1) ;
       
       % Introduce noise
       new_x = new_x + rand(47,1) - rand(47,1);

       % Data offset
       a = y - 20;
       b = y + 20;
       % Y coordinates for new person with random offset regarding the
       % representative person
       new_y = a + ((rand*(b-a)) + 1)  ;
       
       % Introduce noise
       new_y = new_y + rand(47,1) - rand(47,1);
       
       % Add new people to the dataset
       data = [data new_x new_y];
    end
end

% New number of columns
n = size(data,2);

source_panic = [542, 361];
source_matrix = repmat(source_panic,47,1);

% Calculate distance to panic source
distance_to_source = [];

for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    
    distance = [];
    
    for j=1:size(x,1),
        distance = [distance; norm(source_panic - [x(j) y(j)])];
    end
    
    distance_to_source = [distance_to_source distance];
end

% % Calculate angle of movement
% angle_of_movement = [];
% 
% for i=1:2:n,
%     x = data(:,i);
%     y = data(:,i+1);
%     
%     angle = [];
%     
%     for j=1:size(x,1),
%         angle = [angle; atan2(y/x,dot(y,x))];
%     end
%     
%     angle_of_movement = [angle_of_movement angle];
% end

% Calculate speed of movement
speed = [];

for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    
    sp = [];
    
    for j=1:m-1,
        tmp = (max(x(j),x(j+1))-min(x(j),x(j+1)))+(max(y(j),y(j+1))-min(y(j),y(j+1)));
        sp = [sp; tmp];
    end
    
    % Add zero speed to the last time (they stopped)
    sp = [sp; 0];
    
    speed = [speed sp];
end
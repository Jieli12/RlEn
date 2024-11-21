function y = draw_min_var(data, draw_length)
% data is the vector
% draw_length is the length you want to draw from the data
% Note data_length must be larger than draw_length
data_length = length(data);
num_loop = data_length-draw_length;
var_loop = zeros(num_loop, 1);
for i = 1:num_loop
    var_loop(i) = var(data(i:(draw_length+i-1)));
end
[~, index] = min(var_loop);
y = data(index:(index+draw_length-1));
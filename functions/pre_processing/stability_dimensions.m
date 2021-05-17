function [U,V,x,cx,rst1tr,rst1te,rst2tr,rst2te]=stability_dimensions(X)
% use the first half data as training and second half data as testing 
% divide two cell populations to obtain shared PCs and number of stable dimensions in the
% signal 
% input: X (num matrix) neuronal activity in [cell, time]
% outputs: U,V (num matrix, [cell,dimension]) coefficients for the first
% and second halves of cells; x (num matrix [cellhalf,dimension,time]) projected
% signal from the test data to trained PCs; cx (num array) correlation
% between projected test data from the two cell populations on each PC
rp = randperm(size(X, 1)); % random reordering of neurons
rst1 = X(rp(1:round(end/2)), :); %1st population
rst2 = X(rp(1+round(end/2):end), :); %2nd population
clear X

rst1tr = rst1(:, 1:round(end/2));
rst2tr = rst2(:, 1:round(end/2));
rst1te = rst1(:, 1+round(end/2):end);
rst2te = rst2(:, 1+round(end/2):end);
C = rst1tr * rst2tr'; % covariance of the two populations on train portion

[U, ~, V] = svd(C);
clear x
for i = 1:min([size(rst1, 1), size(rst2, 1)])
  x(1, i, :) = U(:, i)' * rst1te; % i-th dimension timecourse in the first population
  x(2, i, :) = V(:, i)' * rst2te; % i-th dimension timecourse in the second population
end

cx=[];
for i = 1:size(x, 2)
  cx(i) = corr(squeeze(x(1, i, :)), squeeze(x(2, i, :)));
end

% In the output matrix each element is an average of ratio1 X ratio2 
% elements of the original matrix.
% 
% Inputs: m - the input matrix
%         ratio1, ratio2 - compression ratios. 
%         If just one number is provided, it is assumed ratio1=ratio2=ratio
% Output: the compressed matrix
function m = compressMatrix(m, ratio1, ratio2)
if nargin < 3
  ratio2 = ratio1;
end;
if round(ratio1) ~= ratio1 || round(ratio2) ~= ratio2 || ratio1 < 1 || ratio2 < 1
    return;
end;

m = m(1:floor(size(m,1)/ratio1)*ratio1, :);
m = m(:,1:floor(size(m,2)/ratio2)*ratio2);

H = size(m,1) / ratio1;
W = size(m,2) / ratio2;

m = reshape(m, ratio1, []);
m = mean(m, 1);
m = reshape(m, H, []);

m = m';
m = reshape(m, ratio2, []);
m = mean(m, 1);
m = reshape(m, W,[]);
m = m';



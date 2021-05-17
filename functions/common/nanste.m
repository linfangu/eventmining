function err=nanste(x,dim) 
% compute standard error of mean for a vector, omitting NaN
% if input number is 1, assum input is 1-d 
% if input number is 2, calculate on selected dimension 
if nargin == 1 
err=std(x,'omitnan')/sqrt(sum(~isnan(x)));
elseif nargin == 2 
err=std(x,[],dim,'omitnan')./sqrt(sum(~isnan(x),dim));
end

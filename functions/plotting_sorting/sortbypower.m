function [ind]=sortbypower(ca,sr,range)
% sort calcium signal by power within specific frequency range 
% input: ca(num matrix) cell by time; sr(num) sampling rate; range(num vector) frequency range
% output: ind(num vector)sorting index, from highest power 
p=bandpower(ca',sr,range);
[~,ind]=sort(p,'descend');


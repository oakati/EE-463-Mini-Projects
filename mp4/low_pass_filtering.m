function [averagingwindow,svfiltered] = low_pass_filtering(lengthwindow,s)
disp('Filtering overall s');
averagingwindow=ones(1,lengthwindow)/lengthwindow;
svfiltered=conv(averagingwindow,s.v);
svfiltered=svfiltered(1:length(s.v));   % discard last samples after convolution 
disp('End of filtering');
end


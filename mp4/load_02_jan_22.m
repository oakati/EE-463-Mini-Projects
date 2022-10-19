function [sseries12] = load_02_jan_22()
    s.series12=load("series12.mat");% Suzuki series
    sseries12 = s.series12.series12;
end


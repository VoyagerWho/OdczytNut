function LiczbaEulera = euler(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
LiczbaEulera = regionprops(im, "EulerNumber").EulerNumber;
end


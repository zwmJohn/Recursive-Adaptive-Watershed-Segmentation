%{
Antonio Leonti
4.1.2020
main adapted specifically for batch scan
%}

clear;

%% load &/ make dataset

dset = "batch";

load(sprintf("private\\data\\%s.mat", dset));


%% modify dataset (morphological operations etc.)

raw = raw(:,:,1:658);
thresh = thresh(:,:,1:658);

fill = fill3d(thresh);


result = zeros(925, 932, 658, 'like', fill);


%% watershed

fprintf("Segmentating ''%s''...\n", dset);

for i = 0 : 13
    z = i*47+1 : (i+1)*47;
    result(:,:, z) = segment(fill(:,:, z), 0.075, 10000);
end


lm = labelmatrix(bwconncomp(result, 6));

save(sprintf("private\\results\\%s", dset), "lm");

%% show &/ save results

%path = sprintf("private\\extracted\\%s\\%s\\",dset,replace(datestr(datetime),':','-'));

%fprintf("Extracting regions in ''%s'' to ''%s.''\n", dset, path);

%extractRegions(raw, lm, path, 27.7128); %sqrt(3 * (16^2)) = 27.7128
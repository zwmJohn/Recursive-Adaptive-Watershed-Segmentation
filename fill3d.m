function filled = fill3d(data)
    %filled Summary of this function goes here
    
    %permute so we're always filling xy plane
    %implay(data);

    %fill via xy plane
    data = fill_xy(data);
    
    data = permute(data,[2,3,1]);
    data = fill_xy(data);
    
    data = permute(data, [3,2,1]);
    data = fill_xy(data);
    
    %now permute back to original orientation
    filled = imfill(permute(data, [1,3,2]), 'holes');
end
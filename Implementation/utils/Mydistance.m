function distance = Mydistance(B_scan)
%     B_scan = B_scan*255;
    columns = size(B_scan,2);
    distance = zeros(1,columns);

    for n = 1:columns
        % Find 255
        region = find(B_scan(:,n) == max(B_scan(:)));
        if numel(region) == 0
            distance(1,n) = 0;
        else
            UpperWhiteRegion = region(1);
            clear DistanceHat;
            counter = 1;
            for r=2:size(region,1)
                difference = region(r,1)-region(r-1,1);
                if difference > 20
                    DistanceHat(counter) = region(r-1,1)-UpperWhiteRegion;
                    UpperWhiteRegion = region(r);
                    counter = counter+1;
                else
                    DistanceHat(counter) = region(r,1)-UpperWhiteRegion;
                    counter = counter+1;
                end
            end
            distance(1,n) = max(DistanceHat);
        end
    end  
end
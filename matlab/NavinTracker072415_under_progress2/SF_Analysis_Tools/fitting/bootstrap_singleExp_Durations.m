function [mean_tau std_tau n] = bootstrap_singleExp_Durations(durFile)
    numAnim = max(durFile(2,:))
    allData = struct('datapoints',[]);
    index = 1;
    for(i=1:numAnim)
        ColIndicesforAnim = [];
        ColIndicesforAnim = find(durFile(2,:)==i);
        if(ColIndicesforAnim>0)
            dataPointsforAnim = durFile(1,ColIndicesforAnim);
            display(i)
            display(dataPointsforAnim)
            allData(index).datapoints = dataPointsforAnim;
            index = index+1;
        end
    end
    
    
bootstrapnum = 100;

experiments = length(allData);

values = zeros(bootstrapnum,1);

for m=1:bootstrapnum
    dataThisIter = [];
    randnum = ceil(experiments*rand(1,experiments));
    for(j=1:experiments)
        dataThisIter = [dataThisIter allData(randnum).datapoints];
    end
     
    [beta R2 edgesshort c_elements edges exp1] = ratesingle(dataThisIter','dwellstates',0);
    values(m) = beta(2);
end

mean_tau = mean(values);
std_tau = std(values);
n = experiments;
end

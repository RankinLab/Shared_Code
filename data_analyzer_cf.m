[folderName] = call_choreography

for j = 1:numel(folderName)    
    cd(char(folderName(j)));
    path2 = dir;
    isDir2 = find(vertcat(path2.isdir)); %find the indexes of directories
    subfolder = {path2(isDir2(3:numel(isDir2))).name}; %get names of subfolders

    plate = 0;
    for k = 1:numel(subfolder)
        cd(char(subfolder(k))) %loop through each subfolder
        data = dir('*.*rv'); %find the .trv file
        %disp(data.name)
        plate = plate + numel(data);
        dirData = dlmread(char(data.name),' ',0,0); %read data for each plate
     try
        %get experimental data from trv file
        plateDur(:,k) = dirData(:,19);
        plateSpeed(:,k) = dirData(:,8)./dirData(:,19);
        plateProp(:,k) = dirData(:,5)./sum(dirData(:,4:5),2);
        cd ..
     catch err        
        plateErr = strcat('Error: skipping .trv file in',' ',subfolder(k));
        disp(plateErr);
        cd ..          
        continue;
          
    end    
    end
    numPlates = max(plate);

    %mean, std and sem of duration
    avgDur(:,j) = nanmean(plateDur,2);
    avgDurStd(:,j) = std(plateDur,0,2);
    durSEM = sqrt(avgDurStd)./numPlates;
    
    %mean, std and sem of speed
    avgSpeed(:,j) = nanmean(plateSpeed,2);   
    avgSpeedStd(:,j) = std(plateSpeed,0,2);
    speedSEM = sqrt(avgSpeedStd)./numPlates;
    
    %mean, std and sem of reversal proportion
    avgProp(:,j) = nanmean(plateProp,2);
    avgPropStd(:,j) = std(plateProp,0,2);
    propSEM = sqrt(avgPropStd)./numPlates;
    
cd ..
end
disp('creating figures...')

h1 = figure;
%set(h1,'Visible', 'off');
errorbar(avgProp,propSEM);
ylabel('Reversal proportion')
legendH1 = {char(folderName)};
legend(legendH1);

h2 = figure;
%set(h2,'Visible', 'off');
errorbar(avgSpeed,speedSEM);
ylabel('Reversal speed (mm/s)')
legendH2 = {char(folderName)};
legend(legendH2);

h3 = figure;
%set(h3,'Visible', 'off');
errorbar(avgDur,durSEM);
ylabel('Reversal duration (s)')
legendH3 = {char(folderName)};
legend(legendH3);

print(h1,'-dpng','reversal_proportion.png');
print(h2,'-dpng','reversal_speed.png');
print(h3,'-dpng','reversal_duration.png'); 
disp('analysis complete')

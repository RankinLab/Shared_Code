prompt = 'What is the path to your folder? ';
result = strcat(' ',input(prompt));
disp(result)
cd(result);

path = dir;
isDir = find(vertcat(path.isdir));
folderName = {path(isDir(3:numel(isDir))).name};

for m = 1:numel(folderName)   
    cd(char(folderName(m)));
    currentFolder = pwd;       
    dataFolder = dir('*.zip');
    for n = 1:size(dataFolder,1)
        dataFoldName = dataFolder(n).name;
        filePath = [strcat(pwd,'/',dataFoldName)];   
   
        command = ['java -jar /home/rankinlab/Desktop/Chore.jar -p 0.027 -s 0.1 -t 20 -M 2 --shadowless -S -o nNss*b12 --plugin Reoutline::exp --plugin Respine --plugin MeasureReversal::tap::dt=1::collect=0.5::postfix=trv --plugin MeasureReversal::puff::dt=1::collect=0.5::postfix=prv ',filePath];
        system(command);
        disp(command)
    end   
    cd ..
end

for j = 1:numel(folderName)
   
    cd(char(folderName(j)));
    path2 = dir;
    isDir2 = find(vertcat(path2.isdir)); %find the indexes of directories
    subfolder = {path2(isDir2(3:numel(isDir2))).name}; %get names of subfolders

    plate = 0;
    for k = 1:numel(subfolder)
        cd(char(subfolder(k))) %loop through each subfolder
        data = dir('*.trv'); %find the .trv file
        disp(data.name)
        plate = plate + numel(data);
        dirData = dlmread(char(data.name),' ',4,0); %read data for each plate

        %get experimental data from trv file
        plateDur(:,k) = dirData(:,19);
        plateSpeed(:,k) = dirData(:,19)./dirData(:,8);
        plateProp(:,k) = dirData(:,5)./sum(dirData(:,4:5),2);
        cd ..
        
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
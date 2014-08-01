function [foldName] = call_choreography();
prompt = 'how many strains do you want to test? \n';
strainNum = input(prompt);


f = 0;
for f = 1:strainNum;
	count = 1;
	while strainNum ~= 0;
		prompt2 = 'input the folder path \n';
		paths = input(prompt2);
		foldName{count,:} = paths;
		strainNum = strainNum - 1;
		count = count + 1;
	end
end
prompt3 = 'Is this the first time you have analyzed your data? (y/n): ';
testStatus = input(prompt3,'s');

if strcmp(testStatus,'y');
for m = 1:numel(foldName)    
    cd(char(foldName(m)));
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
end

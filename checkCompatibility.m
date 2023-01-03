function compDevices = checkCompatibility()
%checkCompatibility This function determines which hardware devices are
%compatible with the GUI by reading the subfolders of the device_functions
%folder
devFoldName='device_functions';
communicationsFname='communicationSpecs.txt';

dire=dir(devFoldName);
%find the valid folders
dispositivos=[dire.isdir];
dispositivos(1:2)=0; %ignore the root folders

compDevFoldNames={dire(dispositivos).name}; 
% these are the devices in the folder, now validate thy are "installed"
% correctly by finding if the specification is correct

%check folder by folder
validFolders=ones(1,length(compDevFoldNames));
for ki=1:length(compDevFoldNames)
    %make sure the required files are in there
    commSpecsFile=dir(fullfile(devFoldName,compDevFoldNames{ki},communicationsFname));
    %if the file was not found, generate an exception
    portSpecs(ki)=[];
    if isempty(commSpecsFile)
        validFolders(ki)=0;
        continue
    end
    %read the serial port specifications and save them somewhere
    portSpecs(ki)=parseCommSpecs(commSpecsFile);

end

%outputs
compDevices = compDevFoldNames;

%echo the compatible devices
%disp(['Compatibility for ',,'detected'])

end
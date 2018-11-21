% add_mbed_to_path
%   Adds the mbed directory to the MATLAB path and saves
%   the updated path

function add_mbed_to_path

thisFolder =  fileparts( mfilename('fullpath') );
addpath(thisFolder);
isError = savepath;
if isError
    fprintf('Unable to save the updated MATLAB path\n');
    fprintf('If you are running Windows Vista or Windows 7, try the following\n');
    fprintf(' 1. Exit MATLAB\n');
    fprintf(' 2. Restart MATLAB with Administrator access\n');
    fprintf('    (see http://support.microsoft.com/kb/922708)\n');
    fprintf(' 3. Re-run this function\n');
else
    fprintf('mbed package successfully added to MATLAB path\n');
end


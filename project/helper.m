pref = 'iran';
disp(pref);

folder = '../imagedatabase.cs.washington.edu/groundtruth/iran/';
images = dir(strcat(folder,'*.jpg'));
nfiles = length(images);    % Number of files found
disp(nfiles);
%im = zeros(nfiles, 4096, 2);
ccvs = [];
for ii=1:nfiles
   currentfilename = images(ii).name;
   disp(currentfilename);
   im = CCV(strcat(folder,currentfilename), 16);
   ccvs = cat(3, ccvs, im);
   %currentimage = imread(currentfilename);
   %im(ii) = currentfilename;
end

    

disp(im);
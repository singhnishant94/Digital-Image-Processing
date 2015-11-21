### Given an image frame, find the most similar image frame from a database of images, using color image histograms

See Paper [here](http://www.cs.cornell.edu/~rdz/papers/pz-wacv96.pdf)

Files Description
* **CCV.m** (Function) : This function takes in input as file path , threshold and a factor to divide the bins and returns the CCV of given Image
* **deltaCCV.m** (Function) : This function takes in the CCV and returns the distance between them
* **pathfinder.m** (Function) : This function takes as input four numbers which are treated as indices to CCVs in the database and then finds the images corresponding to those indices
* **helper.m** (Script) : This script generates the CCV for a directory of images. You need to hardcode the images there
* **categorize.m** (Script) : This script takes as input an image and returns its three closest match in the database
* **subplot_tight.m** (Script) : This is the helper function which makes the images in the plot use maximum space available in the figure

References:
* For data we have used the following source http://imagedatabase.cs.washington.edu/groundtruth/
* The original Paper http://www.cs.cornell.edu/~rdz/papers/pz-wacv96.pdf
* subplot_tight http://www.mathworks.com/matlabcentral/fileexchange/30884-controllable-tight-subplot/content/subplot_tight/subplot_tight.m

Team Members:

1. 120050042 - [Prateek Chandan](http://www.prateekchandan.in)
2. 120050043 - [Nishant Kumar Singh](http://www.cse.iitb.ac.in/~nishantsingh)

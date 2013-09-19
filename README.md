split-vc-blur
=============

This is an example showing how to mimic blur effects in iOS 7 with UISplitViewController.
This example is optimized to render blur effects quickly with reasonable quality.

The blur effect code is based on code provided by Apple at WWDC 2013. 

To make the blur effect performant, the code reduces the size of the snapshots it takes
of the content view. This speeds up the blur convolution considerably. The smaller image size does 
not degrade image quality since the blur radius is set to a high value and one cannot see
pixelation when the image is stretched to a larger size.


split-vc-blur
=============

This is an example showing how to mimic blur effects in iOS 7 with UISplitViewController.
This example is optimized to render blur effects quickly with reasonable quality.

The blur effect code is based on code provided by Apple at WWDC 2013. You can download
the code for the blur effect from:

https://developer.apple.com/downloads/index.action?name=WWDC%202013

Note that you will need a developer account to access this content. Look for iOS_UIImageEffects
to get a package with Apple's example.

To make the blur effect performant, the code reduces the size of the snapshots it takes
of the content view. This speeds up the blur convolution considerably. The smaller image size does 
not degrade image quality since the blur radius is set to a high value and one cannot see
pixelation when the image is stretched to a larger size.

This example also shows a slow implementation of the blur effect that captures large screenshots
and runs multiple passes of a box blur filter. The slow implementation is contained in a branch
named 'slowImplementation'

To access the slow implementation, checkout the slowImplementation branch:

git checkout slowImplementation


The optimized version is in the master branch:

git checkout master
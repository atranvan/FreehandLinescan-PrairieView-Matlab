FreehandLinescan-PrairieView-Matlab
===================================

Interface PrairieView/Matlab to extract coordinates of longest line from image of dendrite, and update coordinates of freehand Linescan
by Alex Tran-Van-Minh (alexandra.tran.van.minh@gmail.com), written using Matlab R2013b

INSTALLATION:
Requirements: Matlab, Matlab Image Processing Toolbox, Matlab xml-io toolbox (http://www.mathworks.fr/matlabcentral/fileexchange/12907-xml-io-tools)
and the xmlfromvector.m script
Copy PrairieMLL.exe, lineptsimproc.m and xmlfromvector.m in C:\
In PrairieView>Tools>Action, open the LineScan tab, create a new Action.
Name: longestline
Filename: c:\PrairieMLL.exe
Arguments: "cd C:\\" "linepntsimproc('<image:ch2>')" 
if the morphology image to create the linescan from is acquired in channel 2.

Acquire an image of the dendrites to scan using Live Scan or Single Scan
Open the Linescan control window
Under Line Type, select Actions in the dropdown menu. Click the "More..." button
Select longestline
The procedure creates an xml file named 'toimport.xml'
This can be imported in Prairie View in the Linescan control window using the Load button in Line Type>freehand

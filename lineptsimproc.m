function lineptsimproc(PVimage)
%LINEPTSIMPROC draws skeletonized line for linescan from dendrite image
%   for import into PrairieView

    imageloaded=imread(PVimage)

    format long e
    level=graythresh(imageloaded)
   
    if (level~=0)
        'level is 0'
      level=level-level*0.1
    else
      level=0.001
    end
    
    BW=im2bw(imageloaded,level);% threshold and binarizes image
    BW=bwmorph(BW,'clean');
    L=medfilt2(BW,[3 3]);
    L=medfilt2(L,[3 3]);
    L=medfilt2(L,[3 3]);
    L=medfilt2(L,[3 3]);
    SK=bwmorph(L, 'skel', Inf);
    S=bwmorph(SK,'spur',150);
    S=bwmorph(S,'clean');
    h = fspecial('gaussian',4);
    S=filter2(h, S);
   
    S = bwmorph(S,'thin',inf);
    figure
    
    [d1,d2]=size(imageloaded);
    xworldlimits=[0,d1];
    yworldlimits=[0,d2];
    RA=imref2d(size(S),xworldlimits,yworldlimits);
    imshow(S,RA)
   

    %find the longest line between the user-defined points
    branchpoints=bwmorph(S,'branchpoints');
    

    branches=S & ~branchpoints;
    
    lineStats = regionprops(branches, {'Area','PixelIdxList'});
    [length, index] = max([lineStats.Area]);
    longestLine = zeros(size(branches));
    longestLine(lineStats(index).PixelIdxList)=1;

  
    figure; imshow(longestLine,RA)
    [xend, yend] = find(bwmorph(longestLine,'endpoints'));
    contour = bwtraceboundary(longestLine, [xend(1), yend(1)],'NW');
 

    

    xline=contour(:,1);
    yline=contour(:,2);
    xline=smooth(xline,1);
    yline=smooth(yline,1);
    figure
    imagesc(imageloaded)
    colormap(gray)
    axis('square')
    axis('off')
    hold on
   
    plot(yline,xline,'c')

    pts=[yline/d1,xline/d2];
    xmlfromvector(pts)
end


clear;
clc;
%% rgb2gray
A = imread('Your_Image.xxx'); 
G = rgb2gray(A);
%% histogram calculations for images
[counts,x] = imhist(G,16);
stem(x,counts);
%% Calculate global threshold using histogram
T = otsuthresh(counts);
%% create binary images using thresholds and display images
BW = imbinarize(G,T);
H = im2bw(G);
binImage = ~BW; %for lighter background
BW = binImage;  %for lighter background
BW1= imfill (BW, 'holes');
imshowpair(A,BW1,'montage') %Showing Results
%% select the properties of regionprops in the drawing and present in the table
stats = regionprops('table',BW1,'Centroid',...
    'Area','MajorAxisLength','MinorAxisLength');
stats.MajorAxisLength(stats.MajorAxisLength>300)=0;
stats.MinorAxisLength(stats.MinorAxisLength>300)=0;

stats.MajorAxisLength(stats.MajorAxisLength<50)=0;
stats.MinorAxisLength(stats.MinorAxisLength<50)=0;

%% calculate the centroid value of the coin
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
%% circle coin
hold on
viscircles(centers,radii);
hold off
total=0;
%%
iter = size(stats.Area);
for n = 1:iter
    if (stats.Area(n) < 100) number = ''; 
    elseif (stats.Area(n) < 5000) number = 1
            total=total+1;
    elseif (stats.Area(n) < 10000) number = 1
            total=total+1;
    elseif (stats.Area(n) < 20000) number = 1
            total=total+1;
    elseif (stats.Area(n) < 200000) number = 1
            total=total+1;  
    end
   %Displays the coin value on the object's centroid
    text(centers(n)-30,centers(n,2),num2str(number),...
        'Color','b','FontSize',12,'FontWeight','bold');
end
%% The title of the plot of the image is a total of coins
title(['Total Coin: ',num2str(total),' Coin'])

% load('matlab_monday_01.mat')
% tempPhantom=phantom(image_01.im)
% imagesc(tempPhantom)
% figure
% imagesc(image_02.imu)
%% Todo
% Check with the documentation and other stuff like the resolution and
% axis, scaling up the images
%%
clear all
close all


load('../../matlab_monday_01.mat')


%% Plotting the image
image01=image_01.im;

figure(1)
imagesc(image01); colormap gray; axis image; axis off;
[sy, sx] = size(image01);

title('Image given in class','FontSize',20);



%% plotting line profile
figure;
P=image_01.im;

res_x=image_01.dim(1);
res_y=image_01.dim(2);

line_profile = sum(P); % The sum command sums up all of elements in each column

plot((1:sx)*res_x,line_profile,'LineWidth',1.5); axis square
xlabel('Position (mm)','FontSize',20)
ylabel('Sum of Intensity','FontSize',20)
title("Line Profile of the Image")

set(gca,'FontSize',15,'LineWidth',2)


%% Evenly spaced inputs without file to generate the back projected image without filtering

evenlySpacedInputs=[3,10,30,180];
count=1;
for spacing=evenlySpacedInputs
    list=[0:180/(spacing-1):180];
    figure
    title(strcat('spacing: ',num2str(spacing)));
    backproject(image_01,list);
    count=count+1;


end
%% Evenly spaced inputs to generate image with filtering
evenlySpacedInputs=[3,10,30,180];
count=1;
for spacing=evenlySpacedInputs
    list=[0:180/(spacing-1):180];
    figure
    title(strcat('spacing: ',num2str(spacing)));
    backproject_filter(image_01,list);
    count=count+1;


end
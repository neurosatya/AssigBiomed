function recon = backproject(image,arrayOfAngles)
%%


[sy, sx] = size(image.im);
res_x=image.dim(1);
res_y=image.dim(2);
P=image.im;

recon = zeros(sy,sx);
count=1;
for angles = arrayOfAngles
    P_rot = imrotate(P,angles,'bilinear','crop');
    line_profile(count,:) = sum(P_rot);
    bp_rot = repmat(line_profile(count,:),[sy,1]);
    bp = imrotate(bp_rot,angles,'bilinear','crop');
    recon = recon+bp;
    count=count+1;
end
% subplot(1,2,1)
imagesc([1 sx]*res_x,[1 sy]*res_y,recon); colormap(gray)
axis image;
xlabel(['Position (mm)'],'FontSize',20)
title(strcat('Backprojection with: '," ", num2str(size(arrayOfAngles,2)) ,  ' projections'),'FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)



end







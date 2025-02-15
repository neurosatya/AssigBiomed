function recon_filter = backproject_filter(image,arrayOfAngles)


[sx,sy]=size(image.im);
res_x=image.dim(1);
res_y=image.dim(2);
%% Designing the ramlak filter
filter_ram_lak = ones(sx,1);
for x = 1:(sx/2)
    filter_ram_lak(x) = (sx/2)-x+1;
    filter_ram_lak(sx-x+1) = (sx/2)-x+1;
end
filter_ram_lak = filter_ram_lak;
plot(filter_ram_lak/max(filter_ram_lak))
axis([0 size(image.im,1) 0 1]); axis square
title('ram lak/ramp filter')

filter=filter_ram_lak
%% Estimating different line profiles for different
P=image.im;
count=1;
recon=0;
for angles=arrayOfAngles
    P_rot = imrotate(P,angles,'bilinear','crop');
    line_profile(count,:)=sum(P_rot);
    line_profile_filtered(count,:)=abs(ifft(fftshift(fft(line_profile(count,:))).*filter'));
    bp_rot = repmat(line_profile_filtered(count,:),[sy,1]);
    bp = imrotate(bp_rot,angles,'bilinear','crop');
    recon = recon+bp;
    count=count+1;
end

imagesc([1 sx]*res_x,[1 sy]*res_y,recon); colormap(gray)
axis image;
xlabel(['Position (mm)'],'FontSize',20)
title(strcat('Filtered Backprojection with: '," ", num2str(size(arrayOfAngles,2)) ,  ' projections'),'FontSize',20)
ylabel('Position (mm)','FontSize',20)
set(gca,'FontSize',15,'LineWidth',2)


end
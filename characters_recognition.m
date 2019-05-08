function [ result ] = characters_recognition( char_images,fig )
figure(fig);
for i=1:34
    im=imread(['characters/character/',num2str(i-1),'.bmp'],'bmp');
    im=~im2bw(im,0.5);
    chars{1,i}=im;
end

for i=2:7
    diff=[];
    for j=1:34
        h=min(size(char_images{i},1),size(chars{j},1));
        w=min(size(char_images{i},2),size(chars{j},2));
        im1=imresize(char_images{i},[h,w]);
        im2=imresize(chars{j},[h,w]);
        
        diff_image=im1.*im2;
        imLabel = bwlabel(diff_image);% 对连通区域进行标记
        stats = regionprops(diff_image,'Area');
        [b,index]=max([stats.Area]);
        diff_image=ismember(imLabel,index(1));
        diff_image=(im1+im2).*(~diff_image);
        
        %subplot(6,6,j),imshow(diff_image);
        diff=[diff,sum(sum(diff_image))/(h*w)];
        
    end
    subplot(1,8,i),plot(diff);
    [a,index]=min(diff);
    ind(i)=index;
end

for i=2:7
    subplot(7,8,i*8),imshow(chars{ind(i)})
end



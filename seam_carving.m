%function seam_carving(pic, weight, height)
%*****************利用seam&carving对图像进行缩放***************%
pic = 'lake.jpg';
im = imread(pic);
im = im2double(im);

figure,subplot(221);
imshow(im);
height = 200;
weight = 500;
%判断当前进行缩小or放大操作
h_old = size(im,1);
w_old = size(im,2);
w = weight - w_old;
h = height - h_old;

if w>0
    im = seam(im,w);
elseif w<0
    im = carve(im,-w);
end
subplot(222);imshow(im);

if h~=0
    if h>0
        im = seam(rot90(im),h);
    elseif h<0
        im = carve(rot90(im),-h);
    end
    im = imrotate(im,-90);
end
subplot(223);imshow(im);

%end

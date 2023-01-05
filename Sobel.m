function Eim = Sobel(im)
%**********根据梯度计算能量图************%
    %im = imread('c1.png');
    r = im2double(im(:,:,1));
    g = im2double(im(:,:,2));
    b = im2double(im(:,:,3));
    %水平算子
    horizontal = fspecial('prewitt');
    Er_h = imfilter(r,horizontal);
    Eg_h = imfilter(g,horizontal);
    Eb_h = imfilter(b,horizontal);
    Eh = abs(Er_h)+abs(Eg_h)+abs(Eb_h);
    %subplot(131),imshow(Eh);
    %竖直算子
    vertical = horizontal';
    Er_v = imfilter(r,vertical);
    Eg_v = imfilter(g,vertical);
    Eb_v = imfilter(b,vertical);
    Ev = abs(Er_v)+abs(Eg_v)+abs(Eb_v);
    %subplot(132);imshow(Ev);
    Eim = Eh+Ev;
    %转灰度图
    %subplot(133);imshow(Eim);
end
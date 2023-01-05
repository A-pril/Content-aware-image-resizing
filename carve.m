function carved = carve(im, num)
%**********缩小图像**********%
%im = the operated image
%num = the operation times

h_old = size(im,1);
w_old = size(im,2);
for i = 1:num
    %计算能量图
    Eim = Sobel(im);
    %动态规划找到能量最小的缝
    line = MinE(Eim,1);

%     在原图上显示缝
%     masked = zeros(h_old,w_old,3);
%     for h = 1:h_old
%         for w = 1:w_old-(i-1)
%             if line(1,h) == w
%                 masked(h,w,1) = 255;
%                 masked(h,w,2) = 0;
%                 masked(h,w,3) = 0;
%             else
%                 masked(h,w,:) = im(h,w,:);
%             end
%         end
%     end
%     figure,imshow(masked);    
%一次缩小一条缝，累计缩小num次
    carved = zeros(h_old,w_old-i,3);
    for h = 1:h_old
        for w = 1:w_old-i
            %缝左边一个像素
            if w == line(h)-1
                carved(h,w,:) = (im(h,w,:)+im(h,w+1,:))/2;
            %缝右边一个像素
            elseif w == line(h)
                carved(h,w,:) = (im(h,w,:)+im(h,w+1,:))/2;
            %缝左边
            elseif w <= line(h)-1
                carved(h,w,:) = im(h,w,:);
            %缝右边
            elseif w >= line(h)
                carved(h,w,:) = im(h,w+1,:);
            end
        end
    end



    %直接删缝
%     carved = zeros(h_old,w_old-i,3);
%     for h = 1:h_old
%         row1 = im(h,:,1);
%         row1(line(1,h)) = [];
%         row2 = im(h,:,2);
%         row2(line(1,h)) = [];
%         row3 = im(h,:,3);
%         row3(line(1,h)) = [];
%         carved(h,:,1) = row1;
%         carved(h,:,2) = row2;
%         carved(h,:,3) = row3;
%     end

    %递归,每次需要重新计算
    im = carved;
end
end
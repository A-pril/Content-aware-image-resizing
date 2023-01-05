function seamed = seam(im, num)
%**********扩大图像**********&
%im = the operated image
%num = the operation times

h_old = size(im,1);
w_old = size(im,2);

% 一次增加k条缝的内容
% 若k<图片本身宽度，一次性增加，分time次增加
if num<w_old/3
    k=num;
    time=1;
else
    k=floor(w_old/3);
    time=floor(num/k);
end

copy = im;

% 添加time次
for i = 1:time
    line = zeros(k,h_old);
    % 每次添加k条
    for j = 1:k
        %计算能量图
        Eim = Sobel(im);
        %动态规划找到当前能量最小的1条缝
        line(j,:) = MinE(Eim,1);
        %删除该缝，防止找的缝隙有重复
        deleted = zeros(h_old,w_old-j,3);
        for h = 1:h_old
            row1 = im(h,:,1);
            row1(line(j,h)) = [];
            row2 = im(h,:,2);
            row2(line(j,h)) = [];
            row3 = im(h,:,3);
            row3(line(j,h)) = [];
            deleted(h,:,1) = row1;
            deleted(h,:,2) = row2;
            deleted(h,:,3) = row3;
        end
        im = deleted;
    end
    % 恢复为没有删缝的情况
    im = copy;

    %一次扩大一条缝，累计扩大k次
    for t = 1:k
        seamed = zeros(h_old,w_old+t,3);
        for h = 1:h_old
            for w = 1:w_old+t
                %缝,修改缝的值并在缝右边添加一列
                if w == line(t,h)
                    %缝在最后一列
                    if w==w_old+t-1
                        seamed(h,w,:) = im(h,w,:);
                        seamed(h,w+1,:) = im(h,w,:);
                    else
                        seamed(h,w,:) = (2*im(h,w-1,:)+im(h,w+1,:))/3;
                        seamed(h,w+1,:) = (im(h,w-1,:)+2*im(h,w+1,:))/3;
                    end
                %缝左边
                elseif w < line(t,h)
                    seamed(h,w,:) = im(h,w,:);
                %缝右边
                elseif w > line(t,h)+1
                    seamed(h,w,:) = im(h,w-1,:);
                end
            end
        end
        %递归,每次需要重新计算
%         for l = t+1:k
%            if line(l,:) > line(t,:) 
%                 line(l,:) = line(t,:)+2; 
%            end
%         end
        im = seamed;
    end
end

if time*k<num
    line = zeros(num-time*k,h_old);
    %动态规划找到能量最小的num-time*k条缝
    for j = 1:num-time*k
        %计算能量图
        Eim = Sobel(im);
        %动态规划找到当前能量最小的1条缝
        line(j,:) = MinE(Eim,1);
        %删除该缝，防止找的缝隙有重复
        deleted = zeros(h_old,w_old-j,3);
        for h = 1:h_old
            row1 = im(h,:,1);
            row1(line(j,h)) = [];
            row2 = im(h,:,2);
            row2(line(j,h)) = [];
            row3 = im(h,:,3);
            row3(line(j,h)) = [];
            deleted(h,:,1) = row1;
            deleted(h,:,2) = row2;
            deleted(h,:,3) = row3;
        end
        im = deleted;
    end
    % 恢复为没有删缝的情况
    im = copy;

    %一次扩大一条缝，累计扩大num-time*k次
    for t = 1:num-time*k
        seamed = zeros(h_old,w_old+t+time*k,3);
        for h = 1:h_old
            for w = 1:w_old+t+time*k
                %缝,修改缝的值并在缝右边添加一列
                if w == line(t,h)
                    %缝在最后一列
                    if w==w_old+t-1
                        seamed(h,w,:) = im(h,w,:);
                        seamed(h,w+1,:) = im(h,w,:);
                    else
                        seamed(h,w,:) = (2*im(h,w-1,:)+im(h,w+1,:))/3;
                        seamed(h,w+1,:) = (im(h,w-1,:)+2*im(h,w+1,:))/3;
                    end
                %缝左边
                elseif w < line(t,h)
                    seamed(h,w,:) = im(h,w,:);
                %缝右边
                elseif w > line(t,h)+1
                    seamed(h,w,:) = im(h,w-1,:);
                end
            end
        end
        %递归,每次需要重新计算
%         for l = t+1:k
%            if line(l,:) > line(t,:) 
%                 line(l,:) = line(t,:)+2; 
%            end
%         end
        im = seamed;
    end
end
    
end

function line = MinE(Eim,k)
%**********找到能量最小的缝**********%
%Eim为原图像的梯度图/能量图
%k为缝的条数

h = size(Eim,1);
w = size(Eim,2);
map = zeros(h,w);
M = zeros(h,w);

%***能量M[i,j] = e[i,j] + min(e[i-1,j-1],e[i-1,j],e[i-1,j+1])***%
for i = 1:h
    for j = 1:w
        %第一行
        if i == 1
            M(i,j) = Eim(i,j);
            map(i,j) = j;
        %记录上一行选择的路径
        else
            %forward计算删除代价
            if j>=2 && j<=w-1
                CL = abs(Eim(i,j+1)-Eim(i,j-1)) + abs(Eim(i-1,j)-Eim(i,j-1));
                CR = abs(Eim(i,j+1)-Eim(i,j-1)) + abs(Eim(i-1,j)-Eim(i,j+1));
                CU = abs(Eim(i,j+1)-Eim(i,j-1));
                left = M(i-1,j-1)+CL;
                right = M(i-1,j+1)+CR;
            elseif j==1
                CR = abs(Eim(i,j+1)) + abs(Eim(i-1,j)-Eim(i,j+1));
                CU = abs(Eim(i,j+1));
                left = inf;
                right = M(i-1,j+1)+CR;
            else
                CL = abs(Eim(i,j-1)) + abs(Eim(i-1,j)-Eim(i,j-1));
                CU = abs(Eim(i,j-1));
                right = inf;
                left = M(i-1,j-1)+CL;
            end
                center = M(i-1,j)+CU;
                %判断上一行的三个中哪个最小
                Last = [left,center,right];
                lastmin = min(Last);
                M(i,j) = Eim(i,j)+lastmin;
            if left==lastmin
                map(i,j) = j-1;
            elseif right==lastmin
                map(i,j) = j+1;
            else
                map(i,j) = j;
            end

        end 
    end
end

%记录能量最小的缝的结束位置，即在最后一行的哪一列
[~,idx] = sort(M(h,:));

%记录能量最小的路径
line = zeros(1,h);
for path=1:k
    line(1,h) = idx(path);
    for i=1:h-1
        %后一行存着路径在前一行的列数
        line(1,h-i) = map(h+1-i,line(1,h+1-i));
    end
end

end

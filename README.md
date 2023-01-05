## Content-aware Image Resizing

根据论文Avidan, hai, and Ariel Shamir. "Seam carving for content-aware image resizing." ACM SIGGRAPH 200，实现了考虑像素间差异化的缩放算法.该方法是通过计算图像能量来确定图像中重要的内容，再利用动态规划查找能量最小的像素线，通过不断删除或复制这些低能量线，从而实现图像的缩放。我在原论文介绍的方法根据自己对于数字图像处理的一些经验，进行了一些小的改进和变动，具体内容可参考https://blog.csdn.net/Q_pril?spm=1011.2124.3001.5343

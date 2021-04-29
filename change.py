import cv2

# img=cv2.imread('3.png', cv2.IMREAD_GRAYSCALE)
# cv2.imwrite('test_img/1.png',img,[cv2.IMWRITE_PNG_BILEVEL, 1])


#第一 jpg图片转换为png
#第二 图片像素调整为1499*1386,且进行二值化处理
#第三 运行模型 完成预测


import cv2

#读取图片
src = cv2.imread('3.png')

#灰度图像处理
GrayImage = cv2.cvtColor(src,cv2.COLOR_BGR2GRAY)

#二进制阈值化处理
r, b = cv2.threshold(GrayImage, 180, 255, cv2.THRESH_BINARY)
print(r)
print(b)

# 保存图片:就是把数组保存成图片
import PIL

from PIL import Image
im = Image.fromarray(b)
im.save("test_result.png")

#显示图像
cv2.imshow("src", src)
cv2.imshow("result", b)


#等待显示
cv2.waitKey(0)
cv2.destroyAllWindows()


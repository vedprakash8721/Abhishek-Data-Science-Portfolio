import cv2
img=cv2.imread("Resources/iron man.jpeg")

if img is not None:
    gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    cv2.imshow('gray_img',gray)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    cv2.imwrite('gray_img.jpeg',gray)
else:
    print('could not load image: ')
print("saving the gray img: ")
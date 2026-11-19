import cv2
img=cv2.imread("Phase 1/Resources/iron man.jpeg")

if img is None:
    print(" image is not loaded")
    exit()
else:
    print("image is loaded:")
    resized=cv2.resize(img,(300,300))#width,hieght
    print("showing both original and resized image: ")
    cv2.imshow(" original image:",img)
    cv2.imshow("resized image:",resized)
    cv2.imwrite("resized.jpeg",resized)
    cv2.waitKey(0)

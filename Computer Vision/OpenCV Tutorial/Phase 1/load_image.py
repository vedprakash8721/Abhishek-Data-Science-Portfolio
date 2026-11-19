import cv2
img=cv2.imread("Resources/iron man.jpeg")
if img is  None:
    print("error: image is not loaded: ")
    exit()
print("image is loaded: ")
cv2.imshow("loading iron man image",img)
cv2.waitKey(0)
cv2.destroyAllWindows()
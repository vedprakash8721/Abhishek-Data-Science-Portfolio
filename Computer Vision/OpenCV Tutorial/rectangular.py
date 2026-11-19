import cv2
img=cv2.imread("Phase 1/Resources/iron man.jpeg")

if img is None:
    print(" image is not loaded:")
    exit()
else:
    print("image is loaded:")
pt1=(50,50)
pt2=(200,200)
color=(200,0,0)
thickness=3
cv2.rectangle(img,pt1,pt2,color,thickness)
cv2.imshow(" can you see the rectangle: ",img)
cv2.waitKey(0)
cv2.destroyAllWindows()
import cv2
img=cv2.imread("Phase 1/Resources/iron man.jpeg")

if img is None:
    print('image is not loaded:')
    exit()
else:
    print("image is loaded:")
print(img.shape) # hieght,width
pt1=(50,100)
pt2=(200,100)
color=(200,0,0)
thickness=3
cv2.line(img,pt1,pt2,color,thickness)
cv2.imshow(" can you see the draw line: ",img)
cv2.waitKey(0)
cv2.destroyAllWindows()

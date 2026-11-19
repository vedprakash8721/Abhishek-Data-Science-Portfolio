import cv2
img=cv2.imread("Phase 1/Resources/iron man.jpeg")

if img is None:
    print(" image is not loaded:")
    exit()
else:
    print("image is loaded:")
center=(130,185)
radius=30
color=(0,0,240)
thickness=3
cv2.circle(img,center,radius,color,thickness)
cv2.imshow(" can you see the the circle: ",img)
cv2.waitKey(0)
cv2.destroyAllWindows()
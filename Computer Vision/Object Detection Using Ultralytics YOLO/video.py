import cv2
cap=cv2.VideoCapture(0)
#checking for hardware
if not cap.isOpened():
    print("webcam is not opened: ")
    exit()
print("webcam is opened: ")

# read continuous frames:
while True:
    ret,frame=cap.read()
    if not ret:
        print("error in capturing frame:")
        break
    cv2.imshow("live webcam",frame)
    if cv2.waitKey(1) == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()

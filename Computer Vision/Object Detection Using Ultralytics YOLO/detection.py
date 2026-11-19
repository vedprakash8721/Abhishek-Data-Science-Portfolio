import cv2

# load light wieght and pretrained model
from ultralytics import YOLO
model=YOLO('bottle_detection_project/runs/detect/train/weights/best.pt')

#initializing camera
cap=cv2.VideoCapture(2)
#check for hardware
if not cap.isOpened():
    print("webcam is not opened: ")
    exit()
print("webcam is ready for object detection: ")

#check for frame capturing or not
while True:
    ret,frame=cap.read()
    if not ret:
        print(" webcame is not capturing frame :")
        break
    print("webcam is capturing frame: ")
    results=model(frame,stream=True)
    # ploting bondig box
    for r in results:
        annotated_frame=r.plot()
    # show the plot on screen: 
    cv2.imshow("realtime object detection",annotated_frame)
    #waitkeys
    if cv2.waitKey(1)==ord('q'):
        break

# release the webcam
cap.release()
cv2.destroyAllWindows()

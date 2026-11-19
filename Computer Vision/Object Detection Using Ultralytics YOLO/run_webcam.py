import cv2
from ultralytics import YOLO

model=YOLO('yolov8n_openvino_model',task='detect')
cap=cv2.VideoCapture(0)

if not cap.isOpened():
    print("webcam not detected:")
    exit()
while True:
    ret,frame=cap.read()
    if not ret:
        print("frame is not coming:")
        exit()
    results=model(frame,stream=True,verbose=False)
    for r in results:
        annotated_frame=r.plot()
    
    cv2.imshow("detecting object",annotated_frame)
    if cv2.waitKey(1)==ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
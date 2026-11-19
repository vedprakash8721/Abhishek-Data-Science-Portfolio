from ultralytics import YOLO
import cv2

model = YOLO("shahed26.pt")

cap = cv2.VideoCapture(1)

if not cap.isOpened():
    print("Webcam is not opened")
    exit()

print("Webcam ready for object detection")

while True:

    ret, frame = cap.read()

    if not ret:
        print("Webcam is not capturing frame")
        break

    # Detect only if confidence >= 60%
    results = model(frame, conf=0.6)

    # Draw detections
    annotated_frame = results[0].plot()

    cv2.imshow("Realtime Object Detection", annotated_frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
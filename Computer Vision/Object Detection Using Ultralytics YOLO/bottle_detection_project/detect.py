import cv2
from ultralytics import YOLO

# Load lightweight and pretrained model
model = YOLO('opt_m2.pt')

# Initializing camera (agar external webcam hai toh 1, laptop ka built-in hai toh 0 try karein)
cap = cv2.VideoCapture(0)

if not cap.isOpened():
    print("Webcam is not opened!")
    exit()

print("Webcam is ready for object detection. Press 'q' to exit.")

while True:
    ret, frame = cap.read()
    if not ret:
        print("Webcam is not capturing frame.")
        break
    
    # Optional: Frame size chhota karne se speed bohot fast ho jati hai (e.g., 640x480)
    # frame = cv2.resize(frame, (640, 480))

    # Inference (device='cpu' ya agar GPU hai toh device=0 kar sakte hain)
    results = model(frame, conf=0.3, verbose=False) # verbose=False extra logs rokega
    
    # Plotting bounding box/segmentation
    annotated_frame = results[0].plot()

    # Show the plot on screen
    cv2.imshow("Realtime Object Detection", annotated_frame)

    # Waitkey (1ms delay)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the webcam
cap.release()
cv2.destroyAllWindows()
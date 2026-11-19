from pathlib import Path
import cv2

save_dir=Path('Drone dataset/images/train')
save_dir.mkdir(parents=True,exist_ok=True)

cap=cv2.VideoCapture(0)
if not cap.isOpened():
    print(" webcam is not opened:")
    exit()
print('webcam is opened:')

img_count=0
while True:
    ret,frame=cap.read()
    if not ret:
        print('frame is not coming:')
        exit()

    cv2.imshow('capture the bottle:',frame)
    key=cv2.waitKey(1) & 0xFF

    if key ==32:
        img_count+=1
        file_path=save_dir/f"water_bottle{img_count:03d}.jpg"
        cv2.imwrite(str(file_path),frame)
        print("file is save at:{file_path}")
    elif key==ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
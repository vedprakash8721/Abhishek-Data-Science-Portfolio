import numpy as np
dummy_frame = np.zeros((640, 640, 3), dtype=np.uint8)
print(dummy_frame)
import cv2
img=cv2.imshow("dummy",dummy_frame)
cv2.waitKey(0)

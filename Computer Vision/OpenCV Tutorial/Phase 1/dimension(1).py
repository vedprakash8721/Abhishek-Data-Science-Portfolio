import cv2
img=cv2.imread("Resources/iron man.jpeg")

if img is not None:
    print("image is loaded and getting dimensions: ")
    h,w,c=img.shape
    print(f"hieght:{h}\nwidth:{w}\nchannels:{c}")
else:
    print("image is not loaded: ")
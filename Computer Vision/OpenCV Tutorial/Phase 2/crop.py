import cv2
img=cv2.imread("Phase 1/Resources/iron man.jpeg")

if img is not None:
    resize=img[100:200,250:350]
    cv2.imshow('cropped imagea:',resize)
    cv2.imshow('real image',img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
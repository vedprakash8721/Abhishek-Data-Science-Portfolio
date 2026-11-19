import cv2
img=cv2.imread("Phase 1/Resources/iron man.jpeg")

if img is None:
    print('image can not be rotate:')
    exit()
else:
    (h,w)=img.shape[:2] #taking only    hieght and width not channels
    center=(h//2,w//2)
    m=cv2.getRotationMatrix2D(center,45,1.5) #less than 0 means zoom out: ge means zoom in
    rotated=cv2.warpAffine(img,m,(w,h))
    flipped=cv2.flip(img,-1) # 0: top to bottom,1 : left to right,-1: both
    cv2.imshow('rotated image',rotated)
    cv2.imshow('flipped image',flipped)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
# Install dependencies
!pip install ultralytics
!pip install roboflow

# Imports
from ultralytics import YOLO
from roboflow import Roboflow
from IPython.display import Image


rf = Roboflow(api_key="zgewMZ23aQfhFNvhhHhJ")
project = rf.workspace("7052540116ankit-gmail-com").project("shahed-136-cpauw-18h1o-yp4uz-vw1jv")
version = project.version(4)
dataset = version.download("yolov8")
                
                
                
# Train model
!yolo task=detect mode=train \
data={dataset.location}/data.yaml \
model=yolo26n.pt \
epochs=100 \
imgsz=640 \
batch=100\
optimizer=AdamW \
lr0=0.0005 \
patience=100 \
mosaic=0.7 \
mixup=0.1 \
degrees=5 \
fliplr=0.5 \
scale=0.5

# Show results
Image(filename=f'{dataset.location}/../runs/detect/train/results.png', width=600)

# Validate model
!yolo task=detect mode=val \
    model=runs/detect/train/weights/best.pt \
    data={dataset.location}/data.yaml
import time
import numpy as np
import cv2
from ultralytics import YOLO

# list of models:
model_to_test=[
    ("pytorch( original )","yolov8n.pt"),
    ("ONNX","yolov8n.onnx"),
    ("OpenVINO","yolov8n_openvino_model"),
    ("TorchScript","yolov8n.torchscript"),
    ("NCNN","yolov8n_ncnn_model")
]

# creating a dummy (black) image:
dummy_frame=np.zeros((640,640,3),dtype=np.uint8)
print("-"*40)
print(" Benchmark is starting on your laptop :")
print("-"*40)
print(f"{'Format':<20} | {'Avg Latency (ms)':<18} | {'Estimated FPS':<12}")
print("-" * 60)

for name,model_path in model_to_test:
    try:
        model=YOLO(model_path,task='detect') # model load:
        # first interface runs slow so doing warm up first:
        for _ in range(5):
            _=model(dummy_frame,verbose=False)
        #actual benchmark:
        num_runs=30
        start_time=time.time()
        for _ in range(num_runs):
            _=model(dummy_frame,verbose=False)
        total_time=time.time()-start_time
        # calculations:
        avg_latency=(total_time/num_runs)*1000
        fps=1000/avg_latency
        # print them:
        print(f"{name:<20} | {avg_latency:<18} | {fps:<12}")
    except Exception as e:
        print(f"{name:<20} | failed to run as ({e})")
print("-"*40)
from ultralytics import YOLO
model=YOLO('yolov8n.pt')
print("starting the process of exporting the model: ")

# exporting in the onnx format:
onnx_path=model.export(format='onnx')
print(f" onnx model saved at{onnx_path}")

# exporting in the openvino format:
openvino_path=model.export(format='openvino')
print(f" openvino model saved at {openvino_path}")

# exporting in the TensorRT format:
# tensor_rt=model.export(format='engine')
# print(f" the tensor_rt model is saved at {tensor_rt}")

# exporting torchscript file:
torch_script=model.export(format='torchscript')
print(f"torchscript model is saved at { torch_script}")

# exporting tflite: can not support 
# tflite=model.export(format='tflite')
# print(f" tflite model saved at {tflite}")

# exporting ncnn model:
ncnn=model.export(format='ncnn')
print(f" ncnn model is saved at {ncnn}")
print("exporting the model is complete")

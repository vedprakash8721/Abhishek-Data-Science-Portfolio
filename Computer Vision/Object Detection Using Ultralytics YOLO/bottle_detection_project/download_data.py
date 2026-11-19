from roboflow import Roboflow

rf = Roboflow(api_key="sivqWW5KtgoWwvCw70Zu")
project = rf.workspace("abhishek-kushwaha-ze2ah").project("bottle_detection_project")
version = project.version(1)
dataset = version.download("yolov8")
#!/usr/bin/env python3

"""
VIDEO YOLO DETECTOR FOR NVIDIA JETSON

Usage:
    python3 video_detection.py --video /path/to/video.mp4

Example:
    python3 video_detection.py \
        --video /home/inv-ai/Downloads/record.mp4

Controls:
    P       = Pause / Resume
    S       = Save current frame
    ESC/Q   = Quit

Features:
    - YOLO .pt or .engine model
    - FP16 inference
    - Target class filtering
    - Brightness adjustment
    - FPS display
    - Inference timing
    - Output video saving
"""

from ultralytics import YOLO
import cv2
import os
import time
import argparse


# =============================================================
# CONFIG
# =============================================================

MODEL_PATH = "/home/ankit/Downloads/new.pt"

CONF = 0.40
HALF = True
DEBUG_TIMING = True

IMG_SIZE = 640

DISPLAY_WIDTH = 1280
DISPLAY_HEIGHT = 720

OUTPUT_DIR = "detection_results"

# Only this class will be displayed
TARGET_CLASS_ID = 0

# -------------------------------------------------------------
# BRIGHTNESS
# -------------------------------------------------------------

BRIGHTNESS_ALPHA = 1.0
BRIGHTNESS_BETA = 18


# =============================================================
# COLORS - BGR
# =============================================================

RED = (0, 0, 255)
GREEN = (0, 200, 0)
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)


# =============================================================
# UI HELPERS
# =============================================================

def _scaled(frame, base_frac=0.055, min_px=28, max_px=52):

    h, w = frame.shape[:2]

    bar_h = int(min(h, w) * base_frac)

    return max(min_px, min(max_px, bar_h))


def _put_text_fit(
    frame,
    text,
    x,
    y,
    max_scale,
    color,
    thickness,
    max_width
):

    scale = max_scale

    while scale > 0.35:

        (tw, th), _ = cv2.getTextSize(
            text,
            cv2.FONT_HERSHEY_SIMPLEX,
            scale,
            thickness
        )

        if tw <= max_width:
            break

        scale -= 0.05

    cv2.putText(
        frame,
        text,
        (x, y),
        cv2.FONT_HERSHEY_SIMPLEX,
        scale,
        color,
        thickness,
        cv2.LINE_AA
    )

    return scale


# =============================================================
# DRAW BOXES
# =============================================================

def draw_boxes(frame, boxes, names):

    for box in boxes:

        cls_id = int(box.cls[0])

        if cls_id != TARGET_CLASS_ID:
            continue

        x1, y1, x2, y2 = map(
            int,
            box.xyxy[0]
        )

        conf = float(box.conf[0])

        class_name = (
            names[cls_id]
            if cls_id in names
            else f"class_{cls_id}"
        )

        label = f"{class_name} {conf:.2f}"

        cv2.rectangle(
            frame,
            (x1, y1),
            (x2, y2),
            RED,
            2
        )

        (tw, th), _ = cv2.getTextSize(
            label,
            cv2.FONT_HERSHEY_SIMPLEX,
            0.5,
            1
        )

        ty = max(
            y1 - 5,
            th + 4
        )

        cv2.rectangle(
            frame,
            (x1, ty - th - 4),
            (x1 + tw + 4, ty),
            RED,
            -1
        )

        cv2.putText(
            frame,
            label,
            (x1 + 2, ty - 3),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.5,
            WHITE,
            1,
            cv2.LINE_AA
        )

    return frame


# =============================================================
# VIDEO STATUS BAR
# =============================================================

def draw_video_status_bar(
    frame,
    detected,
    detected_labels,
    fps,
    inference_ms,
    frame_number,
    total_frames
):

    h, w = frame.shape[:2]

    top_h = _scaled(frame)

    bottom_h = max(
        30,
        int(top_h * 0.85)
    )

    color = RED if detected else GREEN

    overlay = frame.copy()

    # Top bar
    cv2.rectangle(
        overlay,
        (0, 0),
        (w, top_h),
        color,
        -1
    )

    # Bottom bar
    cv2.rectangle(
        overlay,
        (0, h - bottom_h),
        (w, h),
        BLACK,
        -1
    )

    cv2.addWeighted(
        overlay,
        0.72,
        frame,
        0.28,
        0,
        frame
    )

    # Detection status
    if detected:

        status = (
            "DETECTED: "
            + " | ".join(detected_labels)
        ).upper()

    else:

        status = "NO TARGET DETECTED"

    font_scale = max(
        0.5,
        top_h / 50.0
    )

    thick = (
        2
        if top_h > 34
        else 1
    )

    _put_text_fit(
        frame,
        status,
        10,
        int(top_h * 0.68),
        font_scale,
        WHITE,
        thick,
        int(w * 0.62)
    )

    # FPS
    fps_text = f"{fps:.1f} FPS"

    fps_scale = max(
        0.45,
        font_scale * 0.62
    )

    (tw, th), _ = cv2.getTextSize(
        fps_text,
        cv2.FONT_HERSHEY_SIMPLEX,
        fps_scale,
        1
    )

    cv2.putText(
        frame,
        fps_text,
        (w - tw - 12, int(top_h * 0.68)),
        cv2.FONT_HERSHEY_SIMPLEX,
        fps_scale,
        WHITE,
        1,
        cv2.LINE_AA
    )

    # Bottom information
    info = (
        f"Frame: {frame_number}/{total_frames} | "
        f"Infer: {inference_ms:.1f} ms | "
        f"P pause | S save | ESC/Q quit"
    )

    b_scale = max(
        0.38,
        bottom_h / 70.0
    )

    _put_text_fit(
        frame,
        info,
        8,
        h - 8,
        b_scale,
        WHITE,
        1,
        int(w * 0.98)
    )

    return frame


# =============================================================
# RESIZE FOR DISPLAY
# =============================================================

def resize_frame(
    frame,
    screen_w=DISPLAY_WIDTH,
    screen_h=DISPLAY_HEIGHT
):

    h, w = frame.shape[:2]

    scale = min(
        screen_w / w,
        screen_h / h
    )

    if abs(scale - 1.0) > 0.01:

        interpolation = (
            cv2.INTER_AREA
            if scale < 1
            else cv2.INTER_LINEAR
        )

        frame = cv2.resize(
            frame,
            (
                int(w * scale),
                int(h * scale)
            ),
            interpolation=interpolation
        )

    return frame


# =============================================================
# VIDEO DETECTION
# =============================================================

def run_video_detection(video_path, model):

    # ---------------------------------------------------------
    # OPEN VIDEO
    # ---------------------------------------------------------

    print()
    print("=" * 60)
    print("VIDEO YOLO DETECTION")
    print("=" * 60)

    print(f"Video       : {video_path}")
    print(f"Model       : {MODEL_PATH}")
    print(f"Confidence  : {CONF}")
    print(f"Image size  : {IMG_SIZE}")
    print(f"FP16        : {HALF}")
    print(f"Target ID   : {TARGET_CLASS_ID}")
    print(f"Brightness  : {BRIGHTNESS_BETA}")

    print("=" * 60)

    cap = cv2.VideoCapture(video_path)

    if not cap.isOpened():

        print()
        print("❌ ERROR: Cannot open video:")
        print(video_path)
        print()

        return

    # ---------------------------------------------------------
    # VIDEO INFORMATION
    # ---------------------------------------------------------

    video_width = int(
        cap.get(cv2.CAP_PROP_FRAME_WIDTH)
    )

    video_height = int(
        cap.get(cv2.CAP_PROP_FRAME_HEIGHT)
    )

    video_fps = cap.get(
        cv2.CAP_PROP_FPS
    )

    total_frames = int(
        cap.get(cv2.CAP_PROP_FRAME_COUNT)
    )

    duration = (
        total_frames / video_fps
        if video_fps > 0
        else 0
    )

    print()
    print("VIDEO INFORMATION")
    print("-" * 60)
    print(f"Resolution  : {video_width}x{video_height}")
    print(f"FPS         : {video_fps:.2f}")
    print(f"Frames      : {total_frames}")
    print(f"Duration    : {duration:.2f} sec")
    print("-" * 60)

    # ---------------------------------------------------------
    # OUTPUT
    # ---------------------------------------------------------

    os.makedirs(
        OUTPUT_DIR,
        exist_ok=True
    )

    video_name = os.path.splitext(
        os.path.basename(video_path)
    )[0]

    output_path = os.path.join(
        OUTPUT_DIR,
        f"{video_name}_detected.mp4"
    )

    # ---------------------------------------------------------
    # VIDEO WRITER
    # ---------------------------------------------------------

    fourcc = cv2.VideoWriter_fourcc(
        *"mp4v"
    )

    writer = cv2.VideoWriter(
        output_path,
        fourcc,
        video_fps if video_fps > 0 else 30,
        (
            video_width,
            video_height
        )
    )

    if not writer.isOpened():

        print(
            "⚠️ WARNING: Output video writer failed."
        )

        writer = None

    # ---------------------------------------------------------
    # WINDOW
    # ---------------------------------------------------------

    window_name = "Video - Drone Detection"

    cv2.namedWindow(
        window_name,
        cv2.WINDOW_NORMAL
    )

    cv2.resizeWindow(
        window_name,
        DISPLAY_WIDTH,
        DISPLAY_HEIGHT
    )

    print()
    print("Controls:")
    print("  P       = Pause / Resume")
    print("  S       = Save current frame")
    print("  ESC/Q   = Quit")
    print()

    # ---------------------------------------------------------
    # VARIABLES
    # ---------------------------------------------------------

    frame_count = 0

    detected_frames = 0

    paused = False

    previous_time = time.perf_counter()

    fps_ema = 0.0

    FPS_ALPHA = 0.10

    total_infer_time = 0.0

    total_read_time = 0.0

    total_draw_time = 0.0

    timing_count = 0

    last_report = time.perf_counter()

    # ---------------------------------------------------------
    # MAIN LOOP
    # ---------------------------------------------------------

    while True:

        # =====================================================
        # PAUSED
        # =====================================================

        if paused:

            key = cv2.waitKey(30) & 0xFF

            if key in (
                ord("p"),
                ord("P")
            ):

                paused = False

                print("▶ Resumed")

            elif key in (
                27,
                ord("q"),
                ord("Q")
            ):

                break

            continue

        # =====================================================
        # READ FRAME
        # =====================================================

        read_start = time.perf_counter()

        ret, frame = cap.read()

        read_end = time.perf_counter()

        read_time = (
            read_end - read_start
        )

        total_read_time += read_time

        if not ret or frame is None:

            print()
            print("✅ Video processing finished.")

            break

        frame_count += 1

        timing_count += 1

        # =====================================================
        # BRIGHTNESS
        # =====================================================

        frame = cv2.convertScaleAbs(
            frame,
            alpha=BRIGHTNESS_ALPHA,
            beta=BRIGHTNESS_BETA
        )

        # =====================================================
        # INFERENCE
        # =====================================================

        infer_start = time.perf_counter()

        results = model(
            frame,
            imgsz=IMG_SIZE,
            conf=CONF,
            device="cpu",
            half=False,
            verbose=False
        )

        infer_end = time.perf_counter()

        inference_time = (
            infer_end - infer_start
        )

        inference_ms = (
            inference_time * 1000.0
        )

        total_infer_time += inference_time

        # =====================================================
        # GET BOXES
        # =====================================================

        boxes = results[0].boxes

        target_boxes = []

        detected_labels = []

        for box in boxes:

            cls_id = int(
                box.cls[0]
            )

            # Only target class
            if cls_id != TARGET_CLASS_ID:
                continue

            target_boxes.append(box)

            label = (
                model.names[cls_id]
                if cls_id in model.names
                else f"class_{cls_id}"
            )

            confidence = float(
                box.conf[0]
            )

            detected_labels.append(
                f"{label} ({confidence:.2f})"
            )

        detected_flag = (
            len(target_boxes) > 0
        )

        if detected_flag:

            detected_frames += 1

        # =====================================================
        # DRAW
        # =====================================================

        draw_start = time.perf_counter()

        annotated = frame.copy()

        if detected_flag:

            draw_boxes(
                annotated,
                target_boxes,
                model.names
            )

        draw_end = time.perf_counter()

        total_draw_time += (
            draw_end - draw_start
        )

        # =====================================================
        # FPS
        # =====================================================

        now = time.perf_counter()

        instant_fps = 1.0 / max(
            now - previous_time,
            0.000001
        )

        previous_time = now

        if fps_ema <= 0:

            fps_ema = instant_fps

        else:

            fps_ema = (
                FPS_ALPHA * instant_fps
                +
                (1.0 - FPS_ALPHA) * fps_ema
            )

        # =====================================================
        # WRITE OUTPUT VIDEO
        # =====================================================

        if writer is not None:

            writer.write(annotated)

        # =====================================================
        # DISPLAY
        # =====================================================

        display = resize_frame(
            annotated
        )

        display = draw_video_status_bar(
            display,
            detected_flag,
            detected_labels,
            fps_ema,
            inference_ms,
            frame_count,
            total_frames
        )

        cv2.imshow(
            window_name,
            display
        )

        # =====================================================
        # KEYBOARD
        # =====================================================

        key = cv2.waitKey(1) & 0xFF

        # ESC / Q
        if key in (
            27,
            ord("q"),
            ord("Q")
        ):

            print()
            print("🛑 Quit by user.")

            break

        # Pause
        elif key in (
            ord("p"),
            ord("P")
        ):

            paused = True

            print("⏸ Paused")

        # Save frame
        elif key in (
            ord("s"),
            ord("S")
        ):

            timestamp = time.strftime(
                "%Y%m%d_%H%M%S"
            )

            filename = os.path.join(
                OUTPUT_DIR,
                f"frame_{frame_count}_{timestamp}.jpg"
            )

            cv2.imwrite(
                filename,
                annotated
            )

            print(
                f"💾 Saved: {filename}"
            )

        # =====================================================
        # TIMING REPORT
        # =====================================================

        if DEBUG_TIMING:

            report_now = time.perf_counter()

            if (
                report_now - last_report
                >= 2.0
            ):

                n = max(
                    timing_count,
                    1
                )

                avg_read = (
                    total_read_time
                    / n
                    * 1000
                )

                avg_infer = (
                    total_infer_time
                    / n
                    * 1000
                )

                avg_draw = (
                    total_draw_time
                    / n
                    * 1000
                )

                progress = (
                    frame_count
                    / max(total_frames, 1)
                    * 100
                )

                print(
                    f"Frame {frame_count:>6}/"
                    f"{total_frames:<6} | "
                    f"{progress:>5.1f}% | "
                    f"FPS {fps_ema:>6.1f} | "
                    f"read {avg_read:>5.1f}ms | "
                    f"infer {avg_infer:>5.1f}ms | "
                    f"draw {avg_draw:>5.1f}ms"
                )

                timing_count = 0

                total_read_time = 0.0
                total_infer_time = 0.0
                total_draw_time = 0.0

                last_report = report_now

    # =========================================================
    # CLEANUP
    # =========================================================

    cap.release()

    if writer is not None:

        writer.release()

    cv2.destroyAllWindows()

    # =========================================================
    # SUMMARY
    # =========================================================

    detection_rate = (
        detected_frames
        /
        max(frame_count, 1)
        *
        100.0
    )

    print()
    print("=" * 60)
    print("VIDEO DETECTION SUMMARY")
    print("=" * 60)

    print(
        f"Video             : {video_path}"
    )

    print(
        f"Output            : {output_path}"
    )

    print(
        f"Target class ID   : {TARGET_CLASS_ID}"
    )

    print(
        f"Frames processed  : {frame_count}"
    )

    print(
        f"Detected frames   : {detected_frames}"
    )

    print(
        f"Detection rate    : {detection_rate:.1f}%"
    )

    print(
        f"Average FPS       : {fps_ema:.2f}"
    )

    print(
        f"Brightness beta   : {BRIGHTNESS_BETA}"
    )

    print("=" * 60)

    print()
    print(
        f"✅ Output saved at:\n{output_path}"
    )


# =============================================================
# MAIN
# =============================================================

def main():

    global MODEL_PATH
    global CONF
    global HALF
    global DEBUG_TIMING
    global BRIGHTNESS_BETA

    parser = argparse.ArgumentParser(
        description="Jetson Video YOLO Detector"
    )

    # ---------------------------------------------------------
    # VIDEO
    # ---------------------------------------------------------

    parser.add_argument(
        "--video",
        required=True,
        help="Path to input video"
    )

    # ---------------------------------------------------------
    # MODEL
    # ---------------------------------------------------------

    parser.add_argument(
        "--model",
        default=MODEL_PATH,
        help="Path to YOLO .engine or .pt model"
    )

    # ---------------------------------------------------------
    # CONFIDENCE
    # ---------------------------------------------------------

    parser.add_argument(
        "--conf",
        type=float,
        default=CONF,
        help="Confidence threshold"
    )

    # ---------------------------------------------------------
    # BRIGHTNESS
    # ---------------------------------------------------------

    parser.add_argument(
        "--brightness",
        type=int,
        default=BRIGHTNESS_BETA,
        help="Brightness amount: 0=original"
    )

    # ---------------------------------------------------------
    # NO HALF
    # ---------------------------------------------------------

    parser.add_argument(
        "--no-half",
        action="store_true",
        help="Disable FP16"
    )

    # ---------------------------------------------------------
    # NO TIMING
    # ---------------------------------------------------------

    parser.add_argument(
        "--no-debug-timing",
        action="store_true",
        help="Disable timing output"
    )

    args = parser.parse_args()

    # ---------------------------------------------------------
    # APPLY SETTINGS
    # ---------------------------------------------------------

    MODEL_PATH = args.model

    CONF = args.conf

    HALF = not args.no_half

    DEBUG_TIMING = not args.no_debug_timing

    BRIGHTNESS_BETA = args.brightness

    # ---------------------------------------------------------
    # PRINT CONFIG
    # ---------------------------------------------------------

    print()
    print("=" * 60)
    print("JETSON VIDEO YOLO")
    print("=" * 60)

    print(
        f"Video       : {args.video}"
    )

    print(
        f"Model       : {MODEL_PATH}"
    )

    print(
        f"Confidence  : {CONF}"
    )

    print(
        f"Image size  : {IMG_SIZE}"
    )

    print(
        f"FP16        : {HALF}"
    )

    print(
        f"Target ID   : {TARGET_CLASS_ID}"
    )

    print(
        f"Brightness   : {BRIGHTNESS_BETA}"
    )

    print("=" * 60)

    # ---------------------------------------------------------
    # CHECK VIDEO
    # ---------------------------------------------------------

    if not os.path.exists(args.video):

        print()
        print("❌ Video not found:")
        print(args.video)

        return

    # ---------------------------------------------------------
    # CHECK MODEL
    # ---------------------------------------------------------

    if not os.path.exists(MODEL_PATH):

        print()
        print("❌ Model not found:")
        print(MODEL_PATH)

        return

    # ---------------------------------------------------------
    # LOAD MODEL
    # ---------------------------------------------------------

    print()
    print("⏳ Loading model...")

    model = YOLO(
        MODEL_PATH
    )

    print("✅ Model loaded")

    print(
        f"Classes: {list(model.names.values())}"
    )

    # ---------------------------------------------------------
    # TARGET CLASS
    # ---------------------------------------------------------

    print()

    if TARGET_CLASS_ID in model.names:

        print(
            f"🎯 TARGET CLASS {TARGET_CLASS_ID}: "
            f"{model.names[TARGET_CLASS_ID]}"
        )

        print(
            "✅ Only this class will be displayed."
        )

    else:

        print("⚠️ WARNING:")

        print(
            f"Class ID {TARGET_CLASS_ID} "
            "does NOT exist in this model."
        )

        print(
            "Available class IDs:"
        )

        print(
            list(model.names.keys())
        )

    print()

    # ---------------------------------------------------------
    # RUN VIDEO
    # ---------------------------------------------------------

    run_video_detection(
        args.video,
        model
    )


# =============================================================
# ENTRY POINT
# =============================================================

if __name__ == "__main__":

    main()

import 'dart:io';
import 'package:code/Components/capture_prompt.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraVM {
  /// When this is true, the screen is still loading
  static bool isLoading = true;

  /// Menu option boolean variables
  ///
  /// (True when the option is enabled)
  static List<bool> optionStatus = [false, false, false];

  /// Camera controller variable
  static late CameraController controller;

  /// Main Camera / Selfie Camera Toggle variables
  static int selectedCameraIndex = 0;
  static bool isFrontCamera = false;

  /// Object Focus variables
  static Offset? focusPoint;

  /// Zoom variables
  static double currentZoom = 1.0;

  /// Captured Image File variable
  static File? capturedImage;

  /// Function to reset all parameters to their initial value
  static void dispose() {
    isLoading = true;
    optionStatus = [false, false, false];
    controller.dispose();
    selectedCameraIndex = 0;
    isFrontCamera = false;
    focusPoint = null;
    currentZoom = 1.0;
    capturedImage = null;
  }

  /// Function to toggle flashlight on and off
  static void toggleFlashlight() {
    optionStatus[2] = !optionStatus[2];

    if (optionStatus[2]) {
      controller.setFlashMode(FlashMode.torch);
    } else {
      controller.setFlashMode(FlashMode.off);
    }
  }

  /// Function responsible for toggling between the front camera and the back camera
  static Future switchCamera(List<CameraDescription> cameras) async {
    await controller.dispose();

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    CameraVM.controller =
        CameraController(cameras[selectedCameraIndex], ResolutionPreset.max);
    await CameraVM.controller.initialize();
    isFrontCamera = selectedCameraIndex == 1;
  }

  /// Function responsible for capturing pictures in the Camera View
  static Future capturePicture() async {
    if (!controller.value.isInitialized) {
      return;
    }

    if (controller.value.isTakingPicture) {
      return;
    }

    try {
      final XFile capturedFile = await controller.takePicture();
      final String imagePath = capturedFile.path;

      capturedImage = File(imagePath);
    } catch (e) {
      print('Image Not Saved!');
    }
  }

  /// Function to open the captured picture
  static void previewImage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CapturePrompt(),
      ),
    );
  }
}

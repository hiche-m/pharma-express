import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CamerasProvider extends ChangeNotifier {
  List<CameraDescription> cameras = [];
  bool? loadingCameras = true;

  Future getCameras() async {
    try {
      cameras = await availableCameras();
      loadingCameras = false;
    } on Exception catch (e) {
      print(e.toString());
      loadingCameras = null;
    }
    notifyListeners();
    return;
  }
}

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
final class ImagePickerService {
  /// MARK: Kamera iznini kontrol eder ve istenen izni sorar.
  Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      // Kullanıcıdan izin isteniyor
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return status.isGranted;
  }
}

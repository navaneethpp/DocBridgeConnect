import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  const PermissionService._();

  /// Returns true if camera permission is already granted.
  static Future<bool> hasCameraPermission() async {
    return Permission.camera.isGranted;
  }

  /// Requests camera permission.
  static Future<PermissionStatus>
  requestCameraPermission() async {
    return Permission.camera.request();
  }

  /// Open app settings.
  static Future<bool> openSettings() async {
    return openAppSettings();
  }
}

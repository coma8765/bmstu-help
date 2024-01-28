import 'package:flutter/cupertino.dart';

abstract class PermissionService {
  Future<void> requestPhotosPermission();

  Future<bool> handlePhotosPermission(BuildContext context);

  Future<void> requestExternalStoragePermission();

  Future<bool> handleExternalStoragePermission(BuildContext context);

  Future<void> requestCameraPermission();

  Future<bool> handleCameraPermission(BuildContext context);
}

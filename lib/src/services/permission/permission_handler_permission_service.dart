import 'package:bmstu_help/src/services/permission/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPermissionService implements PermissionService {
  @override
  Future<PermissionStatus> requestCameraPermission() {
    return Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() {
    return Permission.photos.request();
  }

  @override
  Future<bool> handleCameraPermission(BuildContext context) async {
    final cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      if (context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            title: Text('permission not granted'),
          ),
        );
      }
      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    final photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      if (context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) => const AlertDialog(
            title: Text('permission not granted'),
          ),
        );
      }
      return false;
    }
    return true;
  }

  @override
  Future<PermissionStatus> requestExternalStoragePermission() {
    return Permission.storage.request();
  }

  @override
  Future<bool> handleExternalStoragePermission(BuildContext context) async {
    if (await Permission.storage.status.isGranted) return true;

    return true;
  }
}

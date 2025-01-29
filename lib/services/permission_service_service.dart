import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vsc_acc/app/app.locator.dart';

class PermissionServiceService {
  PermissionServiceService() {
    _dialogService = locator<DialogService>();
  }

  late DialogService _dialogService;

  /// Requests storage/file permission
  Future<bool> requestFilePermission(Permission permission) async {
    // Permission permission = Platform.isIOS ? Permission.photos : Permission.storage;
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

    if (build.version.sdkInt >= 30) {
      var re = await Permission.manageExternalStorage.request();
      if (re.isGranted) {
        return true;
      } else {
        await _showDialog(
            "File access permission is required. Please enable it in your device's settings.");
      }
    } else {
      // PermissionStatus status = await permission.request();
      if (await permission.isGranted) {
        return true;
      } else {
        var status = await permission.request();
        if (status.isGranted) {
          return true;
        } else if (status.isPermanentlyDenied) {
          await _showDialog(
              "File access permission is required. Please enable it in your device's settings.");
        }
      }
    }

    return false;
  }

  Future<void> _showDialog(String description) async {
    final DialogResponse? dialogResponse =
        await _dialogService.showConfirmationDialog(
      title: 'Access Denied',
      description: description,
      confirmationTitle: 'Settings',
      cancelTitle: 'Cancel',
    );

    if (dialogResponse?.confirmed ?? false) {
      openAppSettings(); // Opens the device settings
    }
  }
}

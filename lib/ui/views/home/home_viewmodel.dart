import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vsc_acc/app/app.locator.dart';
import 'package:vsc_acc/core/navigate_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/services/permission_service_service.dart';
import 'package:vsc_acc/services/user_service.dart';
import 'package:share_plus/share_plus.dart';

class HomeViewModel extends BaseViewModel with NavigationMixin {
  HomeViewModel() {
    initFun();
  }

  initFun() async {
    checkFilePermission();
  }

  String get counterLabel => 'Counter is: $_counter';

  final UserService userService = UserService();
  final PermissionServiceService _permissionService =
      locator<PermissionServiceService>();

  bool? _filePermissionGranted;
  bool? get filePermissionGranted => _filePermissionGranted;

  int _counter = 0;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _file;

  void currentIndexs(index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> checkFilePermission() async {
    _filePermissionGranted =
        await _permissionService.requestFilePermission((Permission.storage));

    if (_filePermissionGranted!) {
      print("File access permission granted!");
    } else {
      print("File access permission denied.");
    }
    notifyListeners();
  }

  void donationCollection() {
    goToDonationCollection();
    notifyListeners();
  }

  void fundCollection() {
    goToFundCollection();
    notifyListeners();
  }

  void expenses() {
    goToExpenses();
    notifyListeners();
  }

  void ricebag() {
    goToRiceCollection();
    notifyListeners();
  }

  void availableFund() {
    goToAvailableFunds();
    notifyListeners();
  }

  void sponsors() {
    goToSponsors();
    notifyListeners();
  }

  void totalFunds() {
    goToToatalFunds();
    notifyListeners();
  }

  void exportDonation() {
    String tableName = 'donation';
    // exportTableToCSV(tableName);
    exportAndShareExcel(tableName);
    notifyListeners();
  }

  void exportFund() {
    String tableName = 'funds';
    exportAndShareExcel(tableName);
    // exportTableToCSV(tableName);
    notifyListeners();
  }

  void exportExpenses() {
    String tableName = 'expenses';
    exportAndShareExcel(tableName);
    // exportTableToCSV(tableName);
    notifyListeners();
  }

  void exportRice() {
    String tableName = 'rice';
    exportAndShareExcel(tableName);
    // exportTableToCSV(tableName);
    notifyListeners();
  }

  void exportsponsors() {
    String tableName = 'sponsors';
    exportAndShareExcel(tableName);
    // exportTableToCSV(tableName);
    notifyListeners();
  }

  Future<void> exportAndShareExcel(tableName) async {
    try {
      // Fetch data from the database
      List<Map<String, dynamic>> data =
          await userService.fetchAllDonations(tableName);

      // Export to Excel
      String filePath = await userService.exportDataToExcel(data, tableName);

      // Share the file
      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Here are the $tableName records.',
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}

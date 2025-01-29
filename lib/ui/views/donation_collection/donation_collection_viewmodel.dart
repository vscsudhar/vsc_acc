import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/app/app.locator.dart';
import 'package:vsc_acc/core/model/donation_model.dart';
import 'package:vsc_acc/core/navigate_mixin.dart';
import 'package:vsc_acc/services/permission_service_service.dart';
import 'package:vsc_acc/services/user_service.dart';
import 'package:intl/intl.dart';

class DonationCollectionViewModel extends BaseViewModel with NavigationMixin {
  DonationCollectionViewModel() {
    initialState();
    getDateUsers();
  }

  late final List<UserDonation> _userList = [];
  final _userService = UserService();
  final PermissionServiceService _permissionService =
      locator<PermissionServiceService>();

  final now = DateTime.now();
  DateTime? _fromDate;
  DateTime get fromDate =>
      _fromDate ?? DateTime.now(); //DateTime(now.year, now.month, 1);
  String get fDate => DateFormat('dd-MM-yyyy')
      .format(fromDate); //DateFormat('MM-dd-yyyy').format(fromDate);

  List<UserDonation> get userList => _userList ?? [];

  int _selectedYear = 0;
  List<int> _yearList = [];

  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;

  int get selectedYears => _selectedYear;
  List<int> get yearList => _yearList;

  int _currentYear = DateTime.now().year;
  int get currentYear => _currentYear;

  String? _search;
  DateTime? _sdate;
  DateTime get sdate => _sdate ?? DateTime.now();

  bool? _filePermissionGranted;
  bool? get filePermissionGranted => _filePermissionGranted;

  // List<String> get name => userList.map((e) => e.name.toString()).toSet().toList();
  // List<String> get date => userList.map((e) => e.date.toString()).toSet().toList();
  // List<String> get area => userList.map((e) => e.area.toString()).toSet().toList();
  // List<String> get amount => userList.map((e) => e.amount.toString()).toSet().toList();

  Future<void> getAllDonationUserDetails() async {
    _userList.clear();
    var users = await _userService.readAllUserDonation();
    users.forEach((user) {
      notifyListeners();
      var userModel = UserDonation();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.amount = user['amount'];
      userModel.area = user['area'];
      userModel.date = user['date'];
      _userList.add(userModel);
    });
  }

  Future<void> getDateUsers() async {
    _userList.clear();
    _totalAmount = 0.0;
    var users = await _userService.readYearDonation(_selectedYear);

    users.forEach((user) {
      notifyListeners();
      var userModel = UserDonation();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.area = user['area'];
      userModel.serialNo = user['serialNo'] ?? "";
      userModel.date =
          user['dateTime'] != null ? DateTime.tryParse(user['dateTime']) : null;
      userModel.amount = user['amount'];

      _totalAmount += userModel.amount ?? 0.0;

      _userList.add(userModel);
      print('userModel$userModel');
    });
    _userList.sort((a, b) => (a.amount ?? 0).compareTo(b.amount ?? 0));
  }

  void submitbutton() async {
    notifyListeners();
    await runBusyFuture(getDateUsers());
  }

  void initialState() {
    _yearList = List.generate(6, (index) => _currentYear - index);
    _selectedYear = _yearList.first;
    checkFilePermission();
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _sdate = pickedDate;
      notifyListeners();
    }
  }

  void selectedYear(int? value) {
    if (value != null) {
      _selectedYear = value;
      getDateUsers();
      notifyListeners();
    }
  }

  void addForm() {
    String donation = "Donation";
    goToAddForm(donation);
    notifyListeners();
  }

  void deleteDatas(id) async {
    var result = await _userService.deleteUserDonation(id);
    await getDateUsers();
    notifyListeners();
  }

  void searchTable(search) {
    _search = search;
    performSearch();
    notifyListeners();
  }

  String? filePath;

  Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );
    notifyListeners();

    if (result != null && result.files.single.path != null) {
      filePath = result.files.single.path;
      return filePath;
    } else {
      print("No file selected");
      return null;
    }
  }

  void checkFilePermission() async {
    _filePermissionGranted =
        await _permissionService.requestFilePermission(Permission.storage);

    if (_filePermissionGranted!) {
      print("File access permission granted!");
      // Proceed with file-related functionality
    } else {
      print("File access permission denied.");
      // Handle lack of permission
    }
    notifyListeners();
  }

  Future<void> importFile(String filePath, bool isCSV) async {
    UserService userService = UserService();
    List<UserDonation> users = [];

    // Retrieve existing serial numbers from the database
    Set<String> existingSerialNumbers =
        await userService.getExistingSerialNumbers('donation');

    List<List<dynamic>> data;

    try {
      if (isCSV) {
        // Read CSV file
        final csvFile = File(filePath);
        String csvString = await csvFile.readAsString();
        data = const CsvToListConverter().convert(csvString, eol: "\n");
      } else {
        // Read Excel file
        final bytes = File(filePath).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        var sheet = excel.tables[excel.tables.keys.first];
        if (sheet == null) {
          print("No data found in Excel sheet.");
          return;
        }
        data = sheet.rows;
      }

      // Process rows (skip header row)
      for (var i = 1; i < data.length; i++) {
        var row = data[i];

        // Extract the cell values from the row
        var serialNo = row[0]?.value?.toString().trim() ??
            '${now.year}${now.day.toString().padLeft(2, '0')}'
                '${now.hour.toString().padLeft(2, '0')}'
                '${now.millisecond.toString().padLeft(3, '0')}';
        // Serial number
        var name = row[1]?.value?.toString().trim() ?? ''; // Name
        var amount = double.tryParse(row[2].value?.toString() ?? '0'); // Amount
        var area = row[3]?.value?.toString().trim() ??
            'market'; // Area with default value

        // Check for empty or duplicate serial number in the database
        if (serialNo.isEmpty) {
          print("Skipping row with empty Serial No.");
          continue;
        }

        if (existingSerialNumbers.contains(serialNo)) {
          print("Duplicate serial number found in DB: $serialNo, skipping...");
          continue; // Skip if the serial number already exists in the database
        }

        // Validate and process the extracted data
        if (name.isNotEmpty && amount != null) {
          var user = UserDonation();
          user.serialNo = serialNo;
          user.name = name;
          user.amount = amount;
          user.area = area;
          user.date = DateTime.now(); // Use current DateTime directly

          users.add(user);
        }
      }

      // Save all users to the database
      if (users.isNotEmpty) {
        await userService.saveDonations(users);
        getDateUsers();
        print("File imported and data saved successfully.");
      } else {
        print("No valid data found to import.");
      }
    } catch (e) {
      print("Error importing file: $e");
    }
  }

  Future<void> selectAndProcessFile() async {
    bool permissionGranted =
        await _permissionService.requestFilePermission(Permission.storage);

    if (!permissionGranted) {
      print("Permission not granted");
      return;
    }

    String? filePath = await pickFile();

    if (filePath != null) {
      if (filePath.endsWith('.csv')) {
        print("The selected file is a CSV.");
        await importFile(filePath, true);
      } else if (filePath.endsWith('.xls') || filePath.endsWith('.xlsx')) {
        print("The selected file is an Excel file.");
        await importFile(filePath, false);
      } else {
        print("Unsupported file type selected.");
      }
    } else {
      print("No file selected");
    }
    notifyListeners();
  }

  void performSearch() async {
    _userList.clear();
    _totalAmount = 0;
    String query = _search!.trim();
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> results =
          await _userService.searchUserDonations(query);
      results.forEach((user) {
        notifyListeners();
        var userModel = UserDonation();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.area = user['area'];
        userModel.serialNo = user['serialNo'] ?? "";
        userModel.date = user['dateTime'] != null
            ? DateTime.tryParse(user['dateTime'])
            : null;
        userModel.amount = user['amount'];

        _totalAmount += userModel.amount ?? 0.0;

        _userList.add(userModel);
      });
      _userList.sort((a, b) => (a.amount ?? 0).compareTo(b.amount ?? 0));
    }
  }
}

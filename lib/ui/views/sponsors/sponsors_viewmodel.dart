import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/app/app.locator.dart';
import 'package:vsc_acc/core/model/sponsors_mdel.dart';
import 'package:vsc_acc/core/navigate_mixin.dart';
import 'package:vsc_acc/services/permission_service_service.dart';
import 'package:vsc_acc/services/user_service.dart';

class SponsorsViewModel extends BaseViewModel with NavigationMixin {
  SponsorsViewModel() {
    initialState();
    getDateUsers();
  }
  int _selectedYear = 0;
  List<int> _yearList = [];

  int get selectedYears => _selectedYear;
  List<int> get yearList => _yearList;

  int _currentYear = DateTime.now().year;
  int get currentYear => _currentYear;

  late final List<SponsorsModel> _userList = [];
  final _userService = UserService();
  final PermissionServiceService _permissionService =
      locator<PermissionServiceService>();

  String? _search;

  bool? _filePermissionGranted;
  bool? get filePermissionGranted => _filePermissionGranted;

  final now = DateTime.now();
  DateTime? _fromDate;
  DateTime get fromDate =>
      _fromDate ?? DateTime.now(); //DateTime(now.year, now.month, 1);
  String get fDate => DateFormat('dd-MM-yyyy')
      .format(fromDate); //DateFormat('MM-dd-yyyy').format(fromDate);

  List<SponsorsModel> get userList => _userList ?? [];

  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;

  Future<void> getAllDonationUserDetails() async {
    _userList.clear();
    var users = await _userService.readAllUserSponsors();
    users.forEach((user) {
      notifyListeners();
      var userModel = SponsorsModel();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.sponsorType = user['sponsorType'];
      userModel.sponsorItem = user['sponsorItem'];
      userModel.area = user['area'];
      userModel.date = user['date'];
      _userList.add(userModel);
    });
  }

  Future<void> getDateUsers() async {
    _userList.clear();
    var users = await _userService.readYearSponsors(_selectedYear);

    users.forEach((user) {
      var userModel = SponsorsModel();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.area = user['area'];
      userModel.date =
          user['dateTime'] != null ? DateTime.tryParse(user['dateTime']) : null;
      userModel.sponsorItem = user['sponsorItem'];
      userModel.sponsorType = user['sponsorType'];
      _userList.add(userModel);
      print('userModel$userModel');
      notifyListeners();
    });
    _userList.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
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

  void selectedYear(int? value) {
    if (value != null) {
      _selectedYear = value;
      getDateUsers();
      notifyListeners();
    }
  }

  void addForm() {
    String donation = "Sponsor";
    goToAddForm(donation);
    notifyListeners();
  }

  void deleteDatas(id) async {
    var result = await _userService.deleteUserSponsors(id);
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
    List<SponsorsViewModel> users = [];

    // Retrieve existing serial numbers from the database
    Set<String> existingSerialNumbers =
        await userService.getExistingSerialNumbers('sponsors');

    List<List<dynamic>> data;

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
      notifyListeners();
    }

    // Process rows (skip header row)
    for (var row in data.skip(1)) {
      // Extract the cell values from the `Data` objects
      var serialNo = row[0]?.value?.toString() ?? ''; // Serial number
      var name = row[1]?.value?.toString() ?? ''; // Name
      var area = row[2]?.value?.toString() ?? 'market'; // Amount
      var type = row[3]?.value?.toString() ?? ''; // Amount
      var item = row[4]?.value?.toString() ?? ''; // Amount
      // var type = double.tryParse(row[3]?.value?.toString() ?? '0'); // Area with default value

      // Current date and time
      var dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      if (existingSerialNumbers.contains(serialNo)) {
        print("Duplicate serial number found in DB: $serialNo, skipping...");
        continue; // Skip if the serial number already exists in the database
      }

      // Validate and process the extracted data
      if (name.isNotEmpty) {
        var user = SponsorsModel();
        if (serialNo.isNotEmpty) (user.id = int.tryParse(serialNo));
        user.name = name;
        user.area = area;
        user.sponsorItem = item;
        user.sponsorType = type;
        user.date = DateTime.parse(dateTime); // Convert string to DateTime
        users.add(user as SponsorsViewModel);
      }
    }

    // Save all users to database
    await userService.saveSponsors(users.cast<SponsorsModel>());
    getDateUsers();
    print("File imported and data saved successfully.");
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
    String query = _search!.trim();
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> results =
          await _userService.searchUserDonations(query);
      results.forEach((user) {
        notifyListeners();
        var userModel = SponsorsModel();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.area = user['area'];
        userModel.date = user['dateTime'] != null
            ? DateTime.tryParse(user['dateTime'])
            : null;
        userModel.sponsorItem = user['sponsorItem'];
        userModel.sponsorType = user['sponsorType'];

        // _totalAmount += userModel.kg ?? 0.0;

        _userList.add(userModel);
      });
      _userList.sort((a, b) => (a.area ?? '').compareTo(b.area ?? ''));
    }
  }
}

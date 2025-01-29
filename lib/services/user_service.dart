import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vsc_acc/core/db_helper/repository.dart';
import 'package:vsc_acc/core/model/donation_model.dart';
import 'package:vsc_acc/core/model/expenses_model.dart';
import 'package:vsc_acc/core/model/rice_collection_model.dart';
import 'package:vsc_acc/core/model/sponsors_mdel.dart';
import 'package:vsc_acc/core/model/users.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }

  //Save User
  saveUserDonation(UserDonation user) async {
    return await _repository.insertData('donation', user.userMap());
  }

  saveDonations(List<UserDonation> users) async {
    for (var user in users) {
      await saveUserDonation(user);
    }
  }

  saveUserFunds(User user) async {
    return await _repository.insertData('funds', user.userMap());
  }

  saveFunds(List<User> users) async {
    for (var user in users) {
      await saveUserFunds(user);
    }
  }

  saveUserExpenses(ExpensesModel user) async {
    return await _repository.insertData('expenses', user.userMap());
  }

  saveExpenses(List<ExpensesModel> users) async {
    for (var user in users) {
      await saveUserExpenses(user);
    }
  }

  saveUserRice(RiceCollectionModel user) async {
    return await _repository.insertData('rice', user.userMap());
  }

  saveRices(List<RiceCollectionModel> users) async {
    for (var user in users) {
      await saveUserRice(user);
    }
  }

  saveUserSponsors(SponsorsModel user) async {
    return await _repository.insertData('sponsors', user.userMap());
  }

  saveSponsors(List<SponsorsModel> users) async {
    for (var user in users) {
      await saveUserSponsors(user);
    }
  }

  //read All User

  readAllUserDonation() async {
    return await _repository.readData('donation');
  }

  readAllUserFunds() async {
    return await _repository.readData('funds');
  }

  readAllUserExpenses() async {
    return await _repository.readData('expenses');
  }

  readAllUserRice() async {
    return await _repository.readData('rice');
  }

  readAllUserSponsors() async {
    return await _repository.readData('sponsors');
  }

  //delete user
  deleteUserDonation(userId) async {
    return await _repository.deleteDataById('donation', userId);
  }

  deleteUserFunds(userId) async {
    return await _repository.deleteDataById('funds', userId);
  }

  deleteUserExpenses(userId) async {
    return await _repository.deleteDataById('expenses', userId);
  }

  deleteUserRice(userId) async {
    return await _repository.deleteDataById('rice', userId);
  }

  deleteUserSponsors(userId) async {
    return await _repository.deleteDataById('sponsors', userId);
  }

  deleteData() async {
    return await _repository.deleteDatas();
  }

  // read by date
  readDateDonation(date) async {
    return await _repository.readByDate('donation', date);
  }

  readDateFunds(date) async {
    return await _repository.readByDate('funds', date);
  }

  readDateRice(date) async {
    return await _repository.readByDate('rice', date);
  }

  readDateExpenses(date) async {
    return await _repository.readByDate('expenses', date);
  }

  readDateSponsors(date) async {
    return await _repository.readByDate('sponsors', date);
  }

  //read by year
  readYearDonation(year) async {
    return await _repository.readByYear('donation', year);
  }

  readYearFunds(year) async {
    return await _repository.readByYear('funds', year);
  }

  readYearRice(year) async {
    return await _repository.readByYear('rice', year);
  }

  readYearExpenses(year) async {
    return await _repository.readByYear('expenses', year);
  }

  readYearSponsors(year) async {
    return await _repository.readByYear('sponsors', year);
  }

  getExistingSerialNumbers(tableName) async {
    return await _repository.getExistingSerialNumbers(tableName);
  }

  // exportDonationTableToCSV() async {
  //   return await _repository.exportTableToCSV('donation');
  // }
  // exportFundsTableToCSV() async {
  //   return await _repository.exportTableToCSV('funds');
  // }
  // exportRiceTableToCSV() async {
  //   return await _repository.exportTableToCSV('rice');
  // }
  // exportExpensesTableToCSV() async {
  //   return await _repository.exportTableToCSV('expenses');
  // }
  // exportSponsorsTableToCSV() async {
  //   return await _repository.exportTableToCSV('sponsors');
  // }

  Future<String?> exportTableToCSVAndSave(String tableName) async {
    List<Map<String, dynamic>> tableData =
        await _repository.exportTableToCSV(tableName);
    if (tableData.isEmpty) {
      throw Exception("Table $tableName is empty.");
    }

    // Convert table data to CSV
    List<List<dynamic>> csvData = [
      tableData.first.keys.toList(), // Column headers
      ...tableData.map((row) => row.values.toList()), // Rows
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    // Use FilePicker to let the user choose the save location
    // String? filePath = await FilePicker.platform.saveFile(
    //   dialogTitle: "Save CSV File",
    //   fileName: '$tableName.csv',
    // );

    // if (filePath == null) {
    //   return null;
    // }

    // Save the CSV file to the selected location
    // final file = File(savePath);
    // await file.writeAsString(csv);

    // return savePath;
    // Save the CSV file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$tableName.csv';
    final file = File(filePath);
    await file.writeAsString(csv);

    return filePath;

    // return filePath;
  }

  Future<String?> exportCSVFile(String tableName) async {
    try {
      String? filePath = await exportTableToCSVAndSave(tableName);
      print('filePath$filePath');
      return filePath;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> shareCSVFileViaEmail(
      String tableName, String recipientEmail) async {
    try {
      String? filePath = await exportTableToCSVAndSave(tableName);

      final email = Email(
        body: 'Please find attached the CSV file for the $tableName table.',
        subject: 'CSV Export: $tableName',
        recipients: [recipientEmail],
        attachmentPaths: [filePath!],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> searchUserDonations(String query) async {
    return await _repository.searchData(
      'donation',
      query,
      ['id', 'dateTime', 'serialNo', 'name', 'area'],
    );
  }

  Future<List<Map<String, dynamic>>> fetchAllDonations(tableName) async {
    return await _repository.getAllData(tableName) ?? [];
  }

  Future<String> exportDataToCSV(List<Map<String, dynamic>> data) async {
    List<List<dynamic>> csvData = [
      data.first.keys.toList(),
      ...data.map((row) => row.values.toList())
    ];
    String csvString = const ListToCsvConverter().convert(csvData);

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/data.csv';
    final file = File(path);
    await file.writeAsString(csvString);

    return path;
  }

  Future<String> exportDataToExcel(
      List<Map<String, dynamic>> data, tableName) async {
    if (data.isEmpty) {
      throw Exception("No data available for export.");
    }

    // Convert list of maps to CSV data (header + rows)
    List<List<dynamic>> csvData = [];

    // Headers: Convert keys to list of strings
    csvData.add(data.first.keys.toList());

    // Rows: Convert values to list
    for (var row in data) {
      csvData.add(row.values.toList());
    }

    // Convert to CSV string
    String csv = const ListToCsvConverter().convert(csvData);

    // Save the CSV string to a file
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$tableName.csv';
    final file = File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(csv);

    print('CSV file saved at $path');
    return path; // Return file path
  }
}

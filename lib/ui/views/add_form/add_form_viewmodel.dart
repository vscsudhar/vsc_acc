import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/core/model/donation_model.dart';
import 'package:vsc_acc/core/model/expenses_model.dart';
import 'package:vsc_acc/core/model/rice_collection_model.dart';
import 'package:vsc_acc/core/model/sponsors_mdel.dart';
import 'package:vsc_acc/core/model/users.dart';
import 'package:vsc_acc/core/navigate_mixin.dart';
import 'package:vsc_acc/services/user_service.dart';

class AddFormViewModel extends BaseViewModel with NavigationMixin {
  AddFormViewModel(String value) {
    headerValue(value);
  }
  late String _header;
  String? _name;
  String? _serialNo;
  String? _area;
  String? _item;
  String? _purpose;
  double? _amount;
  double? _kg;
  String? _sponsorsType;
  String? _sponsorsItem;

  String get header => _header;
  DateTime _now = DateTime.now();

  DateTime get now => _now;

  final _userService = UserService();

  void headerValue(value) {
    _header = value;
    notifyListeners();
  }

  void nameAdd(name) {
    _name = name;
    notifyListeners();
  }

  void serialNoAdd(name) {
    _serialNo = name;
    notifyListeners();
  }

  void areaAdd(area) {
    _area = area;
    notifyListeners();
  }

  void amountAdd(amount) {
    _amount = amount;
    notifyListeners();
  }

  void sponsorAdd(amount) {
    _amount = amount;
    notifyListeners();
  }

  void riceAdd(kg) {
    _kg = kg;
    notifyListeners();
  }

  void sponsorsItemAdd(item) {
    _sponsorsItem = item;
    notifyListeners();
  }

  void sponsorsTypeAdd(type) {
    _sponsorsType = type;
    notifyListeners();
  }

  void itemAdd(type) {
    _item = type;
    notifyListeners();
  }

  void purposeAdd(type) {
    _purpose = type;
    notifyListeners();
  }

  Future<void> submitdonationData() async {
    notifyListeners();
    var user = UserDonation();
    user.serialNo = _serialNo;
    user.name = _name;
    user.area = _area;
    user.amount = _amount;
    user.date = DateTime.tryParse(_now.toIso8601String());
    var result = await _userService.saveUserDonation(user);
    print('result$result');

    notifyListeners();
  }

  Future<void> submitFundData() async {
    notifyListeners();
    var user = User();
    user.date = DateTime.tryParse(_now.toIso8601String()); // formattedTime;
    user.area = _area;
    user.name = _name;
    user.amount = _amount;
    var result = await _userService.saveUserFunds(user);
    print('result$result');

    notifyListeners();
  }

  Future<void> submitRiceData() async {
    notifyListeners();
    var riceCollection = RiceCollectionModel();
    riceCollection.date =
        DateTime.tryParse(_now.toIso8601String()); // formattedTime;
    riceCollection.area = _area;
    riceCollection.name = _name;
    riceCollection.kg = _kg;
    var result = await _userService.saveUserRice(riceCollection);
    print('result$result');

    notifyListeners();
  }

  Future<void> submitSponsorData() async {
    notifyListeners();
    var sponsors = SponsorsModel();
    sponsors.date = DateTime.tryParse(_now.toIso8601String()); // formattedTime;
    sponsors.area = _area;
    sponsors.name = _name;
    sponsors.sponsorItem = _sponsorsItem;
    sponsors.sponsorType = _sponsorsType;
    var result = await _userService.saveUserSponsors(sponsors);
    print('result$result');

    notifyListeners();
  }

  Future<void> submitExpensesData() async {
    notifyListeners();
    var sponsors = ExpensesModel();
    sponsors.date = DateTime.tryParse(_now.toIso8601String()); // formattedTime;
    sponsors.item = _item;
    sponsors.purpose = _purpose;
    sponsors.amount = _amount;
    var result = await _userService.saveUserExpenses(sponsors);
    print('result$result');

    notifyListeners();
  }

  Future<void> submit(context) async {
    if (header == 'Donation') {
      await submitdonationData();
      goToHome();
      goToDonationCollection();
    } else if (header == 'Fund') {
      await submitFundData();
      goToHome();
      goToFundCollection();
    } else if (header == 'Expenses') {
      submitExpensesData();
      goToHome();
      goToExpenses();
    } else if (header == 'Rice') {
      submitRiceData();
      goToHome();
      goToRiceCollection();
    } else if (header == 'Sponsor') {
      submitSponsorData();
      goToHome();
      goToSponsors();
    }
  }
}

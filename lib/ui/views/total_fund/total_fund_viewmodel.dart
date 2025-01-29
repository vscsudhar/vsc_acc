import 'package:stacked/stacked.dart';
import 'package:vsc_acc/core/model/sponsors_mdel.dart';
import 'package:vsc_acc/core/model/users.dart';
import 'package:vsc_acc/core/navigate_mixin.dart';
import 'package:vsc_acc/services/user_service.dart';

class TotalFundViewModel extends BaseViewModel with NavigationMixin {
  TotalFundViewModel() {
    totalAmount();
  }

  late final List<SponsorsModel> _sponsorList = [];
  List<SponsorsModel> get sponsorList => _sponsorList ?? [];

  late final List<User> _donationList = [];
  List<User> get donationList => _donationList ?? [];

  late final List<User> _fundList = [];
  List<User> get fundList => _fundList ?? [];

  final _userService = UserService();

  late final bool _filePermissionGranted;
  bool get filePermissionGranted => _filePermissionGranted;

  double _totalDonationAmount = 0.0;
  double get totalDonationAmount => _totalDonationAmount;
  double _totalFunfAmount = 0.0;
  double get totalFunfAmount => _totalFunfAmount;

  Future<void> getAllDonationUserDetails() async {
    _donationList.clear();
    _totalDonationAmount = 0.0;
    var users = await _userService.readAllUserDonation();
    users.forEach((user) {
      notifyListeners();
      var userModel = User();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.amount = double.tryParse("${user['amount']}");
      userModel.area = user['area'];
      userModel.date = user['date'];

      _totalDonationAmount += userModel.amount ?? 0.0;
      _donationList.add(userModel);
    });
  }

  Future<void> getAllFundUserDetails() async {
    _donationList.clear();
    _totalFunfAmount = 0.0;
    var users = await _userService.readAllUserFunds();
    users.forEach((user) {
      notifyListeners();
      var userModel = User();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.amount = double.tryParse("${user['amount']}");
      userModel.area = user['area'];
      userModel.date = user['date'];

      _totalFunfAmount += userModel.amount ?? 0.0;
      _donationList.add(userModel);
    });
  }

  double _totalAmt = 0.0;
  double get totalAmt => _totalAmt;
  Future<void> totalAmount() async {
    await getAllDonationUserDetails();
    await getAllFundUserDetails();
    _totalAmt = _totalFunfAmount + _totalDonationAmount;
    notifyListeners();
  }
}

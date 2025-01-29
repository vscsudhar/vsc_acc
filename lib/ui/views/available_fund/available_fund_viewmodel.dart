import 'package:stacked/stacked.dart';
import 'package:vsc_acc/core/model/expenses_model.dart';
import 'package:vsc_acc/core/model/users.dart';
import 'package:vsc_acc/core/navigate_mixin.dart';
import 'package:vsc_acc/services/user_service.dart';

class AvailableFundViewModel extends BaseViewModel with NavigationMixin {
  AvailableFundViewModel() {
    totalAmount();
  }

  late final List<ExpensesModel> _expensesList = [];
  List<ExpensesModel> get sponsorList => _expensesList ?? [];

  late final List<User> _donationList = [];
  List<User> get donationList => _donationList ?? [];

  late final List<User> _fundList = [];
  List<User> get fundList => _fundList ?? [];

  final _userService = UserService();

  double _totalDonationAmount = 0.0;
  double get totalDonationAmount => _totalDonationAmount;
  double _totalFunfAmount = 0.0;
  double get totalFunfAmount => _totalFunfAmount;
  double _totalExpensesAmount = 0.0;
  double get totalExpensesAmount => _totalExpensesAmount;

  Future<void> getAllEpensesDetails() async {
    _expensesList.clear();
    _totalExpensesAmount = 0.0;
    var users = await _userService.readAllUserExpenses();
    users.forEach((user) {
      notifyListeners();
      var userModel = ExpensesModel();
      userModel.id = user['id'];
      userModel.amount = double.tryParse("${user['amount']}");
      userModel.date = user['date'];

      _totalExpensesAmount += userModel.amount ?? 0.0;
      _expensesList.add(userModel);
    });
  }

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
  double _totalavailableAmt = 0.0;
  double get totalavailableAmt => _totalavailableAmt;
  Future<void> totalAmount() async {
    await getAllDonationUserDetails();
    await getAllFundUserDetails();
    await getAllEpensesDetails();
    _totalAmt = _totalFunfAmount + _totalDonationAmount;
    _totalavailableAmt = _totalAmt - _totalExpensesAmount;
    notifyListeners();
  }
}

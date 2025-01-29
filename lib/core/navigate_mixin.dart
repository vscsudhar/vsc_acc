import 'package:stacked_services/stacked_services.dart';
import 'package:vsc_acc/app/app.locator.dart';
import 'package:vsc_acc/app/app.router.dart';

mixin NavigationMixin {
  final NavigationService _navigationService = locator<NavigationService>();

  void goToHome() => _navigationService.clearStackAndShow(Routes.homeView);
  void goToAvailableFunds() =>
      _navigationService.navigateTo(Routes.availableFundView);
  void goToDonationCollection() =>
      _navigationService.navigateTo(Routes.donationCollectionView);
  void goToExpenses() => _navigationService.navigateTo(Routes.expensesView);
  void goToFundCollection() =>
      _navigationService.navigateTo(Routes.fundCollectionView);
  void goToRiceCollection() =>
      _navigationService.navigateTo(Routes.riceCollectionView);
  void goToSponsors() => _navigationService.navigateTo(Routes.sponsorsView);
  void goToToatalFunds() => _navigationService.navigateTo(Routes.totalFundView);
  void goToAddForm(String value) =>
      _navigationService.navigateTo(Routes.addFormView,
          arguments: AddFormViewArguments(value: value));
  void goToBack() => _navigationService.popRepeated(0);
}

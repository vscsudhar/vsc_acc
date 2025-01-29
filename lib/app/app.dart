import 'package:vsc_acc/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:vsc_acc/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:vsc_acc/ui/views/home/home_view.dart';
import 'package:vsc_acc/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vsc_acc/ui/views/donation_collection/donation_collection_view.dart';
import 'package:vsc_acc/ui/views/fund_collection/fund_collection_view.dart';
import 'package:vsc_acc/ui/views/expenses/expenses_view.dart';
import 'package:vsc_acc/ui/views/rice_collection/rice_collection_view.dart';
import 'package:vsc_acc/ui/views/available_fund/available_fund_view.dart';
import 'package:vsc_acc/ui/views/sponsors/sponsors_view.dart';
import 'package:vsc_acc/ui/views/total_fund/total_fund_view.dart';
import 'package:vsc_acc/ui/views/add_form/add_form_view.dart';
import 'package:vsc_acc/services/permission_service_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: DonationCollectionView),
    MaterialRoute(page: FundCollectionView),
    MaterialRoute(page: ExpensesView),
    MaterialRoute(page: RiceCollectionView),
    MaterialRoute(page: AvailableFundView),
    MaterialRoute(page: SponsorsView),
    MaterialRoute(page: TotalFundView),
    MaterialRoute(page: AddFormView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: PermissionServiceService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

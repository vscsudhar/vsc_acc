import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/ui/common/shared/styles.dart';
import 'package:vsc_acc/ui/common/shared/text_style_helpers.dart';
import 'package:vsc_acc/ui/common/widgets/box.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: appcolorFF7612,
        actions: [
          if (viewModel.filePermissionGranted == true)
            Padding(
              padding: defaultPadding12,
              child: PopupMenuButton<String>(
                icon: Icon(Icons.share),
                onSelected: (value) async {
                  // Handle the selected value
                  switch (value) {
                    case 'Donation':
                      viewModel.exportDonation();
                      break;
                    case 'Funds':
                      viewModel.exportFund();
                      break;
                    case 'Rice':
                      viewModel.exportRice();
                      break;
                    case 'Expenses':
                      viewModel.exportExpenses();
                      break;
                    case 'Sponsors':
                      viewModel.exportsponsors();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Donation',
                    child: Text('Export Donation Table'),
                  ),
                  PopupMenuItem(
                    value: 'Funds',
                    child: Text('Export Funds Table'),
                  ),
                  PopupMenuItem(
                    value: 'Rice',
                    child: Text('Export Rice Table'),
                  ),
                  PopupMenuItem(
                    value: 'Expenses',
                    child: Text('Export Expenses Table'),
                  ),
                  PopupMenuItem(
                    value: 'Sponsors',
                    child: Text('Export Sponsors Table'),
                  ),
                ],
              ),
            ),
        ],
        title: Text(
          'Dashboard',
          style: fontFamilyMedium.size28.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultPadding12,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Box(
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            onTap: () => viewModel.donationCollection(),
                            child: Column(
                              children: [
                                Text(
                                  'Donation collection',
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/donation_collecting.png',
                                  width: 50,
                                  height: 60,
                                ),
                              ],
                            )),
                      ),
                      horizontalSpacing12,
                      Expanded(
                        child: Box(
                            onTap: () => viewModel.fundCollection(),
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            child: Column(
                              children: [
                                Text(
                                  "Fund \ncollection",
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/fund_collecting.png',
                                  width: 50,
                                  height: 60,
                                ),
                                horizontalSpacing20,
                              ],
                            )),
                      ),
                    ],
                  ),
                  verticalSpacing12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Box(
                            onTap: () => viewModel.expenses(),
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            child: Column(
                              children: [
                                Text(
                                  'Expenses',
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/expenses.png',
                                  width: 50,
                                  height: 60,
                                ),
                              ],
                            )),
                      ),
                      horizontalSpacing12,
                      Expanded(
                        child: Box(
                            onTap: () => viewModel.ricebag(),
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            child: Column(
                              children: [
                                Text(
                                  "Rice collection",
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/rice_bag.png',
                                  width: 50,
                                  height: 60,
                                ),
                                horizontalSpacing20,
                              ],
                            )),
                      ),
                    ],
                  ),
                  verticalSpacing12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Box(
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            onTap: () => viewModel.totalFunds(),
                            child: Column(
                              children: [
                                Text(
                                  'Total fund',
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/total_funds.png',
                                  width: 50,
                                  height: 60,
                                ),
                              ],
                            )),
                      ),
                      horizontalSpacing12,
                      Expanded(
                        child: Box(
                            onTap: () => viewModel.availableFund(),
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            child: Column(
                              children: [
                                Text(
                                  "Available fund",
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/balance_fund.png',
                                  width: 50,
                                  height: 60,
                                ),
                                horizontalSpacing20,
                              ],
                            )),
                      ),
                    ],
                  ),
                  verticalSpacing12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Box(
                            boxColor: appcolorFF7612,
                            margin: zeroPadding,
                            padding: defaultPadding12,
                            onTap: () => viewModel.sponsors(),
                            child: Column(
                              children: [
                                Text(
                                  'Sponsors',
                                  style: fontFamilyBold.size18,
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  'assets/images/sponsors.png',
                                  width: 50,
                                  height: 60,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

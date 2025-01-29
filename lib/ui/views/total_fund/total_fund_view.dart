import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/ui/common/shared/styles.dart';
import 'package:vsc_acc/ui/common/shared/text_style_helpers.dart';

import 'total_fund_viewmodel.dart';

class TotalFundView extends StackedView<TotalFundViewModel> {
  const TotalFundView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TotalFundViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Total funds"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Donation'),
                Text("${viewModel.totalDonationAmount}"),
              ],
            ),
            verticalSpacing10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total fund'),
                Text('${viewModel.totalFunfAmount}'),
              ],
            ),
            verticalSpacing10,
            SizedBox(height: 5, child: horizontalDivider),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${viewModel.totalAmt}',
                  style: fontFamilyBold.size14,
                ),
              ],
            ),
            verticalSpacing10,
            SizedBox(height: 5, child: horizontalDivider),
          ],
        ),
      ),
    );
  }

  @override
  TotalFundViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TotalFundViewModel();
}

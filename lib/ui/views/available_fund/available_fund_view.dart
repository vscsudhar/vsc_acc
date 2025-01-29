import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/ui/common/shared/styles.dart';
import 'package:vsc_acc/ui/common/shared/text_style_helpers.dart';

import 'available_fund_viewmodel.dart';

class AvailableFundView extends StackedView<AvailableFundViewModel> {
  const AvailableFundView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AvailableFundViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available funds"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Funds'),
                  Text('${viewModel.totalAmt}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total expenses'),
                  Text('${viewModel.totalExpensesAmount}'),
                ],
              ),
              verticalSpacing10,
              SizedBox(height: 5, child: horizontalDivider),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${viewModel.totalavailableAmt}',
                      style: fontFamilyBold.size14),
                ],
              ),
              SizedBox(height: 5, child: horizontalDivider),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AvailableFundViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AvailableFundViewModel();
}

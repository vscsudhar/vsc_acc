import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/ui/common/shared/styles.dart';
import 'package:vsc_acc/ui/common/shared/text_style_helpers.dart';

import 'rice_collection_viewmodel.dart';

class RiceCollectionView extends StackedView<RiceCollectionViewModel> {
  const RiceCollectionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RiceCollectionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Rice collection',
          style: fontFamilyMedium.size18.black,
        ),
        actions: [
          InkWell(
              onTap: () => viewModel.addForm(),
              child: const Padding(
                padding: defaultPadding12,
                child: Row(
                  children: [Icon(Icons.add), Text('Add rice')],
                ),
              ))
        ],
      ),
      body: Container(
        padding: defaultPadding12,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: defaultPadding12,
                    child: TextField(
                      onSubmitted: (value) => (value.isNotEmpty)
                          ? viewModel.searchTable(value)
                          : viewModel.getDateUsers(),
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: defaultPadding12 - topPadding12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              defaultPadding12 - topPadding12 - bottomPadding10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appcolorFF7612),
                          child: DropdownButton<int>(
                            hint: Text("${viewModel.currentYear}"),
                            value: viewModel.selectedYears,
                            items: viewModel.yearList.map((year) {
                              return DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              );
                            }).toList(),
                            onChanged: (value) => viewModel.selectedYear(value),
                            icon: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                        if (viewModel.filePermissionGranted == true)
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(appcolorFF7612),
                              ),
                              onPressed: () {
                                viewModel.selectAndProcessFile();
                              },
                              child: Text(
                                'import',
                                style: TextStyle(color: Colors.black87),
                              ))
                      ],
                    ),
                  ),
                  viewModel.userList.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                              itemBuilder: (context, index) => Card(
                                  surfaceTintColor: appcolorFF7612,
                                  child: Padding(
                                    padding: defaultPadding12,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Name: ${viewModel.userList[index].name}'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Date: ${viewModel.userList[index].date != null ? DateFormat('dd MMM yyyy').format(viewModel.userList[index].date!) : 'No Date'}',
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Confirm Deletion'),
                                                        content: const Text(
                                                            'Are you sure you want to delete this rices?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close dialog
                                                            },
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              // Perform delete action
                                                              viewModel.deleteDatas(
                                                                  viewModel
                                                                      .userList[
                                                                          index]
                                                                      .id);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close dialog
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      'Message deleted'),
                                                                ),
                                                              );
                                                            },
                                                            child: const Text(
                                                                'Delete'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Area:${viewModel.userList[index].area}'),
                                            Text(
                                              'Kg: ${viewModel.userList[index].kg}',
                                              style: fontFamilyBold.size12,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                              itemCount: viewModel.userList.length),
                        )
                      : const Center(child: Text("No record found"))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: appcolorFF7612.withOpacity(.3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: defaultPadding10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total KG', style: fontFamilyBold.size14),
                        Text(
                          "${viewModel.totalAmount} KG",
                          style: fontFamilyBold.size14,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  RiceCollectionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RiceCollectionViewModel();
}

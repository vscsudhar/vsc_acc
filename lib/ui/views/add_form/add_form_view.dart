import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vsc_acc/ui/common/shared/styles.dart';

import 'add_form_viewmodel.dart';

class AddFormView extends StackedView<AddFormViewModel> {
  final String value;
  const AddFormView({required this.value, Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget builder(
    BuildContext context,
    AddFormViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(viewModel.header),
      ),
      body: Container(
        padding: leftPadding10 + rightPadding10,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          (viewModel.header == "Expenses") ? 'Item' : 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return (viewModel.header == "Expenses")
                            ? "Please enter expenses item"
                            : 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) => (viewModel.header == "Expenses")
                        ? viewModel.itemAdd(value)
                        : viewModel.nameAdd(value),
                  ),
                  if ((viewModel.header == "Donation"))
                    const SizedBox(height: 16),
                  if ((viewModel.header == "Donation"))
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Serial number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter donation serialNo";
                        }
                        return null;
                      },
                      onChanged: (value) => viewModel.serialNoAdd(value),
                    ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          (viewModel.header == "Expenses") ? 'Purpose' : 'Area',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return (viewModel.header == "Expenses")
                            ? "Please Enter purpose of expenses"
                            : 'Please enter an area';
                      }
                      return null;
                    },
                    onChanged: (area) => (viewModel.header == "Expenses")
                        ? viewModel.purposeAdd(area)
                        : viewModel.areaAdd(area),
                  ),
                  if (viewModel.header == "Sponsor") const SizedBox(height: 16),
                  if (viewModel.header == "Sponsor")
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Sponsors type',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an Sponsors type';
                        }
                        return null;
                      },
                      onChanged: (amount) => viewModel.sponsorsTypeAdd(amount),
                    ),
                  const SizedBox(height: 16),
                  (viewModel.header == "Sponsor")
                      ? TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Sponsors item',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an Sponsors item';
                            }
                            return null;
                          },
                          onChanged: (amount) =>
                              viewModel.sponsorsItemAdd(amount),
                        )
                      : TextFormField(
                          decoration: InputDecoration(
                            labelText:
                                (viewModel.header == "Rice") ? "KG" : 'Amount',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return (viewModel.header == "Rice")
                                  ? 'Please enter rice Kg'
                                  : 'Please enter an amount';
                            }
                            if (double.tryParse(value) == null) {
                              return (viewModel.header == "Rice")
                                  ? 'Please enter valid Kg'
                                  : 'Please enter a valid number';
                            }
                            return null;
                          },
                          onChanged: (amount) => (viewModel.header == "Rice")
                              ? viewModel.riceAdd(double.tryParse(amount))
                              : viewModel
                                  .amountAdd(double.tryParse(amount) ?? 0),
                        ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(appcolorFF7612),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          viewModel.submit(context);
                          _formKey.currentState?.reset();
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
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
  AddFormViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddFormViewModel(value);
}

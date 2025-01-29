class ExpensesModel {
  int? id;
  String? purpose;
  String? item;
  DateTime? date;
  double? amount;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['purpose'] = purpose!;
    mapping['item'] = item!;
    mapping['amount'] = amount!;
    mapping['dateTime'] = date?.toIso8601String();

    return mapping;
  }
}

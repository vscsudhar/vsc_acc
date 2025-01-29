class UserDonation {
  int? id;
  String? name;
  String? area;
  String? serialNo;
  // String? item;
  // double? kg;
  double? amount;
  DateTime? date;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['area'] = area!;
    mapping['serialNo'] = serialNo!;
    // mapping['item'] = item?? null;
    // mapping['kg'] = kg??null;
    mapping['amount'] = amount!;
    mapping['dateTime'] = date?.toIso8601String();

    return mapping;
  }
}

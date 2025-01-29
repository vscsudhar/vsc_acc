class SponsorsModel {
  int? id;
  String? name;
  String? area;
  String? sponsorItem;
  String? sponsorType;
  DateTime? date;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['area'] = area!;
    mapping['sponsorItem'] = sponsorItem!;
    mapping['sponsorType'] = sponsorType!;
    mapping['dateTime'] = date?.toIso8601String();

    return mapping;
  }
}

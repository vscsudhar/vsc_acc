class RiceCollectionModel {
  int? id;
  String? name;
  String? area;
  double? kg;
  DateTime? date;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['area'] = area!;
    mapping['kg'] = kg!;
    mapping['dateTime'] = date?.toIso8601String();

    return mapping;
  }
}

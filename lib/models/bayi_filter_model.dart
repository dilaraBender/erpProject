class BayiFilter {
  final String? name;
  final String? city;
  final String? status;

  BayiFilter({this.name, this.city, this.status});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (name != null && name!.isNotEmpty) data['name'] = name;
    if (city != null && city!.isNotEmpty) data['city'] = city;
    if (status != null && status!.isNotEmpty) data['status'] = status;

    return data;
  }
}

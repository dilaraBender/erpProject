class CustomerFilterModel {
  final String? search;
  final String? status;

  CustomerFilterModel({this.search, this.status});

  Map<String, dynamic> toJson() {
    return {
      if (search != null) "search": search,
      if (status != null) "status": status,
    };
  }
}

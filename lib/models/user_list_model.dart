class UserListModel {
  final String? role;
  final String? status;

  UserListModel({this.role, this.status});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (role != null && role!.isNotEmpty) data['role'] = role;
    if (status != null && status!.isNotEmpty) data['status'] = status;
    return data;
  }
}

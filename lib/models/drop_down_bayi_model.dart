class DropDownBayiModel {
  final int bayiId;
  final String title;

  DropDownBayiModel({required this.bayiId, required this.title});
  factory DropDownBayiModel.fromJson(Map<String, dynamic> json) {
    return DropDownBayiModel(bayiId: json['bayiId'], title: json['title']);
  }
}

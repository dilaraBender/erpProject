class DropDownBuildingModel {
  final int buildingId;
  final String title;

  DropDownBuildingModel({required this.buildingId, required this.title});
  factory DropDownBuildingModel.fromJson(Map<String, dynamic> json) {
    return DropDownBuildingModel(
      buildingId: json['buildingId'],
      title: json['title'],
    );
  }
}

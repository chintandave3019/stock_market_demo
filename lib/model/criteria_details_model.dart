class CriteriaDetailModel {
  final String type;
  final String text;

  CriteriaDetailModel({required this.type, required this.text});

  factory CriteriaDetailModel.fromJson(Map<String, dynamic> json) {
    return CriteriaDetailModel(
      type: json['type'],
      text: json['text'],
    );
  }
}
import 'package:fitpage_test/model/criteria_details_model.dart';

class CriteriaModel {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<CriteriaDetailModel> criteria;

  CriteriaModel({required this.id, required this.name, required this.tag, required this.color, required this.criteria});

  factory CriteriaModel.fromJson(Map<String, dynamic> json) {
    var criteriaList = json['criteria'] as List;
    List<CriteriaDetailModel> criteriaDetails = criteriaList.map((i) => CriteriaDetailModel.fromJson(i)).toList();

    return CriteriaModel(
      id: json['id'],
      name: json['name'],
      tag: json['tag'],
      color: json['color'],
      criteria: criteriaDetails,
    );
  }
}
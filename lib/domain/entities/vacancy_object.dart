import 'package:json_annotation/json_annotation.dart';
import 'package:solyanka/domain/entities/vacancy.dart';

part 'vacancy_object.g.dart';

@JsonSerializable(explicitToJson: true)
class VacancyObject {
  final Vacancy vacancy;

  VacancyObject({required this.vacancy});
  factory VacancyObject.fromJson(Map<String, dynamic> json) =>
      _$VacancyObjectFromJson(json);
  Map<String, dynamic> toJson() => _$VacancyObjectToJson(this);
}

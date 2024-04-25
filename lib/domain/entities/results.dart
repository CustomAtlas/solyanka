import 'package:json_annotation/json_annotation.dart';
import 'package:solyanka/domain/entities/vacancy_object.dart';

part 'results.g.dart';

@JsonSerializable(explicitToJson: true)
class Results {
  final List<VacancyObject> vacancies;

  Results({required this.vacancies});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

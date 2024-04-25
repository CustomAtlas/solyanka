import 'package:json_annotation/json_annotation.dart';
import 'package:solyanka/domain/entities/addresses.dart';
import 'package:solyanka/domain/entities/category.dart';
import 'package:solyanka/domain/entities/company.dart';
import 'package:solyanka/domain/entities/region.dart';

part 'vacancy.g.dart';

@JsonSerializable(explicitToJson: true)
class Vacancy {
  final String id;
  final Region region;
  final Company company;
  @JsonKey(name: 'salary_min')
  final int salaryMin;
  @JsonKey(name: 'salary_max')
  final int salaryMax;
  @JsonKey(name: 'job-name')
  final String jobName;
  final String employment;
  final String schedule;
  final String duty;
  final Category category;
  final Addresses addresses;
  final String currency;

  Vacancy({
    required this.id,
    required this.region,
    required this.company,
    required this.salaryMin,
    required this.salaryMax,
    required this.jobName,
    required this.employment,
    required this.schedule,
    required this.duty,
    required this.category,
    required this.addresses,
    required this.currency,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) =>
      _$VacancyFromJson(json);
  Map<String, dynamic> toJson() => _$VacancyToJson(this);
}

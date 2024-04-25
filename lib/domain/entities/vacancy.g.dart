// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vacancy _$VacancyFromJson(Map<String, dynamic> json) => Vacancy(
      id: json['id'] as String,
      region: Region.fromJson(json['region'] as Map<String, dynamic>),
      company: Company.fromJson(json['company'] as Map<String, dynamic>),
      salaryMin: json['salary_min'] as int,
      salaryMax: json['salary_max'] as int,
      jobName: json['job-name'] as String,
      employment: json['employment'] as String,
      schedule: json['schedule'] as String,
      duty: json['duty'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      addresses: Addresses.fromJson(json['addresses'] as Map<String, dynamic>),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$VacancyToJson(Vacancy instance) => <String, dynamic>{
      'id': instance.id,
      'region': instance.region.toJson(),
      'company': instance.company.toJson(),
      'salary_min': instance.salaryMin,
      'salary_max': instance.salaryMax,
      'job-name': instance.jobName,
      'employment': instance.employment,
      'schedule': instance.schedule,
      'duty': instance.duty,
      'category': instance.category.toJson(),
      'addresses': instance.addresses.toJson(),
      'currency': instance.currency,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacancy_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacancyObject _$VacancyObjectFromJson(Map<String, dynamic> json) =>
    VacancyObject(
      vacancy: Vacancy.fromJson(json['vacancy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VacancyObjectToJson(VacancyObject instance) =>
    <String, dynamic>{
      'vacancy': instance.vacancy.toJson(),
    };

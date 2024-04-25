// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyResponse _$MyResponseFromJson(Map<String, dynamic> json) => MyResponse(
      results: Results.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyResponseToJson(MyResponse instance) =>
    <String, dynamic>{
      'results': instance.results.toJson(),
    };

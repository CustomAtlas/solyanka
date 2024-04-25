import 'package:json_annotation/json_annotation.dart';
import 'package:solyanka/domain/entities/results.dart';

part 'response.g.dart';

@JsonSerializable(explicitToJson: true)
class MyResponse {
  final Results results;

  MyResponse({required this.results});

  factory MyResponse.fromJson(Map<String, dynamic> json) =>
      _$MyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'region.g.dart';

@JsonSerializable(explicitToJson: true)
class Region {
  final String name;

  Region({required this.name});

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

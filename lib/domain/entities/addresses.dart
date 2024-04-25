import 'package:json_annotation/json_annotation.dart';
import 'package:solyanka/domain/entities/address.dart';

part 'addresses.g.dart';

@JsonSerializable(explicitToJson: true)
class Addresses {
  final List<Address> address;

  Addresses({required this.address});

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);
  Map<String, dynamic> toJson() => _$AddressesToJson(this);
}

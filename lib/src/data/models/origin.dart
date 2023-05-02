import 'package:json_annotation/json_annotation.dart';

part 'origin.g.dart';

@JsonSerializable()
class Origin {
  final String? id;
  final String? dimension;
  final DateTime? created;

  Origin({
    required this.id,
    required this.dimension,
    required this.created,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);

  Map<String, dynamic> toJson() => _$OriginToJson(this);
}

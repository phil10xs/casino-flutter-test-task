import 'package:casino_test/src/data/models/origin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final String name;
  final String image;
  final String gender;
  final String species;
  final String status;
  final String id;
  final DateTime created;
  final Origin origin;

  Character({
    required this.name,
    required this.image,
    required this.gender,
    required this.species,
    required this.status,
    required this.id,
    required this.created,
    required this.origin,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

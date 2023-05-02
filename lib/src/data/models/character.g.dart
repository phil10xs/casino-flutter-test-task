// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      image: json['image'] as String,
      gender: json['gender'] as String,
      species: json['species'] as String,
      status: json['status'] as String,
      id: json['id'] as String,
      created: DateTime.parse(json['created'] as String),
      origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'gender': instance.gender,
      'species': instance.species,
      'status': instance.status,
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'origin': instance.origin,
    };

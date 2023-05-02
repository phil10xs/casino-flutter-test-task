// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'origin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Origin _$OriginFromJson(Map<String, dynamic> json) => Origin(
      id: json['id'] as String?,
      dimension: json['dimension'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$OriginToJson(Origin instance) => <String, dynamic>{
      'id': instance.id,
      'dimension': instance.dimension,
      'created': instance.created?.toIso8601String(),
    };

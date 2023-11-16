// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      coordinates:
          const LocationConverter().fromJson(json['coordinates'] as List),
      type: json['type'] as String,
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': const LocationConverter().toJson(instance.coordinates),
    };

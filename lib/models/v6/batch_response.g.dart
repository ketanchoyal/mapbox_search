// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchGeocodingResponse _$BatchGeocodingResponseFromJson(
  Map<String, dynamic> json,
) => BatchGeocodingResponse(
  batch: (json['batch'] as List<dynamic>)
      .map((e) => GeocodingResponseV6.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BatchGeocodingResponseToJson(
  BatchGeocodingResponse instance,
) => <String, dynamic>{'batch': instance.batch};

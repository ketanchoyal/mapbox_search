// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predictions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Predictions _$PredictionsFromJson(Map<String, dynamic> json) => Predictions(
      type: json['type'] as String?,
      query: json['query'] as List<dynamic>?,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => MapBoxPlace.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'type': instance.type,
      'query': instance.query,
      'features': instance.features,
    };

MapBoxPlace _$MapBoxPlaceFromJson(Map<String, dynamic> json) => MapBoxPlace(
      id: json['id'] as String?,
      type: $enumDecodeNullable(_$FeatureTypeEnumMap, json['type']),
      placeType: (json['place_type'] as List<dynamic>?)
              ?.map((e) => $enumDecodeNullable(_$PlaceTypeEnumMap, e))
              .toList() ??
          const [],
      addressNumber: json['address_number'] as String?,
      properties: json['properties'] == null
          ? null
          : Properties.fromJson(json['properties'] as Map<String, dynamic>),
      text: json['text'] as String?,
      placeName: json['place_name'] as String?,
      bbox: _$JsonConverterFromJson<List<dynamic>, BBox>(
          json['bbox'], const BBoxConverter().fromJson),
      center:
          const OptionalLocationConverter().fromJson(json['center'] as List?),
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      context: (json['context'] as List<dynamic>?)
          ?.map((e) => Context.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchingText: json['matching_text'] as String?,
      matchingPlaceName: json['matching_place_name'] as String?,
    );

Map<String, dynamic> _$MapBoxPlaceToJson(MapBoxPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$FeatureTypeEnumMap[instance.type],
      'place_type':
          instance.placeType.map((e) => _$PlaceTypeEnumMap[e]).toList(),
      'address_number': instance.addressNumber,
      'properties': instance.properties,
      'text': instance.text,
      'place_name': instance.placeName,
      'bbox': _$JsonConverterToJson<List<dynamic>, BBox>(
          instance.bbox, const BBoxConverter().toJson),
      'center': const OptionalLocationConverter().toJson(instance.center),
      'geometry': instance.geometry,
      'context': instance.context,
      'matching_text': instance.matchingText,
      'matching_place_name': instance.matchingPlaceName,
    };

const _$FeatureTypeEnumMap = {
  FeatureType.FEATURE: 'Feature',
};

const _$PlaceTypeEnumMap = {
  PlaceType.country: 'country',
  PlaceType.region: 'region',
  PlaceType.postcode: 'postcode',
  PlaceType.district: 'district',
  PlaceType.place: 'place',
  PlaceType.locality: 'locality',
  PlaceType.neighborhood: 'neighborhood',
  PlaceType.address: 'address',
  PlaceType.poi: 'poi',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

Properties _$PropertiesFromJson(Map<String, dynamic> json) => Properties(
      shortCode: json['short_code'] as String?,
      wikidata: json['wikidata'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'short_code': instance.shortCode,
      'wikidata': instance.wikidata,
      'address': instance.address,
    };

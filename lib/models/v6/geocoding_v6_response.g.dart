// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_v6_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingResponseV6 _$GeocodingResponseV6FromJson(Map<String, dynamic> json) =>
    GeocodingResponseV6(
      type: json['type'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => GeocodingFeatureV6.fromJson(e as Map<String, dynamic>))
          .toList(),
      attribution: json['attribution'] as String,
    );

Map<String, dynamic> _$GeocodingResponseV6ToJson(
  GeocodingResponseV6 instance,
) => <String, dynamic>{
  'type': instance.type,
  'features': instance.features,
  'attribution': instance.attribution,
};

GeocodingFeatureV6 _$GeocodingFeatureV6FromJson(Map<String, dynamic> json) =>
    GeocodingFeatureV6(
      type: json['type'] as String,
      id: json['id'] as String,
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      properties: GeocodingPropertiesV6.fromJson(
        json['properties'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$GeocodingFeatureV6ToJson(GeocodingFeatureV6 instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };

GeocodingPropertiesV6 _$GeocodingPropertiesV6FromJson(
  Map<String, dynamic> json,
) => GeocodingPropertiesV6(
  mapboxId: json['mapbox_id'] as String,
  featureType: json['feature_type'] as String,
  fullAddress: json['full_address'] as String?,
  name: json['name'] as String?,
  namePreferred: json['name_preferred'] as String?,
  placeFormatted: json['place_formatted'] as String?,
  context: json['context'] == null
      ? null
      : GeocodingContextV6.fromJson(json['context'] as Map<String, dynamic>),
  bbox: _$JsonConverterFromJson<List<dynamic>, BBox>(
    json['bbox'],
    const BBoxConverter().fromJson,
  ),
);

Map<String, dynamic> _$GeocodingPropertiesV6ToJson(
  GeocodingPropertiesV6 instance,
) => <String, dynamic>{
  'mapbox_id': instance.mapboxId,
  'feature_type': instance.featureType,
  'full_address': instance.fullAddress,
  'name': instance.name,
  'name_preferred': instance.namePreferred,
  'place_formatted': instance.placeFormatted,
  'context': instance.context,
  'bbox': _$JsonConverterToJson<List<dynamic>, BBox>(
    instance.bbox,
    const BBoxConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

GeocodingContextV6 _$GeocodingContextV6FromJson(Map<String, dynamic> json) =>
    GeocodingContextV6(
      country: json['country'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['country'] as Map<String, dynamic>,
            ),
      region: json['region'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['region'] as Map<String, dynamic>,
            ),
      postcode: json['postcode'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['postcode'] as Map<String, dynamic>,
            ),
      district: json['district'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['district'] as Map<String, dynamic>,
            ),
      place: json['place'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['place'] as Map<String, dynamic>,
            ),
      locality: json['locality'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['locality'] as Map<String, dynamic>,
            ),
      neighborhood: json['neighborhood'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['neighborhood'] as Map<String, dynamic>,
            ),
      street: json['street'] == null
          ? null
          : GeocodingContextDetailsV6.fromJson(
              json['street'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$GeocodingContextV6ToJson(GeocodingContextV6 instance) =>
    <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
      'postcode': instance.postcode,
      'district': instance.district,
      'place': instance.place,
      'locality': instance.locality,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
    };

GeocodingContextDetailsV6 _$GeocodingContextDetailsV6FromJson(
  Map<String, dynamic> json,
) => GeocodingContextDetailsV6(
  mapboxId: json['mapbox_id'] as String,
  name: json['name'] as String,
  wikidataId: json['wikidata_id'] as String?,
  countryCode: json['country_code'] as String?,
  countryCodeAlpha3: json['country_code_alpha_3'] as String?,
);

Map<String, dynamic> _$GeocodingContextDetailsV6ToJson(
  GeocodingContextDetailsV6 instance,
) => <String, dynamic>{
  'mapbox_id': instance.mapboxId,
  'name': instance.name,
  'wikidata_id': instance.wikidataId,
  'country_code': instance.countryCode,
  'country_code_alpha_3': instance.countryCodeAlpha3,
};

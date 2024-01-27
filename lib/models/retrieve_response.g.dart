// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrieve_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetrieveResonse _$RetrieveResonseFromJson(Map<String, dynamic> json) =>
    RetrieveResonse(
      type: json['type'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
      attribution: json['attribution'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$RetrieveResonseToJson(RetrieveResonse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'features': instance.features,
      'attribution': instance.attribution,
      'url': instance.url,
    };

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
      type: json['type'] as String,
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      properties:
          Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
      'type': instance.type,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };

RetrieveProperties _$RetrievePropertiesFromJson(Map<String, dynamic> json) =>
    RetrieveProperties(
      name: json['name'] as String,
      mapboxId: json['mapbox_id'] as String,
      featureType: json['feature_type'] as String,
      address: json['address'] as String,
      fullAddress: json['full_address'] as String,
      placeFormatted: json['place_formatted'] as String,
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      coordinates:
          const LocationConverter().fromJson(json['coordinates'] as List),
      bbox: const BBoxConverter().fromJson(json['bbox'] as List),
      language: json['language'] as String,
      maki: json['maki'] as String,
      externalIds:
          ExternalIds.fromJson((json['external_ids'] ?? Map<String, dynamic>()) as Map<String, dynamic>),
      metadata: ExternalIds.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RetrievePropertiesToJson(RetrieveProperties instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mapbox_id': instance.mapboxId,
      'feature_type': instance.featureType,
      'address': instance.address,
      'full_address': instance.fullAddress,
      'place_formatted': instance.placeFormatted,
      'context': instance.context,
      'coordinates': const LocationConverter().toJson(instance.coordinates),
      'bbox': const BBoxConverter().toJson(instance.bbox),
      'language': instance.language,
      'maki': instance.maki,
      'external_ids': instance.externalIds,
      'metadata': instance.metadata,
    };

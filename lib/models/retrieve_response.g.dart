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
      properties: RetrieveProperties.fromJson(
          json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
      'type': instance.type,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };

RetrieveProperties _$RetrievePropertiesFromJson(Map<String, dynamic> json) =>
    RetrieveProperties(
      name: json['name'] as String,
      namePreferred: json['name_preferred'] as String?,
      mapboxId: json['mapbox_id'] as String,
      featureType: json['feature_type'] as String,
      address: json['address'] as String?,
      fullAddress: json['full_address'] as String?,
      placeFormatted: json['place_formatted'] as String?,
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      coordinates: const OptionalCoordinatesConverter()
          .fromJson(json['coordinates'] as Map<String, dynamic>?),
      language: json['language'] as String,
      maki: json['maki'] as String,
      brand:
          (json['brand'] as List<dynamic>?)?.map((e) => e as String).toList(),
      brandId: (json['brand_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      poiCategory: (json['poi_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      poiCategoryIds: (json['poi_category_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RetrievePropertiesToJson(RetrieveProperties instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_preferred': instance.namePreferred,
      'mapbox_id': instance.mapboxId,
      'feature_type': instance.featureType,
      'address': instance.address,
      'full_address': instance.fullAddress,
      'place_formatted': instance.placeFormatted,
      'context': instance.context,
      'coordinates':
          const OptionalCoordinatesConverter().toJson(instance.coordinates),
      'language': instance.language,
      'maki': instance.maki,
      'brand': instance.brand,
      'brand_id': instance.brandId,
      'poi_category': instance.poiCategory,
      'poi_category_ids': instance.poiCategoryIds,
    };

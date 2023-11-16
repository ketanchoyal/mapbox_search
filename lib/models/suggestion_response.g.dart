// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionResponse _$SuggestionResponseFromJson(Map<String, dynamic> json) =>
    SuggestionResponse(
      suggestions: (json['suggestions'] as List<dynamic>)
          .map((e) => Suggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      attribution: json['attribution'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SuggestionResponseToJson(SuggestionResponse instance) =>
    <String, dynamic>{
      'suggestions': instance.suggestions,
      'attribution': instance.attribution,
      'url': instance.url,
    };

Suggestion _$SuggestionFromJson(Map<String, dynamic> json) => Suggestion(
      name: json['name'] as String,
      namePreferred: json['name_preferred'] as String?,
      mapboxId: json['mapbox_id'] as String,
      featureType: json['feature_type'] as String,
      address: json['address'] as String?,
      fullAddress: json['full_address'] as String?,
      placeFormatted: json['place_formatted'] as String,
      context: json['context'] == null
          ? null
          : Context.fromJson(json['context'] as Map<String, dynamic>),
      language: json['language'] as String,
      maki: json['maki'] as String?,
      externalIds:
          ExternalIds.fromJson(json['external_ids'] as Map<String, dynamic>),
      poiCategory: (json['poi_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      poiCategoryIds: (json['poi_category_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      brand:
          (json['brand'] as List<dynamic>?)?.map((e) => e as String).toList(),
      brandId: (json['brand_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SuggestionToJson(Suggestion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_preferred': instance.namePreferred,
      'mapbox_id': instance.mapboxId,
      'feature_type': instance.featureType,
      'address': instance.address,
      'full_address': instance.fullAddress,
      'place_formatted': instance.placeFormatted,
      'context': instance.context,
      'language': instance.language,
      'maki': instance.maki,
      'external_ids': instance.externalIds,
      'poi_category': instance.poiCategory,
      'poi_category_ids': instance.poiCategoryIds,
      'brand': instance.brand,
      'brand_id': instance.brandId,
    };

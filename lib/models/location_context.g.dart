// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
      postcode: json['postcode'] == null
          ? null
          : Place.fromJson(json['postcode'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : Place.fromJson(json['district'] as Map<String, dynamic>),
      place: json['place'] == null
          ? null
          : Place.fromJson(json['place'] as Map<String, dynamic>),
      neighborhood: json['neighborhood'] == null
          ? null
          : Neighborhood.fromJson(json['neighborhood'] as Map<String, dynamic>),
      street: json['street'] == null
          ? null
          : Neighborhood.fromJson(json['street'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
      'postcode': instance.postcode,
      'district': instance.district,
      'place': instance.place,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as String?,
      name: json['name'] as String,
      countryCode: json['country_code'] as String,
      countryCodeAlpha3: json['country_code_alpha_3'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country_code': instance.countryCode,
      'country_code_alpha_3': instance.countryCodeAlpha3,
    };

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
      id: json['id'] as String?,
      name: json['name'] as String?,
      regionCode: json['region_code'] as String?,
      regionCodeFull: json['region_code_full'] as String?,
    );

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'region_code': instance.regionCode,
      'region_code_full': instance.regionCodeFull,
    };

Neighborhood _$NeighborhoodFromJson(Map<String, dynamic> json) => Neighborhood(
      name: json['name'] as String,
    );

Map<String, dynamic> _$NeighborhoodToJson(Neighborhood instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: json['id'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

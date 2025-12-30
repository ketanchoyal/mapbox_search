import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/models/bbox.dart';
import 'package:mapbox_search/models/geometry.dart';

part 'geocoding_v6_response.g.dart';

@JsonSerializable()
class GeocodingResponseV6 {
  final String type;
  final List<GeocodingFeatureV6> features;
  final String attribution;

  GeocodingResponseV6({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory GeocodingResponseV6.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResponseV6FromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingResponseV6ToJson(this);
}

@JsonSerializable()
class GeocodingFeatureV6 {
  final String type;
  final String id;
  final Geometry geometry;
  final GeocodingPropertiesV6 properties;

  GeocodingFeatureV6({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory GeocodingFeatureV6.fromJson(Map<String, dynamic> json) =>
      _$GeocodingFeatureV6FromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingFeatureV6ToJson(this);
}

@JsonSerializable()
class GeocodingPropertiesV6 {
  @JsonKey(name: 'mapbox_id')
  final String mapboxId;

  @JsonKey(name: 'feature_type')
  final String featureType;

  @JsonKey(name: 'full_address')
  final String? fullAddress;

  final String? name;

  @JsonKey(name: 'name_preferred')
  final String? namePreferred;

  @JsonKey(name: 'place_formatted')
  final String? placeFormatted;

  final GeocodingContextV6? context;

  @BBoxConverter()
  final BBox? bbox;

  GeocodingPropertiesV6({
    required this.mapboxId,
    required this.featureType,
    this.fullAddress,
    this.name,
    this.namePreferred,
    this.placeFormatted,
    this.context,
    this.bbox,
  });

  factory GeocodingPropertiesV6.fromJson(Map<String, dynamic> json) =>
      _$GeocodingPropertiesV6FromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingPropertiesV6ToJson(this);
}

@JsonSerializable()
class GeocodingContextV6 {
  final GeocodingContextDetailsV6? country;
  final GeocodingContextDetailsV6? region;
  final GeocodingContextDetailsV6? postcode;
  final GeocodingContextDetailsV6? district;
  final GeocodingContextDetailsV6? place;
  final GeocodingContextDetailsV6? locality;
  final GeocodingContextDetailsV6? neighborhood;
  final GeocodingContextDetailsV6? street;

  GeocodingContextV6({
    this.country,
    this.region,
    this.postcode,
    this.district,
    this.place,
    this.locality,
    this.neighborhood,
    this.street,
  });

  factory GeocodingContextV6.fromJson(Map<String, dynamic> json) =>
      _$GeocodingContextV6FromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingContextV6ToJson(this);
}

@JsonSerializable()
class GeocodingContextDetailsV6 {
  @JsonKey(name: 'mapbox_id')
  final String mapboxId;
  final String name;
  @JsonKey(name: 'wikidata_id')
  final String? wikidataId;
  @JsonKey(name: 'country_code')
  final String? countryCode;
  @JsonKey(name: 'country_code_alpha_3')
  final String? countryCodeAlpha3;

  GeocodingContextDetailsV6({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
    this.countryCode,
    this.countryCodeAlpha3,
  });

  factory GeocodingContextDetailsV6.fromJson(Map<String, dynamic> json) =>
      _$GeocodingContextDetailsV6FromJson(json);

  Map<String, dynamic> toJson() => _$GeocodingContextDetailsV6ToJson(this);
}

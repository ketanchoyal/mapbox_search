import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/models/geometry.dart';
import 'package:mapbox_search/models/location.dart';
import 'package:mapbox_search/models/location_context.dart';

part 'retrieve_response.g.dart';

String retrieveResonseToJson(RetrieveResonse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RetrieveResonse {
  RetrieveResonse({
    required this.type,
    required this.features,
    required this.attribution,
    required this.url,
  });

  final String type;
  final List<Feature> features;
  final String attribution;
  final String? url;

  factory RetrieveResonse.fromJson(Map<String, dynamic> json) =>
      _$RetrieveResonseFromJson(json);

  Map<String, dynamic> toJson() => _$RetrieveResonseToJson(this);
}

@JsonSerializable()
class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final Geometry geometry;
  final RetrieveProperties properties;

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}

@JsonSerializable()
class RetrieveProperties {
  RetrieveProperties({
    required this.name,
    this.namePreferred,
    required this.mapboxId,
    required this.featureType,
    this.address,
    this.fullAddress,
    required this.placeFormatted,
    required this.context,
    required this.coordinates,
    // required this.bbox,
    required this.language,
    required this.maki,
    this.brand,
    this.brandId,
    this.poiCategory,
    this.poiCategoryIds,
  });

  final String name;
  final String? namePreferred;
  final String mapboxId;
  final String featureType;
  final String? address;
  final String? fullAddress;
  final String placeFormatted;
  final Context context;
  @OptionalCoordinatesConverter()
  final Coordinates? coordinates;
  // @BBoxConverter()
  // final BBox? bbox;
  final String language;
  final String maki;
  final List<String>? brand;
  final List<String>? brandId;
  final List<String>? poiCategory;
  final List<String>? poiCategoryIds;
  // final ExternalIds? externalIds;
  // final ExternalIds metadata;

  factory RetrieveProperties.fromJson(Map<String, dynamic> json) =>
      _$RetrievePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$RetrievePropertiesToJson(this);
}

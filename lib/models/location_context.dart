import 'package:json_annotation/json_annotation.dart';

part 'location_context.g.dart';

@JsonSerializable()
class Context {
  Context({
    required this.country,
    this.region,
    required this.postcode,
    this.district,
    required this.place,
    this.neighborhood,
    this.street,
  });

  final Country? country;
  final Region? region;
  final Place? postcode;
  final Place? district;
  final Place? place;
  final Neighborhood? neighborhood;
  final Neighborhood? street;

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);

  Map<String, dynamic> toJson() => _$ContextToJson(this);
}

@JsonSerializable()
class Country {
  Country({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.countryCodeAlpha3,
  });

  final String? id;
  final String name;
  final String countryCode;
  @JsonKey(name: "country_code_alpha_3")
  final String? countryCodeAlpha3;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class Region {
  Region({
    required this.id,
    required this.name,
    required this.regionCode,
    required this.regionCodeFull,
  });

  final String? id;
  final String name;
  final String regionCode;
  final String regionCodeFull;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable()
class Neighborhood {
  Neighborhood({
    required this.name,
  });

  final String name;

  factory Neighborhood.fromJson(Map<String, dynamic> json) =>
      _$NeighborhoodFromJson(json);

  Map<String, dynamic> toJson() => _$NeighborhoodToJson(this);
}

@JsonSerializable()
class Place {
  Place({
    this.id,
    required this.name,
  });

  final String? id;
  final String name;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

part of mapbox_search;

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

  final Country country;
  final Region? region;
  final Place? postcode;
  final Place? district;
  final Place? place;
  final Neighborhood? neighborhood;
  final Neighborhood? street;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        country: Country.fromJson(json["country"]),
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
        postcode:
            json["postcode"] == null ? null : Place.fromJson(json["postcode"]),
        district:
            json["district"] == null ? null : Place.fromJson(json["district"]),
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
        neighborhood: json["neighborhood"] == null
            ? null
            : Neighborhood.fromJson(json["neighborhood"]),
        street: json["street"] == null
            ? null
            : Neighborhood.fromJson(json["street"]),
      );

  Map<String, dynamic> toJson() => {
        "country": country.toJson(),
        "region": region?.toJson(),
        "postcode": postcode?.toJson(),
        "district": district?.toJson(),
        "place": place?.toJson(),
        "neighborhood": neighborhood?.toJson(),
        "street": street?.toJson(),
      };
}

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
  final String countryCodeAlpha3;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
      };
}

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

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        regionCode: json["region_code"],
        regionCodeFull: json["region_code_full"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
      };
}

class Neighborhood {
  Neighborhood({
    required this.name,
  });

  final String name;

  factory Neighborhood.fromJson(Map<String, dynamic> json) => Neighborhood(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Place {
  Place({
    this.id,
    required this.name,
  });

  final String? id;
  final String name;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

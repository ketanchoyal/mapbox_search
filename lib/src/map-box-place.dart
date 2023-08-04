part of mapbox_search;

class MapBoxPlace {
  String? id;
  FeatureType? type;
  List<PlaceType>? placeType;

  dynamic relevance;
  String? addressNumber;
  Properties? properties;
  String? text;
  String? placeName;
  List<double>? bbox;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;
  String? matchingText;
  String? matchingPlaceName;

  MapBoxPlace({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.addressNumber,
    this.properties,
    this.text,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    this.context,
    this.matchingText,
    this.matchingPlaceName,
  });

  String? get street {
    return null;
  }

  String? get postalCode {
    try {
      return context?.firstWhere((element) => element.id?.contains('postcode') ?? false).text;
    } catch (e) { return null;}
  }

  String? get city {
    try {
      return context?.firstWhere((element) => element.id?.contains('place') ?? false).text;
    } catch (e) { return null;}
  }

  factory MapBoxPlace.fromRawJson(String str) => MapBoxPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapBoxPlace.fromJson(Map<String, dynamic> json) => MapBoxPlace(
    id: json["id"],
    type: json["type"] == null ? null : featureTypeValues.map[json["type"]],
    placeType: json["place_type"] == null ? null : List<PlaceType>.from(json["place_type"].map((x) => placeTypeValues.map[x])),
    relevance: json["relevance"] == null ? null : json["relevance"],
    addressNumber: json["address"],
    properties: json["properties"] == null ? null : Properties.fromJson(json["properties"]),
    text: json["text"],
    placeName: json["place_name"],
    bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
    center: json["center"] == null ? null : List<double>.from(json["center"].map((x) => x.toDouble())),
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    context: json["context"] == null ? null : List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
    matchingText: json["matching_text"],
    matchingPlaceName: json["matching_place_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": featureTypeValues.reverse![type!],
    "place_type": List<dynamic>.from(placeType!.map((x) => placeTypeValues.reverse![x])),
    "relevance": relevance,
    "address": addressNumber,
    "properties": properties!.toJson(),
    "text": text,
    "place_name": placeName,
    "bbox": List<dynamic>.from(bbox!.map((x) => x)),
    "center": List<dynamic>.from(center!.map((x) => x)),
    "geometry": geometry!.toJson(),
    "context": context == null ? null : List<dynamic>.from(context!.map((x) => x.toJson())),
    "matching_text": matchingText == null ? null : matchingText,
    "matching_place_name": matchingPlaceName == null ? null : matchingPlaceName,
  };

  @override
  String toString() => text ?? placeName!;
}

final placeTypeValues = EnumValues({
  "country": PlaceType.country,
  "place": PlaceType.place,
  "region": PlaceType.region,
  "postcode": PlaceType.postcode,
  "district": PlaceType.district,
  "locality": PlaceType.locality,
  "neighborhood": PlaceType.neighborhood,
  "address": PlaceType.address,
  "poi": PlaceType.poi,
});

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});
part of mapbox_search;

class Predictions {
  final String? type;
  final List<dynamic>? query;
  final List<MapBoxPlace> features;

  Predictions.prediction({
    this.type,
    this.query,
    this.features = const [],
  });

  factory Predictions.empty() => Predictions.prediction(
        type: '',
        query: [],
        features: [],
      );

  factory Predictions.fromRawJson(String str) =>
      Predictions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      Predictions.prediction(
        type: json["type"],
        query: List<dynamic>.from(json["query"].map((x) => x)),
        features: List<MapBoxPlace>.from(
            json["features"].map((x) => MapBoxPlace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query!.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
      };
}

class MapBoxPlace {
  final String? id;
  final FeatureType? type;
  final List<PlaceType?> placeType;

  // dynamic relevance;
  final String? addressNumber;
  final Properties? properties;
  final String? text;
  final String? placeName;
  final BBox? bbox;
  final Location? center;
  final Geometry? geometry;
  // final List<Context>? context;
  final String? matchingText;
  final String? matchingPlaceName;

  MapBoxPlace({
    this.id,
    this.type,
    this.placeType = const [],
    // this.relevance,
    this.addressNumber,
    this.properties,
    this.text,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    // this.context,
    this.matchingText,
    this.matchingPlaceName,
  });

  factory MapBoxPlace.fromRawJson(String str) =>
      MapBoxPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapBoxPlace.fromJson(Map<String, dynamic> json) => MapBoxPlace(
        id: json["id"],
        type: json["type"] == null ? null : featureTypeValues.map[json["type"]],
        placeType: json["place_type"] == null
            ? []
            : List<PlaceType>.from(
                json["place_type"].map((x) => x.toString().placeType)),
        // relevance: json["relevance"] == null ? null : json["relevance"],
        addressNumber: json["address"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null
            ? null
            : BBox.fromList(json["bbox"].map((x) => x.toDouble()).toList()),
        center: json["center"] == null
            ? null
            : List<double>.from(json["center"]).asLocation,
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        // context: json["context"] == null
        //     ? null
        //     : List<Context>.from(
        //         json["context"].map((x) => Context.fromJson(x))),
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": featureTypeValues.reverse![type!],
        "place_type": List<dynamic>.from(placeType.map((x) => x?.value)),
        // "relevance": relevance,
        "address": addressNumber,
        "properties": properties!.toJson(),
        "text": text,
        "place_name": placeName,
        "bbox": bbox?.asList,
        "center": center?.asList,
        "geometry": geometry!.toJson(),
        // "context": context == null
        //     ? null
        //     : List<dynamic>.from(context!.map((x) => x.toJson())),
        "matching_text": matchingText == null ? null : matchingText,
        "matching_place_name":
            matchingPlaceName == null ? null : matchingPlaceName,
      };

  @override
  String toString() => text ?? placeName!;
}

// class Context {
//   String? id;
//   String? shortCode;
//   String? wikidata;
//   String? text;

//   Context({
//     this.id,
//     this.shortCode,
//     this.wikidata,
//     this.text,
//   });

//   factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Context.fromJson(Map<String, dynamic> json) => Context(
//         id: json["id"],
//         shortCode: json["short_code"],
//         wikidata: json["wikidata"],
//         text: json["text"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "short_code": shortCode,
//         "wikidata": wikidata,
//         "text": text,
//       };
// }

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({"Point": GeometryType.POINT});

class Properties {
  String? shortCode;
  String? wikidata;
  String? address;

  Properties({
    this.shortCode,
    this.wikidata,
    this.address,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        shortCode: json["short_code"] == null ? null : json["short_code"],
        wikidata: json["wikidata"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "short_code": shortCode == null ? null : shortCode,
        "wikidata": wikidata,
        "address": address,
      };
}

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}

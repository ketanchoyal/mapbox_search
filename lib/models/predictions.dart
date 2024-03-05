import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/mapbox_search.dart';

part 'predictions.g.dart';

@JsonSerializable()
class Predictions {
  final String? type;
  final List<dynamic>? query;
  final List<MapBoxPlace> features;

  Predictions({
    this.type,
    this.query,
    this.features = const [],
  });

  factory Predictions.empty() => Predictions(
        type: '',
        query: [],
        features: [],
      );

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);
}

@JsonSerializable()
class MapBoxPlace {
  final String? id;
  final FeatureType? type;
  final List<PlaceType?> placeType;

  // dynamic relevance;
  final String? addressNumber;
  final String? address;

  final Properties? properties;
  final String? text;
  final String? placeName;
  @BBoxConverter()
  final BBox? bbox;
  @OptionalLocationConverter()
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
    this.address,
    this.bbox,
    this.center,
    this.geometry,
    // this.context,
    this.matchingText,
    this.matchingPlaceName,
  });

  factory MapBoxPlace.fromJson(Map<String, dynamic> json) =>
      _$MapBoxPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$MapBoxPlaceToJson(this);

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

enum GeometryType {
  @JsonValue("Point")
  POINT
}

@JsonSerializable()
class Properties {
  String? shortCode;
  String? wikidata;
  String? address;

  Properties({
    this.shortCode,
    this.wikidata,
    this.address,
  });

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}

enum FeatureType {
  @JsonValue("Feature")
  FEATURE
}

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

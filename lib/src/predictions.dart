part of mapbox_search;

class Predictions {
  String? type;
  List<dynamic>? query;
  List<MapBoxPlace>? features;

  Predictions.prediction({
    this.type,
    this.query,
    this.features,
  });

  Predictions.empty() {
    this.type = '';
    this.features = [];
    this.query = [];
  }

  factory Predictions.fromRawJson(String str) => Predictions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Predictions.fromJson(Map<String, dynamic> json) => Predictions.prediction(
        type: json["type"],
        query: List<dynamic>.from(json["query"].map((x) => x)),
        features: List<MapBoxPlace>.from(json["features"].map((x) => MapBoxPlace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query!.map((x) => x)),
        "features": List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

enum FeatureType { FEATURE }

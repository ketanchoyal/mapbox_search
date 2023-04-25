part of mapbox_search;

String retrieveResonseToJson(RetrieveResonse data) =>
    json.encode(data.toJson());

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
      RetrieveResonse(
        type: json["type"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
        url: json["url"],
      );
  factory RetrieveResonse.fromRawJson(String str) =>
      RetrieveResonse.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
        "url": url,
      };
}

class Feature {
  Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String type;
  final Geometry geometry;
  final Properties properties;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
      };
}

class RetrieveProperties {
  RetrieveProperties({
    required this.name,
    required this.mapboxId,
    required this.featureType,
    required this.address,
    required this.fullAddress,
    required this.placeFormatted,
    required this.context,
    required this.coordinates,
    required this.bbox,
    required this.language,
    required this.maki,
    required this.externalIds,
    required this.metadata,
  });

  final String name;
  final String mapboxId;
  final String featureType;
  final String address;
  final String fullAddress;
  final String placeFormatted;
  final Context context;
  final Coordinates coordinates;
  final List<double> bbox;
  final String language;
  final String maki;
  final ExternalIds externalIds;
  final ExternalIds metadata;

  factory RetrieveProperties.fromJson(Map<String, dynamic> json) =>
      RetrieveProperties(
        name: json["name"],
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        address: json["address"],
        fullAddress: json["full_address"],
        placeFormatted: json["place_formatted"],
        context: Context.fromJson(json["context"]),
        coordinates: Coordinates.fromJson(json["coordinates"]),
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        language: json["language"],
        maki: json["maki"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        metadata: ExternalIds.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "address": address,
        "full_address": fullAddress,
        "place_formatted": placeFormatted,
        "context": context.toJson(),
        "coordinates": coordinates.toJson(),
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "language": language,
        "maki": maki,
        "external_ids": externalIds.toJson(),
        "metadata": metadata.toJson(),
      };
}

class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

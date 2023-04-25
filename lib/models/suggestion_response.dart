part of mapbox_search;

String suggestionResponseToJson(SuggestionResponse data) =>
    json.encode(data.toJson());

class SuggestionResponse {
  SuggestionResponse({
    required this.suggestions,
    required this.attribution,
    required this.url,
  });

  final List<Suggestion> suggestions;
  final String attribution;
  final String? url;

  factory SuggestionResponse.fromJson(Map<String, dynamic> json) =>
      SuggestionResponse(
        suggestions: List<Suggestion>.from(
            json["suggestions"].map((x) => Suggestion.fromJson(x))),
        attribution: json["attribution"],
        url: json["url"],
      );

  factory SuggestionResponse.fromRawJson(String str) =>
      SuggestionResponse.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
        "attribution": attribution,
        "url": url,
      };
}

class Suggestion {
  Suggestion({
    required this.name,
    this.namePreferred,
    required this.mapboxId,
    required this.featureType,
    required this.address,
    required this.fullAddress,
    required this.placeFormatted,
    required this.context,
    required this.language,
    required this.maki,
    required this.externalIds,
    this.poiCategory,
    this.poiCategoryIds,
    this.brand,
    this.brandId,
  });

  final String name;
  final String? namePreferred;
  final String mapboxId;
  final String featureType;
  final String address;
  final String fullAddress;
  final String placeFormatted;
  final Context context;
  final String language;
  final String maki;
  final ExternalIds externalIds;
  final List<String>? poiCategory;
  final List<String>? poiCategoryIds;
  final List<String>? brand;
  final String? brandId;

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        name: json["name"],
        namePreferred: json["name_preferred"],
        mapboxId: json["mapbox_id"],
        featureType: json["feature_type"],
        address: json["address"],
        fullAddress: json["full_address"],
        placeFormatted: json["place_formatted"],
        context: Context.fromJson(json["context"]),
        language: json["language"],
        maki: json["maki"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        poiCategory: json["poi_category"] == null
            ? []
            : List<String>.from(json["poi_category"]!.map((x) => x)),
        poiCategoryIds: json["poi_category_ids"] == null
            ? []
            : List<String>.from(json["poi_category_ids"]!.map((x) => x)),
        brand: json["brand"] == null
            ? []
            : List<String>.from(json["brand"]!.map((x) => x)),
        brandId: json["brand_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "name_preferred": namePreferred,
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "address": address,
        "full_address": fullAddress,
        "place_formatted": placeFormatted,
        "context": context.toJson(),
        "language": language,
        "maki": maki,
        "external_ids": externalIds.toJson(),
        "poi_category": poiCategory == null
            ? []
            : List<dynamic>.from(poiCategory!.map((x) => x)),
        "poi_category_ids": poiCategoryIds == null
            ? []
            : List<dynamic>.from(poiCategoryIds!.map((x) => x)),
        "brand": brand == null ? [] : List<dynamic>.from(brand!.map((x) => x)),
        "brand_id": brandId,
      };
}

class ExternalIds {
  ExternalIds({
    this.foursquare,
    this.safegraph,
  });

  final String? foursquare;
  final String? safegraph;

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        foursquare: json["foursquare"],
        safegraph: json["safegraph"],
      );

  Map<String, dynamic> toJson() => {
        "foursquare": foursquare,
        "safegraph": safegraph,
      };
}

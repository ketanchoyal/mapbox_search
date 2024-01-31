import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search/models/location.dart';

/// The MapBox Geocoding API lets you convert location text into geographic coordinates (1600 Pennsylvania Ave NW → -77.0366,38.8971)
/// and vice versa (reverse geocoding).
///
/// https://docs.mapbox.com/api/search/geocoding/
class GeoCoding {
  /// API Key of the MapBox.
  final String _apiKey;

  /// Specify the user’s language. This parameter controls the language of the text supplied in responses.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String? language;

  ///Limit results to one or more countries. Permitted values are ISO 3166 alpha 2 country codes separated by commas.
  ///
  /// Check the full list of [supported countries](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for the MapBox API
  final String? country;

  /// Specify the maximum number of results to return. The default is 5 and the maximum supported is 10.
  final int? limit;

  /// Limit results to only those contained within the supplied bounding box.
  final BBox? bbox;

  /// Filter results to include only a subset (one or more) of the available feature types.
  /// Options are country, region, postcode, district, place, locality, neighborhood, address, and poi.
  /// Multiple options can be comma-separated.
  ///
  /// For more information on the available types, see the [data types section](https://docs.mapbox.com/api/search/geocoding/#data-types).
  final List<PlaceType> types;

  final Uri _baseUri =
      Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/');

  /// If [apiKey] is not provided here then it must be provided [MapBoxSearch()]
  GeoCoding({
    String? apiKey,
    this.country,
    this.limit,
    this.language,
    this.types = const [PlaceType.address],
    this.bbox,
  })  :

        /// Assert that the [apiKey] and [MapBoxSearch._apiKey] are not null at same time
        assert(
          apiKey != null || MapBoxSearch.apiKey != null,
          'The API Key must be provided',
        ),
        _apiKey = apiKey ?? MapBoxSearch.apiKey!;

  Uri _createUrl(
    String queryText, [
    Proximity proximity = const NoProximity(),
  ]) {
    final finalUri = Uri(
      scheme: _baseUri.scheme,
      host: _baseUri.host,
      path: _baseUri.path + Uri.encodeFull(queryText) + '.json',
      queryParameters: {
        'access_token': _apiKey,
        ...switch (proximity) {
          (LocationProximity l) => {"proximity": l.asString},
          (IpProximity _) => {"proximity": 'ip'},
          (NoProximity _) => {},
        },
        if (country != null) 'country': country,
        if (limit != null) 'limit': limit.toString(),
        if (language != null) 'language': language,
        if (types.isNotEmpty) 'types': types.map((e) => e.value).join(','),
        if (bbox != null) 'bbox': bbox?.asString,
      },
    );
    return finalUri;
  }

  /// Get the places for the given query text
  Future<ApiResponse<List<MapBoxPlace>>> getPlaces(
    String queryText, {
    @Deprecated(
        'Use `proximity` instead, if `proximity` value is passed then it will be used and this value will be ignored')
    Location? location,
    Proximity proximity = const NoProximity(),
  }) async {
    if (proximity is! LocationProximity) {
      proximity =
          location != null ? Proximity.Location(location) : const NoProximity();
    }
    final uri = _createUrl(queryText, proximity);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return (
        success: null,
        failure: FailureResponse.fromJson(json.decode(response.body))
      );
    }

    return (
      success: Predictions.fromJson(json.decode(response.body)).features,
      failure: null
    );
  }

  /// Get the address of the given location coordinates
  Future<ApiResponse<List<MapBoxPlace>?>> getAddress(Location location) async {
    // Assert that if limit is not null then only one type is passed
    assert(limit != null && (types.length == 1) || limit == null,
        'Limit is not null so you can only pass one type');
    Uri uri = _createUrl(location.asString);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return (
        success: null,
        failure: FailureResponse.fromJson(json.decode(response.body))
      );
    }

    return (
      success: Predictions.fromJson(json.decode(response.body)).features,
      failure: null
    );
  }

  GeoCoding copyWith({
    String? apiKey,
    String? language,
    String? country,
    int? limit,
    BBox? bbox,
    List<PlaceType>? types,
  }) {
    return GeoCoding(
      apiKey: apiKey ?? this._apiKey,
      language: language ?? this.language,
      country: country ?? this.country,
      limit: limit ?? this.limit,
      bbox: bbox ?? this.bbox,
      types: types ?? this.types,
    );
  }
}

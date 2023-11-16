import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search/models/location.dart';
import 'package:uuid/uuid.dart';

typedef ApiResponse<T> = ({T? success, FailureResponse? failure});

extension ApiResponseExtension<T> on ApiResponse<T> {
  R fold<R extends Object?>(
    R Function(T value) success,
    R Function(FailureResponse value) failure,
  ) {
    if (this.success != null) {
      return success(this.success!);
    } else if (this.failure != null) {
      return failure(this.failure!);
    } else {
      throw Exception('ApiResponse is not valid');
    }
  }
}

/// Search for places by name, point, bbox, proximity, and more.
///
///
/// https://docs.mapbox.com/api/search/search-box/
///
/// The Search Box API includes two different endpoints: `/suggest` and `/retrieve`. As the user types, text is sent to the `/suggest` endpoint to get suggested results. When the user selects a suggestion, its `mapbox_id` is sent to `/retrieve` to get the full data.
class SearchBoxAPI {
  /// API Key of the MapBox.
  /// If not provided here then it must be provided [MapBoxSearch()] constructor
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

  final Uri _baseUri = Uri.parse('https://api.mapbox.com/search/searchbox/v1/');

  /// If [apiKey] is not provided here then it must be provided [MapBoxSearch()] constructor
  SearchBoxAPI({
    String? apiKey,
    this.country,
    this.limit,
    this.language,
    this.types = const [],
    this.bbox,
  })  :

        /// Assert that the [apiKey] and [MapBoxSearch._apiKey] are not null at same time
        assert(
          apiKey != null || MapBoxSearch.apiKey != null,
          'The API Key must be provided',
        ),
        _apiKey = apiKey ?? MapBoxSearch.apiKey!;

  static String? _sessionToken;

  Uri _createUrl(
    String queryOrId, [
    Proximity proximity = const NoProximity(),
    bool isSuggestions = false,
    List<POICategory> poi = const [],
  ]) {
    _sessionToken ??= Uuid().v1();
    final finalUri = Uri(
      scheme: _baseUri.scheme,
      host: _baseUri.host,
      path: _baseUri.path + (isSuggestions ? 'suggest' : 'retrieve/$queryOrId'),
      queryParameters: {
        'access_token': _apiKey,
        'session_token': _sessionToken,
        if (isSuggestions) ...{
          'q': queryOrId,
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
          if (poi.isNotEmpty) 'poi_category': poi.map((e) => e.value).join(','),
        },
      },
    );
    return finalUri;
  }

  /// Get a list of places that match the query.
  Future<ApiResponse<SuggestionResponse>> getSuggestions(
    String queryText, {
    Proximity proximity = const NoProximity(),
    List<POICategory> poi = const [],
  }) async {
    final uri = _createUrl(queryText, proximity, true, poi);
    print(uri);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return (
        success: null,
        failure: FailureResponse.fromJson(json.decode(response.body))
      );
    } else {
      return (
        success: SuggestionResponse.fromJson(json.decode(response.body)),
        failure: null
      );
    }
  }

  /// Retrive a place by its `mapbox_id`.
  Future<ApiResponse<RetrieveResonse>> getPlace(String mapboxId) async {
    final uri = _createUrl(mapboxId);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return (
        success: null,
        failure: FailureResponse.fromJson(json.decode(response.body))
      );
    } else {
      return (
        success: RetrieveResonse.fromJson(json.decode(response.body)),
        failure: null
      );
    }
  }
}

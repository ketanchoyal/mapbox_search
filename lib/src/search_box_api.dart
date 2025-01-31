import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search/models/location.dart';
import 'package:uuid/uuid.dart';

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

  final Dio _dio;

  final _baseUrl = 'https://api.mapbox.com';
  final _basePath = '/search/searchbox/v1/';

  /// If [apiKey] is not provided here then it must be provided [MapBoxSearch()] constructor
  SearchBoxAPI({
    String? apiKey,
    this.country,
    this.limit,
    this.language,
    this.types = const [],
    this.bbox,
    Dio? dio,
  })  :

        /// Assert that the [apiKey] and [MapBoxSearch._apiKey] are not null at same time
        assert(
          apiKey != null || MapBoxSearch.apiKey != null,
          'The API Key must be provided',
        ),
        _dio = dio ?? Dio(),
        _apiKey = apiKey ?? MapBoxSearch.apiKey! {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.queryParameters = {
      'access_token': _apiKey,
      'session_token': _sessionToken ??= Uuid().v1(),
    };
    _dio.options.receiveDataWhenStatusError = true;
  }

  static String? _sessionToken;

  /// Get a list of places that match the query.
  Future<ApiResponse<SuggestionResponse>> getSuggestions(
    String queryText, {
    Proximity proximity = const NoProximity(),
    List<POICategory> poi = const [],
    CancelToken? cancelToken,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'q': queryText,
      ...switch (proximity) {
        (LocationProximity l) => {"proximity": l.asString},
        (IpProximity ip) => {"proximity": ip.asString},
        (NoProximity _) => {},
      },
      if (country != null) 'country': country,
      if (limit != null) 'limit': limit.toString(),
      if (language != null) 'language': language,
      if (types.isNotEmpty) 'types': types.map((e) => e.value).join(','),
      if (bbox != null) 'bbox': bbox?.asString,
      if (poi.isNotEmpty) 'poi_category': poi.map((e) => e.value).join(','),
    };

    final path = _basePath + 'suggest';
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        return (
          success: null,
          failure: FailureResponse.fromJson(response.data)
        );
      } else {
        return (
          success: SuggestionResponse.fromJson(response.data),
          failure: null
        );
      }
    } on DioException catch (e) {
      return (
        success: null,
        failure: FailureResponse(
          message: e.message ?? 'Unknown error',
          error: e.error.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    } catch (e) {
      return (
        success: null,
        failure: FailureResponse(
          message: e.toString(),
          error: e.toString(),
          code: '500',
        ),
      );
    }
  }

  /// Retrive a place by its `mapbox_id`.
  Future<ApiResponse<RetrieveResonse>> getPlace(
    String mapboxId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final path = _basePath + 'retrieve/$mapboxId';
      final response = await _dio.get(
        path,
        cancelToken: cancelToken,
        options: Options(
          receiveDataWhenStatusError: true,
          validateStatus: (x) => true,
        ),
      );

      log('getPlace: ${response.realUri.toString()}');

      if (response.statusCode != 200) {
        return (
          success: null,
          failure: FailureResponse.fromJson(response.data)
        );
      } else {
        return (
          success: RetrieveResonse.fromJson(response.data),
          failure: null
        );
      }
    } on DioException catch (e) {
      return (
        success: null,
        failure: FailureResponse(
          message: e.message ?? 'Unknown error',
          error: e.error.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    } catch (e) {
      return (
        success: null,
        failure: FailureResponse(
          message: e.toString(),
          error: e.toString(),
          code: '500',
        ),
      );
    }
  }
}

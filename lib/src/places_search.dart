part of mapbox_search;

class PlacesSearch {
  /// API Key of the MapBox.
  final String apiKey;

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
  final List<PlaceType>? types;

  final Uri _baseUri =
      Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/');

  PlacesSearch({
    required this.apiKey,
    this.country,
    this.limit,
    this.language,
    this.types,
    this.bbox,
  });

  Uri _createUrl(
    String queryText, [
    Proximity proximity = const LocationNone(),
  ]) {
    final finalUri = Uri(
      scheme: _baseUri.scheme,
      host: _baseUri.host,
      path: _baseUri.path + Uri.encodeFull(queryText) + '.json',
      queryParameters: {
        'access_token': apiKey,
        if (proximity is Location) 'proximity': proximity.asString,
        if (proximity is LocationIp) 'proximity': 'ip',
        if (country != null) 'country': country,
        if (limit != null) 'limit': limit.toString(),
        if (language != null) 'language': language,
        if (types != null) 'types': types?.map((e) => e.value).join(','),
        if (bbox != null) 'bbox': bbox?.asString,
      },
    );
    return finalUri;
  }

  Future<List<MapBoxPlace>?> getPlaces(
    String queryText, {
    @Deprecated('Use `proximity` instead, if `proximity` value is passed then it will be used and this value will be ignored')
        Location? location,
    Proximity proximity = const LocationNone(),
  }) async {
    if (proximity is! Location) {
      proximity = location ?? const LocationNone();
    }
    final uri = _createUrl(queryText, proximity);
    final response = await http.get(uri);

    if (response.body.contains('message')) {
      throw Exception(json.decode(response.body)['message']);
    }

    return Predictions.fromRawJson(response.body).features;
  }

  PlacesSearch copyWith({
    String? apiKey,
    String? language,
    String? country,
    int? limit,
    BBox? bbox,
    List<PlaceType>? types,
  }) {
    return PlacesSearch(
      apiKey: apiKey ?? this.apiKey,
      language: language ?? this.language,
      country: country ?? this.country,
      limit: limit ?? this.limit,
      bbox: bbox ?? this.bbox,
      types: types ?? this.types,
    );
  }
}

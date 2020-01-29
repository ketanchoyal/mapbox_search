part of mapbox_search;

class ReverseGeoCoding {
  /// API Key of the MapBox.
  final String apiKey;

  /// The callback that is called when the user taps on the search icon.
  // final void Function(MapBoxPlaces place) onSearch;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String language;

  /// The point around which you wish to retrieve place information.
  final Location location;

  /// Specify the maximum number of results to return. The default is 5 and the maximum supported is 10.
  final int limit;

  ///Limits the search to the given country
  ///
  /// Check the full list of [supported countries](https://docs.mapbox.com/api/search/) for the MapBox API
  final String country;

  ReverseGeoCoding({
    @required this.apiKey,
    this.language = 'en',
    this.location,
    this.limit = 5,
    this.country,
  }) : assert(apiKey != null);

  final String _url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/';

  String _createUrl(Location location) {
    String finalUrl = _url +
        location.lng.toString() +
        "," +
        location.lat.toString() +
        '.json?';
    finalUrl += 'access_token=$apiKey';
    // finalUrl += '&cachebuster=1567167369462';
    if (this.location != null) {
      finalUrl += '&proximity=${this.location.lng}%2C${this.location.lat}';
    }

    if (limit != null) {
      finalUrl += '&limit=$limit';
    }

    if (country != null) {
      finalUrl += '&country=$country';
    }

    return finalUrl;
  }

  Future<List<MapBoxPlace>> getAddress(Location location) async {
    try {
      String url = _createUrl(location);
      final response = await http.get(url);
      // print(url);
      // print(response.body);
      final predictions = Predections.fromRawJson(response.body);

      return predictions.features;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

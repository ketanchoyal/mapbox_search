part of mapbox_search;

class PlacesSearch {
  /// API Key of the MapBox.
  final String apiKey;

  /// The callback that is called when the user taps on the search icon.
  // final void Function(MapBoxPlaces place) onSearch;

  ///Limits the search to the given country
  ///
  /// Check the full list of [supported countries](https://docs.mapbox.com/api/search/) for the MapBox API
  final String country;

  /// Specify the maximum number of results to return. The default is 5 and the maximum supported is 10.
  final int limit;

  final String _url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/';

  PlacesSearch({
    this.apiKey,
    this.country,
    this.limit,
  }) : assert(apiKey != null);

  String _createUrl(String queryText, [Location location]) {
    String finalUrl = '$_url${Uri.encodeFull(queryText)}.json?';
    finalUrl += 'access_token=$apiKey';

    if (location != null) {
      finalUrl += '&proximity=${location.lng}%2C${location.lat}';
    }
    if (country != null) {
      finalUrl += "&country=$country";
    }

    if (limit != null) {
      finalUrl += "&limit=$limit";
    }

    return finalUrl;
  }

  Future<List<MapBoxPlace>> getPlaces(
    String queryText, {
    Location location,
  }) async {
    try {
      String url = _createUrl(queryText, location);
      final response = await http.get(url);
//      print("The url: $url");
//      print(response.body);
      final predictions = Predections.fromRawJson(response.body);

      return predictions.features;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

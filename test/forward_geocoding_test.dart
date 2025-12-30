import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  test("Forward GeoCoding Test", () async {
    GeoCodingApi geocoding = GeoCodingApi(
      apiKey: MAPBOX_KEY,
      country: "BR",
      limit: 5,
      types: [PlaceType.address, PlaceType.place],
    );

    var getPlacesResponse = await geocoding.getPlaces(
      "central park",
      proximity: Proximity.LatLong(
        lat: -19.984634,
        long: -43.9502958,
      ),
    );

    expect(getPlacesResponse, isA<ApiResponse<List<MapBoxPlace>>>());
    expect(getPlacesResponse.failure, isNull);
    expect(getPlacesResponse.success, isNotNull);
    expect(getPlacesResponse.success, isNotEmpty);
  });
}

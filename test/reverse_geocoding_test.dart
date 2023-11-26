import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  MapBoxSearch.init(MAPBOX_KEY);

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  test("ReverseGeoCoding address search with limit test", () async {
    GeoCoding reverseGeoCoding = GeoCoding(
      country: "BR",
      limit: 2,
    );

    var getAddressResponse = await reverseGeoCoding.getAddress(
      (
        lat: -19.984634,
        long: -43.9502958,
      ),
    );

    expect(getAddressResponse, isA<ApiResponse<List<MapBoxPlace>>>());
    expect(getAddressResponse.failure, isNull);
    expect(getAddressResponse.success, isNotNull);
    expect(getAddressResponse.success, hasLength(2));
  });
  test("ReverseGeoCoding address search without limit test", () async {
    GeoCoding reverseGeoCoding = GeoCoding(
      country: "BR",
      types: [PlaceType.address, PlaceType.place],
    );

    var getAddressResponse = await reverseGeoCoding.getAddress(
      (
        lat: -19.984634,
        long: -43.9502958,
      ),
    );

    expect(getAddressResponse, isA<ApiResponse<List<MapBoxPlace>>>());
    expect(getAddressResponse.success, isNotEmpty);
  });
}

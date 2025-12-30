import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  group('Geocoding v6', () {
    late GeoCodingApiV6 geocoding;

    setUp(() {
      geocoding = GeoCodingApiV6(apiKey: MAPBOX_KEY, limit: 1);
    });

    test("Forward Geocoding - 'White House'", () async {
      final response = await geocoding.forward("White House");

      expect(response.success, isNotNull);
      expect(response.failure, isNull);
      expect(response.success!.features, isNotEmpty);
      expect(
        response.success!.features.first.properties.name,
        contains("White House"),
      );
    });

    test("Reverse Geocoding", () async {
      final response = await geocoding.reverse(
        (lat: 38.8977, long: -77.0365), // White House coordinates
      );

      expect(response.success, isNotNull);
      expect(response.failure, isNull);
      expect(response.success!.features, isNotEmpty);

      final props = response.success!.features.first.properties;
      expect(
        props.placeFormatted != null ||
            props.fullAddress != null ||
            props.name != null,
        isTrue,
      );
    });

    test("Reverse Geocoding with Limit > 1", () async {
      final response = await geocoding.reverse(
        (lat: 38.8977, long: -77.0365),
        limit: 5,
        types: [PlaceType.address],
      );

      expect(response.success, isNotNull);
      expect(response.failure, isNull);
      expect(response.success!.features, isNotEmpty);
      // Might not actually find 5 addresses at exactly one point, but shouldn't error.
      // And since we passed types, it should be valid API call.
    });

    test(
      "Reverse Geocoding with Limit > 1 but NO Types (Should Warn and Succeed)",
      () async {
        // Setup a geocoding instance with limit > 1 but no types physically
        // (though here we override in method anyway)
        final response = await geocoding.reverse(
          (lat: 38.8977, long: -77.0365),
          limit: 5, // Invalid without types
          // types: null/empty by default
        );

        expect(response.success, isNotNull); // Should succeed by ignoring limit
        expect(response.failure, isNull);
      },
    );

    test("Forward Geocoding with Structured Input (implicit via query)", () async {
      // v6 treats 'q' as query, which can be structured if formatted nicely,
      // but strictly structured input usually means separate params which v6 API supports as parts of 'q' or specific params?
      // Actually v6 standard forward endpoint just takes 'q'.
      // Structured input in v6 is often handled by specific parsing or just better query understanding.
      // Let's just test a complex address.
      final response = await geocoding.forward(
        "1600 Pennsylvania Ave NW, Washington, DC",
      );
      expect(response.success, isNotNull);
      expect(response.success!.features, isNotEmpty);
    });

    test("Error handling - Invalid Key", () async {
      final badGeocoding = GeoCodingApiV6(apiKey: "pk.bad_key");
      final response = await badGeocoding.forward("Anywhere");

      expect(response.success, isNull);
      expect(response.failure, isNotNull);
    });
    test("Batch Geocoding", () async {
      final queries = [
        ForwardQuery(query: "White House"),
        ReverseQuery(location: (lat: 38.8977, long: -77.0365)),
      ];

      final response = await geocoding.batch(queries);

      expect(response.success, isNotNull);
      expect(response.failure, isNull);
      expect(response.success!.batch, hasLength(2));
      expect(response.success!.batch[0].features, isNotEmpty);
      expect(response.success!.batch[1].features, isNotEmpty);
    });
  });
}

import 'package:dio/dio.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  test("Places search test", () async {
    SearchBoxAPI search = SearchBoxAPI(
      apiKey: MAPBOX_KEY,
      limit: 6,
    );
    final CancelToken cancelToken = CancelToken();

    final searchPlaceResponseFuture = search.getSuggestions(
      "central",
      cancelToken: cancelToken,
    );

    final searchPlaceResponse = await searchPlaceResponseFuture;

    expect(searchPlaceResponse, isA<ApiResponse<SuggestionResponse>>());

    expect(searchPlaceResponse.failure, isNull);
    expect(searchPlaceResponse.success, isNotNull);
    expect(searchPlaceResponse.success!.suggestions, isNotEmpty);
    expect(searchPlaceResponse.success!.suggestions, hasLength(6));
  });

  test("Retrive Place by mapbox_id test", () async {
    SearchBoxAPI search = SearchBoxAPI(
      apiKey: MAPBOX_KEY,
      limit: 6,
    );

    final getPlaceResponse = await search.getPlace(
      "dXJuOm1ieHJldDo2cEJoQUJfQThHTV9Xa3djVVhRZmlWUHl6WUt4Y1Y0ZC0ycVVDdUVWZXJ3Rlh3RlYyd2Rma2RDdkFaak5tdm8zRUNkSmkxMGxyUlEzT3pBR1JEQ1k0M0NMaDFXSTlBOVg3X3EtR19sYll5WjViS0JncjJSN3Y2UW81LVJzZTZBQTZQdmlIdWpVa04wdEdBM1hpRjUwOWozQVVjUjl3R3lIdGlJVEJadWFNNF9QVlFEREpjLVBtNFBOWm5aQkUwWFZVSWZ6Z2dWQ2JrQV9fNHdHMDNIYzhvNWlmNXhta3lucjRfMGhrbUlXeEo4MzBBdjBWN2Z6X1JBTW1OaFhLbkhfSmczLXNNRG53QkJhSFZZNnpMcjZTQ3ZKWjhJUzhMRzNRS3d6UHBJaExXVGdURi10aVRFREVoSm0zSEdrSmIzZmJMY1NybmpUcFBfU1dyamJBTXY1RlpTekhyY3FKRmRjazFfSmhLZVFJV3lTMDBndk9BaDQtblhhZF9GUnJ4cFk4cEwzNTdScTBPdGQwUDRqQWszN1RzY3ZmZ2pzdENiUWE1b3VmWlJuUWRmUUFmemF2QzFBNUZuVTVlR3ZFSkdBb1h5TjRpeXdpZUZ3SW9wWm5GZGFFbW9qOWljb0ZfeXlPVXRnZ1BmY1pPNnJIeTc3U3FsOVNMU1o3WEJlVkd2QzdhNjBSS3o4UGZNcEhNQjE3U1k2M3R0UFhyRnZxbXA2aW9zYzRRN1U0ZXVmRThDTGsxNGMyQzhxLVhXeXlSbUVJcGdLNWI3UFI2YTNkRFhBbVhRc0p6RXMzYXBjbkwxbTdYUlJUQmdiQWpqZVNTNU94bnQtUXpLS3p5RHdFWXFpdEZ4SFFxVkVaWGJadEJ1RWlaNHR4ekxLN2I2Tm9sSnAzUW9tVTNGSEM0NHpfdkNXdWtrTXdQSjEtMDFTSjFXaTd2Z190YW1CeXV0cHd4WFkyMU5JbFpxM251Y29VMUlLM2NITGxWeWE2MExxOHhqLXJtTHJMUDRHSjV1ek1CQ0d2SlplVVJfdGZGTFBxTnoxQkxOMjl1VFlnOFkxMm1hTVR1WnlPM3pleC12VFBhSERnQk5nQ0p0NVVqTGt0aGFISW9obHZ6OTk4Vjh2Wjk3RmZZUGdxcU5rMUZDYVA1bUxMS3N3RjJCb3VWTV9HQThHYWVHYUsyanhDc25DTzI1SUpmZlhDTFFyYmdOakxYeXlhYUZTRE9VclF6ajhjeDMyWVVyZmxXOGZ6eHh3N0VEeXZBN0c0YkthendXaVVVZldIYXJDN0E4dUdTWUhKeXN3T2YwbzZmN0R3dXZHeDVCT056MTFpXzNmSnhzT3VlUHpERS1INnNVYk55Zl82OG5iNUEtUjMybkF1VXhWcjVjUUJKVXFUOWg2R1Z4N1hNanhEd2s0azhmTWFtdURScEdleURxaE1hNUZyM1ltcGducnNEODNpS1U5RkVQYklGNjJocnFnTWxSbHdzQmlMNTlhaGZ2SHgtT0FOTVZJV3RVcDlKVnZNU3hoSHZIOUNsd3A3eUV3Vks3VlJOa3FYZkdhU29jaElPallYZ2tHR2ZrVVp3OTdPNmpRM3VmNk53Y3RnS0w5WmpUUUs5VEQ0ZDdOVWNuRThJcUFPbkNpNnFubG55ZEZsTkdoZ3FkXzUxZWRDMkVFUmdtZEdESnB5bHd2NmdaNU5XcEdyQjhPNlJUaFFPMnZvRk56YmRpNUdBU2pDaTQtWkEydDNGRnd4OHFBWDh6NnFIV2hxdnFnT0ZtRDF3Y3Z1OW5jcWRpWTRTeEd6Mmc3Wmt0cnFaMS1TSGpOWE1Qc2dNeWs5cHlLclZHUE1zb0ZKRDlvWkNvLS1ScWljQVUyWWh4b0NXa21zVVlsZlpNaFFhdVdabWFheXNVYm9hY1BHS1VkWm9YVUYySDloTEdTMzlKUFVXejhxM3VFZTEtMkdfVUwxZ18xVTlkRmpYWG5oWGcyVF94RFF1SXlFUklqVUJUWFdKTE5kdHgwemtWby1iSVJ5d1ViXy1xRzdwc1Voc285b0dXcVlRal9LbHhVZ3V5ZXFnYldwZ244ZkNFZlRZZWJwM1A1T21nakFYclNFaW02d083SW9SbWRtUXJNVzl2R0MteDNSb3hrNS1JeXF5cW10NXFSaTZJV2VzUW9EM1UydTdTTDdkTWlBelBMQkpSVGo3VjE2d2hoUEhPSkFMZGVvMUI0VXhqOHVVbGRCZlB4X29CN1d6eVctX2tNZkEtaFFORDUxRjUyV2tBa29Wa204SUM0TFpKWDVLWUxwUXdTSzJqUWhGUnhUcE5MVnhWa1UtVFVlN251c01tRzhxRXJpa285VVRUOVROS2d6cVBuLTJLWDNCaFo0aTh1bElTMFNGZ3RYX2hkRmhpM2RWVDNDbEpJbk9QQWRnbTRUUkJwTGlEdTdWbXVUUDU5QTFzRjlLQmlLdUk9",
    );

    expect(getPlaceResponse, isA<ApiResponse<RetrieveResonse>>());
    expect(getPlaceResponse.failure, isNull);
    expect(getPlaceResponse.success, isNotNull);
    final getPlace = getPlaceResponse.success!;
    expect(getPlace.features, isNotEmpty);
    expect(getPlace.features, hasLength(6));
  });
}

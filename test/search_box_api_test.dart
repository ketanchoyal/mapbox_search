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

    SuggestionResponse searchPlace = await search.getSuggestions(
      "central",
    );

    expect(searchPlace, isA<SuggestionResponse>());
    expect(searchPlace.suggestions, isNotEmpty);
    expect(searchPlace.suggestions, hasLength(6));
  });

  test("Retrive Place by mapbox_id test", () async {
    SearchBoxAPI search = SearchBoxAPI(
      apiKey: MAPBOX_KEY,
      limit: 6,
    );

    RetrieveResonse searchPlace = await search.getPlace(
      "dXJuOm1ieHJldDowcE1SX2QteDlESmVPTm5lRlRMU3h0UjllWlFya1JVb2huLWhuOVJ3Z1RTUjdQQ0QyMUkta3hOTkNVRGp2Y1FxMDBoUzM3dk9oVzRCclBNWHg0SXl4Mm1RS250UE1HTmxKV2NBOW1mdE9lbGtBdGpzYVZDcVZwQ3hneUxQWl9UbkZkdS05WkRnbktQeTRLM2FwS2xNOVlpUVNyS2ZUak5wWGZIc3g0SHUtM3pnYUVDMWJKQVpEcDl3cktyMHlhUXAxUHY3MlVyeWd1a0l2Tk0zRVlVWG1ESW9DX09qM0VGajRFLVJkeGlSZEhRdDl3bzN3VkNmQm1ZZ2ExcExBaWY3UlI1RElwMDQzdnpMMTNVWlBxRWQ4NGE2X2RpenZvWjhWR2RsNF9VSHNReDlSUzdNb0RCZ0xTemt1VF9xREg0cEE1M2xVc182a3BsUERQZnRMM2U4N0d4a2tvWG84Q0g3UnEwUVJ6TTdYT296SUNRSTItb1JYX3VzZ2k2aHh1aC1tMjhUc0xQY1NOazBlclZJQURxdFZSWFdkem44YzdKZnBCcFFmcGR3WTJadkRHZ2s4bzMwZWlwTDdyek1WSGpqZjFWaDJhUzJmOGpLZFBubzFWXzBRRktBN3BHQnJneUlhX2JsT1ZwUjlYbk1aS3RDRDBXTldFU1FJMVNJU0EtRnY3T1lUS2ZYTGxqT3laYWNGMmJrU3hIMVBFdHhfUEhFUzR2TnlydHZkWncwdG5IT3d1OEZGczZSam9IaUt6czcxcTlZbG1RV0ZqTjh5TWVKRlJBZUJiR2VmZG5zV2hPVk9Ec3BzM3BZTkl2c1MwNjVJMUNxN0xwV0tVRUpNcnhkd01fUmplZWZmTjc2T1h1aGFCcU9hcGpUek9WUDBvcnZYUUpqVHdQQzNSdDVWUEMxQzBZUEJON1lBeFhVMGJxdnphSTBuNVJ5b25rdVlYU0ZTaWVnRGZVRE1CVldMeVhqUlpMcWNabzhCcms0RzFSRkZrVzJDSERkNFlXV2gxSXllWm9aSTJKZkliSzNSUU9MRDZScGhZd0JBTjJWc2hSdTlSVzZLcTM0WVNVVEZ1T3l2cGhkb2VUemhaRURadGMzLXJtSERUR3ZWS29ic3YzbjUxQmdJUncwYzVuLUcwZTk3Sm1TSGtZdlNycWJKbTdfMzJUZXhXdDlSUHI3ckNIdk03WjlZZmxMVDRqbWtjU182TkI4TFYxb1QxSFp1bFhkMmRwRHV5ZlJhTGVWWWFIVjJhY0NERWNaQjNGSHZ5WG5naVhlQWxQTWdfY2JjanVuSzkwOVhNMVpFS1BENGhWclBSdVBTQkFjTFBHNzdpSktTV0FmdzZqaUFkaU5CT05aSWhiSXlKbmdZakZSU3FucFRPSlI2RjhBM1FtaGh2empxT2lZZHk4VFdxV3NxaUpCMUFUNVQ5VVM2WEJncU0yQjJ2TWF2bF9uZUFwU3ltcXBGTTdEa1hZZ3lTU3BnTFFpQjJ5RHdJVDY1OWwyR3ZReDZrRnJ2V29LdDc2UkhlOWc0ZFlrZ0N4VkcxWnZlcWlyTHo0RWFuelBaR3gzTk1wdk1qMVZ6bjVzeUlFdVBEUXE5Ym5DcEF5LVA0UTdmdVlQV29GU2pqWmloYWtMbm1IOXYxRkFNNTdNMGJEZk5QQTdjR2tZRmxnSW5lUGZZU0dwVlpfUzZkeV8zZDdsTlkwTXNqaW0td2w5cTJhb1E3UzZSUEI5X1BDR3dFbjhHOUR4dHREcm9TN3VWQ25mTmNjSjhwZmVPMm9hd3N1aUNYZlhiRExnQ0IwNHplZ2ZoUk5vTDJMc3BxVjJHRkdpLVBZNmZjOTB6VTNJdkNwYVNDeG4yaF94QmpjWDBNdXRZNXpiVEs2Tmp1dnQtZkwxWXpoVkxoVGxwbkhfOFhrQVlZSTRYNmN3Q2UzRnlBcEFNemY5VzdKVFNiZEpvZmRKOUNHM1d4ZGR4bE5FWkJUM0hBTG9ieGI3MGF6bld3SUlyZHo5UFk1bHBQb3VDODN1NFM3RDdhay1TeG1FNTd3eTZRZ0pGX1ZETU0zZ0Q1WVBsZ05RV180WnUxX3hjd0ZFMXJKWmNPczdWd1NabzZDRXVXSHJtVmRtSGp4aVJSNjMwdz09",
    );

    expect(searchPlace, isA<RetrieveResonse>());
    expect(searchPlace.features, isNotEmpty);
    expect(searchPlace.features, hasLength(1));
  });
}

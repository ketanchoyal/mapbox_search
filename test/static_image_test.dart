import 'dart:io';

import 'package:mapbox_search/colors/color.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  group('static image', () {
    late StaticImage staticImage;

    setUp(() {
      staticImage = StaticImage(apiKey: MAPBOX_KEY);
    });

    test('polyline', () async {
      var polylineUri = staticImage.getStaticUrlWithPolyline(
        point1: Location(lat: 37.77343, lng: -122.46589),
        point2: Location(lat: 37.75965, lng: -122.42816),
        marker1: MapBoxMarker(
            markerColor: Color.rgb(0, 0, 0) as RgbColor,
            markerLetter: MakiIcons.aerialway.value,
            markerSize: MarkerSize.LARGE),
        marker2: MapBoxMarker(
            markerColor: Color.rgb(244, 67, 54) as RgbColor,
            markerLetter: 'q',
            markerSize: MarkerSize.SMALL),
        height: 300,
        width: 600,
        zoomLevel: 15.5,
        style: MapBoxStyle.Dark,
        render2x: true,
        center: Location(lat: 37.766541503617475, lng: -122.44702324243272),
        auto: true,
      );

      // print(polylineUri);

      expect(
          polylineUri,
          Uri.parse(
              "https://api.mapbox.com/styles/v1/mapbox/dark-v10/static/pin-l-aerialway+000000(-122.46589,37.77343),pin-s-q+f44336(-122.42816,37.75965),path-5+723436-0.5(%7DrpeFxbnjVsFwdAvr@cHgFor@jEmAlFmEMwM_FuItCkOi@wc@bg@wBSgM)/auto/600x300@2x?access_token=$MAPBOX_KEY"));
      expect(polylineUri, isNotNull);

      var req = await HttpClient().getUrl(polylineUri);
      var resp = await req.close();
      expect(resp.statusCode, 200);
    });
    test('with Marker', () async {
      var uriWithMarker = staticImage.getStaticUrlWithMarker(
        center: Location(lat: 37.77343, lng: -122.46589),
        marker: MapBoxMarker(
            markerColor: Color.rgb(0, 0, 0) as RgbColor,
            markerLetter: 'p',
            markerSize: MarkerSize.LARGE),
        height: 300,
        width: 600,
        zoomLevel: 15.5,
        style: MapBoxStyle.Streets,
        render2x: true,
      );

      // print(withMarker);

      expect(
          uriWithMarker,
          Uri.parse(
              "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l-p+000000(-122.46589,37.77343)/-122.46589,37.77343,15.5,0,20/600x300@2x?access_token=$MAPBOX_KEY"));

      expect(uriWithMarker, isNotNull);

      var req = await HttpClient().getUrl(uriWithMarker);
      var resp = await req.close();
      expect(resp.statusCode, 200);
    });
    test('without Marker', () async {
      var uriWithoutMarker = staticImage.getStaticUrlWithoutMarker(
        center: Location(lat: 37.75965, lng: -122.42816),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Outdoors,
        render2x: true,
      );

      // print(withoutMarker);

      expect(
          uriWithoutMarker,
          Uri.parse(
              "https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/-122.42816,37.75965,16.0,0,20/600x300@2x?access_token=$MAPBOX_KEY"));

      expect(uriWithoutMarker, isNotNull);

      var req = await HttpClient().getUrl(uriWithoutMarker);
      var resp = await req.close();
      expect(resp.statusCode, 200);
    });
  });
}

part of mapbox_search;

enum MapBoxStyle {
  Light("light-v10"),
  Dark("dark-v10"),
  Streets("streets-v11"),
  Outdoors("outdoors-v11"),
  Satellite_V9("satellite-v9"),
  Satellite_Street_V11("satellite-streets-v11");

  const MapBoxStyle(this.value);

  final String value;
}

// extension MapBoxStyleHelper on MapBoxStyle {
//   String get value {
//     switch (this) {
//       case MapBoxStyle.Light:
//         return 'light-v10';
//       case MapBoxStyle.Dark:
//         return 'dark-v10';
//       case MapBoxStyle.Streets:
//         return 'streets-v11';
//       case MapBoxStyle.Outdoors:
//         return 'outdoors-v11';
//       case MapBoxStyle.Satellite_V9:
//         return 'satellite-v9';
//       case MapBoxStyle.Satellite_Street_V11:
//         return 'satellite-streets-v11';
//       default:
//         return 'light-v10';
//     }
//   }
// }

enum MarkerSize {
  SMALL('s'),
  MEDIUM('m'),
  LARGE('l');

  const MarkerSize(this.value);

  final String value;
}

// extension MarkerSizeHelper on MarkerSize {
//   String get value {
//     switch (this) {
//       case MarkerSize.SMALL:
//         return 's';
//       case MarkerSize.MEDIUM:
//         return 'm';
//       case MarkerSize.LARGE:
//         return 'l';
//       default:
//         return 'm';
//     }
//   }
// }

class StaticImage {
  final String apiKey;

  StaticImage({
    required this.apiKey,
  });

  final double _defaultZoomLevel = 15;
  final int _defaultWidth = 600;
  final int _defaultHeight = 400;

  ///rotates the map around its center(from -180 to 180)
  final int _defaultBearing = 0;

  ///tilts the map (perspective effect)(from 0 to 60)
  final int _defaultPitch = 20;

  final MapBoxStyle _defaultMapStyle = MapBoxStyle.Outdoors;

  ///@2x renders the map at 2x scale
  final bool _defaultRender2x = false;

  final String _render2x = "@2x";
  final String _empty = "";

  final MapBoxMarker _defaultMarker = MapBoxMarker(
    markerColor: Color.rgb(0, 0, 0) as RgbColor,
    markerLetter: 'p',
    markerSize: MarkerSize.LARGE,
  );

  final MapBoxPath _defaultPath = MapBoxPath(
    pathColor: Color.rgb(114, 52, 54) as RgbColor,
    pathOpacity: 0.5,
    pathWidth: 5,
    pathPolyline: "%7DrpeFxbnjVsFwdAvr@cHgFor@jEmAlFmEMwM_FuItCkOi@wc@bg@wBSgM",
  );

  Uri _buildBaseUri({MapBoxStyle? style}) {
    return Uri.parse(
        "https://api.mapbox.com/styles/v1/mapbox/${(style ?? _defaultMapStyle).value}/static");
  }

  Uri _buildParams(
    Uri uri, {
    Location? center,
    num? zoomLevel,
    int? width,
    int? height,

    ///rotates the map around its center(from -180 to 180)
    int? bearing,

    ///tilts the map (perspective effect)(from 0 to 60)
    int? pitch,

    ///@2x renders the map at 2x scale
    bool? render2x,

    /// ignore all customization and adjust map automatically
    bool? auto = false,
  }) {
    if (auto != null && auto) {
      uri = uri.replace(path: uri.path + "/auto");
    } else {
      if (center != null) {
        uri = uri.replace(path: uri.path + "/${center.asString},");
      }
      uri = uri.replace(
          path: uri.path +
              "${zoomLevel?.toDouble() ?? _defaultZoomLevel}," +
              "${bearing ?? _defaultBearing}," +
              "${pitch ?? _defaultPitch}");
    }
    uri = uri.replace(
        path: uri.path +
            "/${width ?? _defaultWidth}x${height ?? _defaultHeight}" +
            "${render2x ?? _defaultRender2x ? _render2x : _empty}");
    // url.write("?access_token=$apiKey");
    uri = uri.replace(queryParameters: {"access_token": apiKey});

    return uri;
  }

  String _generateMarkerLink(String url) {
    if (!url.contains('http')) {
      print("Invalid marker url: $url");
      print("Using default marker");
      return _defaultMarker.toString();
    }

    String slash = "%2F";
    String semiColon = "%3A";

    url = url.replaceAll('/', slash);
    url = url.replaceAll(':', semiColon);

    url = "url-$url";

    return url;
  }

  /// When `auto` is set to `true`, the map will adjust automatically to fit the
  /// provided markers and paths.
  ///
  /// If `auto` is `true` then `center`, `zoomLevel`, `bearing`, `pitch` will be ignored.
  Uri getStaticUrlWithoutMarker(
      {Location? center,
      num? zoomLevel,
      int? width,
      int? height,

      ///rotates the map around its center(from -180 to 180)
      int? bearing,

      ///tilts the map (perspective effect)(from 0 to 60)
      int? pitch,
      MapBoxStyle? style,

      ///@2x renders the map at 2x scale
      bool? render2x,

      /// ignore all customization and adjust map automatically
      bool? auto}) {
    Uri uri = _buildBaseUri(style: style);
    uri = _buildParams(uri,
        bearing: bearing,
        center: center,
        height: height,
        pitch: pitch,
        render2x: render2x,
        width: width,
        zoomLevel: zoomLevel,
        auto: auto);

    return uri;
  }

  /// When `auto` is set to `true`, the map will adjust automatically to fit the
  /// provided markers and paths.
  ///
  /// If `auto` is `true` then `zoomLevel`, `bearing`, `pitch` will be ignored.
  ///
  /// [render2x] is used to render the map at 2x scale.
  ///
  /// [marker] is used to render a custom marker.
  ///
  /// [markerUrl] is used to render a custom marker using a image/marker url.
  ///
  /// If both [marker] and [markerUrl] are provided then [marker] will be used.
  Uri getStaticUrlWithMarker({
    required Location center,
    num? zoomLevel,
    int? width,
    int? height,

    ///rotates the map around its center(from -180 to 180)
    int? bearing,

    ///tilts the map (perspective effect)(from 0 to 60)
    int? pitch,
    MapBoxStyle? style,

    ///@2x renders the map at 2x scale
    bool? render2x,

    ///Custom Marker url
    String? markerUrl,

    ///Custom marker
    MapBoxMarker? marker,

    /// ignore all customization and adjust map automatically
    bool? auto,
  }) {
    String pinUrl = marker == null
        ? _generateMarkerLink(markerUrl ?? _defaultMarker.toString())
        : marker.toString();

    Uri uri = _buildBaseUri(style: style);
    uri = uri.replace(path: uri.path + "/$pinUrl(${center.asString})");
    uri = _buildParams(uri,
        bearing: bearing,
        height: height,
        pitch: pitch,
        center: center,
        render2x: render2x,
        width: width,
        zoomLevel: zoomLevel,
        auto: auto);

    return uri;
  }

  /// ## Retrieve a map with two points and a polyline overlay,
  /// When `auto` is set to `true`, the map will adjust automatically to fit the
  /// provided markers and paths.
  ///
  /// If `auto` is `true` then `center`, `zoomLevel`, `pitch` will be ignored.
  ///
  /// [render2x] is used to render the map at 2x scale.
  ///
  /// [marker1] and [marker2] are used to render a custom markers.
  ///
  /// [markerUrl1] and [markerUrl2] are used to render a custom markers using a image/marker url.
  ///
  /// If both [marker1] and [markerUrl1] are provided then [marker1] will be used.
  Uri getStaticUrlWithPolyline({
    required Location point1,
    required Location point2,
    num? zoomLevel,
    int? width,
    int? height,
    Location? center,

    ///rotates the map around its center(from -180 to 180)
    int? bearing,

    ///tilts the map (perspective effect)(from 0 to 60)
    int? pitch,
    MapBoxStyle? style,

    ///@2x renders the map at 2x scale
    bool? render2x,

    /// ignore all customization and adjust map automatically
    bool? auto,

    ///Custom Marker url
    @Deprecated('Please use `markerUrl1` and  `markerUrl2` instead')
        String? markerUrl,
    MapBoxPath? path,
    MapBoxMarker? marker1,
    String? markerUrl1,
    MapBoxMarker? marker2,
    String? markerUrl2,
  }) {
    String pinUrl1 = marker1 == null
        ? _generateMarkerLink(
            markerUrl1 ?? markerUrl ?? _defaultMarker.toString())
        : marker1.toString();

    String pinUrl2 = marker2 == null
        ? _generateMarkerLink(
            markerUrl2 ?? markerUrl ?? _defaultMarker.toString())
        : marker2.toString();

    Uri uri = _buildBaseUri(style: style);

    uri = uri.replace(
        path: uri.path +
            "/$pinUrl1(${point1.asString}),$pinUrl2(${point2.asString}),${path ?? _defaultPath}");

    uri = _buildParams(uri,
        bearing: bearing,
        center: center,
        height: height,
        pitch: pitch,
        render2x: render2x,
        width: width,
        zoomLevel: zoomLevel,
        auto: auto);

    return uri;
  }
}

class MapBoxMarker {
  final RgbColor markerColor;

  final MarkerSize markerSize;

  /**
   * letter to display on pin(from 0 to 99 and A to Z)
   *
   * [MakiIcons] can also be used now
   *
   * Example:
   * ```dart
   * MakiIcons.airport.value
   *
   * ```
   **/
  final String markerLetter;

  MapBoxMarker({
    required this.markerColor,
    required this.markerSize,
    required this.markerLetter,
  }) : assert(markerLetter.runtimeType == String);

  @override
  String toString() {
    String color = markerColor.toHexColor().toString();
    String marker = "pin-${markerSize.value}-$markerLetter+$color";
    return marker;
  }
}

class MapBoxPath {
  final RgbColor pathColor;

  final int pathWidth;

  final double pathOpacity;
  final String pathPolyline;

  MapBoxPath({
    required this.pathColor,
    required this.pathWidth,
    required this.pathPolyline,
    required this.pathOpacity,
  });

  @override
  String toString() {
    String color = pathColor.toHexColor().toString();
    String path = "path-$pathWidth+$color-$pathOpacity(${pathPolyline})";
    return path;
  }
}

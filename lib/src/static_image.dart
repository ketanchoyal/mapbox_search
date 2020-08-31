part of mapbox_search;

enum MapBoxStyle {
  Light,
  Dark,
  Streets,
  Outdoors,
  Satellite_V9,
  Satellite_Street_V11,
}

class MapBoxStyleHelper {
  static String getValue(MapBoxStyle mapBoxStyle) {
    switch (mapBoxStyle) {
      case MapBoxStyle.Light:
        return 'light-v10';
      case MapBoxStyle.Dark:
        return 'dark-v10';
      case MapBoxStyle.Streets:
        return 'streets-v11';
      case MapBoxStyle.Outdoors:
        return 'outdoors-v11';
      case MapBoxStyle.Satellite_V9:
        return 'satellite-v9';
      case MapBoxStyle.Satellite_Street_V11:
        return 'satellite-streets-v11';
      default:
        return 'light-v10';
    }
  }
}

enum MarkerSize { SMALL, MEDIUM, LARGE }

class MarkerSizeHelper {
  static String getValue(MarkerSize size) {
    switch (size) {
      case MarkerSize.SMALL:
        return 's';
      case MarkerSize.MEDIUM:
        return 'm';
      case MarkerSize.LARGE:
        return 'l';
      default:
        return 'm';
    }
  }
}

class StaticImage {
  final String apiKey;

  StaticImage({
    this.apiKey,
  }) : assert(apiKey != null);

  final int _defaultZoomLevel = 15;
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
    markerColor: Color.rgb(0, 0, 0),
    markerLetter: 'p',
    markerSize: MarkerSize.LARGE,
  );

  final MapBoxPath _defaultPath = MapBoxPath(
    pathColor: Color.rgb(244, 67, 54),
    pathOpacity: 0.5,
    pathWidth: 5,
    pathPolyline: "%7DrpeFxbnjVsFwdAvr@cHgFor@jEmAlFmEMwM_FuItCkOi@wc@bg@wBSgM",
  );

  void _buildBaseUrl(StringBuffer url, {MapBoxStyle style}) {
    url.write(
        "https://api.mapbox.com/styles/v1/mapbox/${MapBoxStyleHelper.getValue(style ?? _defaultMapStyle)}/static");
  }

  void _buildParams(
    StringBuffer url, {
    Location center,
    int zoomLevel,
    int width,
    int height,

    ///rotates the map around its center(from -180 to 180)
    int bearing,

    ///tilts the map (perspective effect)(from 0 to 60)
    int pitch,

    ///@2x renders the map at 2x scale
    bool render2x,

    /// ignore all customization and adjust map automatically
    bool auto = false,
  }) {
    if (auto != null && auto) {
      url.write("/auto");
    } else {
      url
        ..write("/${center.lng},${center.lat},")
        ..write("${zoomLevel ?? _defaultZoomLevel},")
        ..write("${bearing ?? _defaultBearing},")
        ..write("${pitch ?? _defaultPitch}");
    }
    url
      ..write("/${width ?? _defaultWidth}x${height ?? _defaultHeight}")
      ..write("${render2x ?? _defaultRender2x ? _render2x : _empty}")
      ..write("?access_token=$apiKey");
  }

  String _generateMarkerLink(String url) {
    if (!url.contains('http')) {
      return _defaultMarker.toString();
    }

    String slash = "%2F";
    String semiColon = "%3A";

    url = url.replaceAll('/', slash);
    url = url.replaceAll(':', semiColon);

    url = "url-$url";

    return url;
  }

  String getStaticUrlWithoutMarker(
      {Location center,
      int zoomLevel,
      int width,
      int height,

      ///rotates the map around its center(from -180 to 180)
      int bearing,

      ///tilts the map (perspective effect)(from 0 to 60)
      int pitch,
      MapBoxStyle style,

      ///@2x renders the map at 2x scale
      bool render2x,

      /// ignore all customization and adjust map automatically
      bool auto}) {
    var url = StringBuffer();
    _buildBaseUrl(url, style: style);
    _buildParams(url,
        bearing: bearing,
        center: center,
        height: height,
        pitch: pitch,
        render2x: render2x,
        width: width,
        zoomLevel: zoomLevel,
        auto: auto);

    return url.toString();
  }

  String getStaticUrlWithMarker({
    Location center,
    int zoomLevel,
    int width,
    int height,

    ///rotates the map around its center(from -180 to 180)
    int bearing,

    ///tilts the map (perspective effect)(from 0 to 60)
    int pitch,
    MapBoxStyle style,

    ///@2x renders the map at 2x scale
    bool render2x,

    ///Custom Marker url
    String markerUrl,

    ///Custom marker
    MapBoxMarker marker,

    /// ignore all customization and adjust map automatically
    bool auto,
  }) {
    String pinUrl = marker == null
        ? _generateMarkerLink(markerUrl ?? _defaultMarker.toString())
        : marker.toString();
    var url = StringBuffer();
    _buildBaseUrl(url, style: style);
    url.write("/$pinUrl(${center.lng},${center.lat})");
    _buildParams(url,
        bearing: bearing,
        center: center,
        height: height,
        pitch: pitch,
        render2x: render2x,
        width: width,
        zoomLevel: zoomLevel,
        auto: auto);

    return url.toString();
  }

  /// # Retrieve a map with two points and a polyline overlay,
  String getStaticUrlWithPolyline({
    Location point1,
    Location point2,
    int zoomLevel,
    int width,
    int height,
    Location center,

    ///rotates the map around its center(from -180 to 180)
    int bearing,

    ///tilts the map (perspective effect)(from 0 to 60)
    int pitch,
    MapBoxStyle style,

    ///@2x renders the map at 2x scale
    bool render2x,

    /// ignore all customization and adjust map automatically
    bool auto,

    ///Custom Marker url
    String markerUrl,
    MapBoxPath path,
    MapBoxMarker marker1,
    MapBoxMarker marker2,
  }) {
    String pinUrl1 = marker1 == null
        ? _generateMarkerLink(markerUrl ?? _defaultMarker.toString())
        : marker1.toString();

    String pinUrl2 = marker2 == null
        ? _generateMarkerLink(markerUrl ?? _defaultMarker.toString())
        : marker2.toString();
    var url = StringBuffer();
    _buildBaseUrl(url, style: style);
    url
      ..write("/$pinUrl1(${point1.lng},${point1.lat}),")
      ..write("$pinUrl2(${point2.lng},${point2.lat}),")
      ..write("${path ?? _defaultPath}");

    _buildParams(url,
        bearing: bearing,
        center: center,
        height: height,
        pitch: pitch,
        render2x: render2x,
        width: width,
        zoomLevel: zoomLevel,
        auto: auto);

    return url.toString();
  }
}

class MapBoxMarker {
  final RgbColor markerColor;

  final MarkerSize markerSize;

  /// letter to display on pin(from 0 to 99 and a to z)
  final String markerLetter;

  MapBoxMarker({
    this.markerColor,
    this.markerSize,
    this.markerLetter,
  })  : assert(markerColor != null),
        assert(markerLetter != null),
        assert(markerSize != null);

  @override
  String toString() {
    String color = markerColor.htmlColorNotation;
    String marker =
        "pin-${MarkerSizeHelper.getValue(markerSize)}-$markerLetter+$color";
    return marker;
  }
}

class MapBoxPath {
  final RgbColor pathColor;

  final int pathWidth;

  final double pathOpacity;
  final String pathPolyline;

  MapBoxPath({
    this.pathColor,
    this.pathWidth,
    this.pathPolyline,
    this.pathOpacity,
  })  : assert(pathColor != null),
        assert(pathOpacity != null),
        assert(pathPolyline != null),
        assert(pathWidth != null);

  @override
  String toString() {
    String color = pathColor.htmlColorNotation;
    String path = "path-$pathWidth+$color-$pathOpacity(${pathPolyline})";
    return path;
  }
}

extension on RgbColor {
  String get htmlColorNotation =>
      r.toInt().toRadixString(16) +
      g.toInt().toRadixString(16) +
      b.toInt().toRadixString(16);
}

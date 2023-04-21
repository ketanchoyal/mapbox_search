part of mapbox_search;

class BBox {
  Location min;
  Location max;

  BBox({
    required this.min,
    required this.max,
  });

  String get asString => '${min.lng},${min.lat},${max.lng},${max.lat}';
}

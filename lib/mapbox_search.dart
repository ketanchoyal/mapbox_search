library mapbox_search;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:color/color.dart';
import 'package:uuid/uuid.dart';

export 'package:color/color.dart';

part 'models/predictions.dart';
part 'models/location_context.dart';
part 'models/geometry.dart';
part 'models/suggestion_response.dart';
part 'models/retrieve_response.dart';
part 'models/failure_response.dart';

part 'generated_enums/poi_category.dart';
part 'generated_enums/maki_icons.dart';

part 'models/location.dart';
part 'models/bbox.dart';
part 'src/static_image.dart';
part 'src/search_box_api.dart';
part 'src/geocoding_api.dart';
// part "src/maki_icons.dart";
part 'src/place_types.dart';

final class MapBoxSearch {
  static String? _apiKey;

  MapBoxSearch.init(String apiKey) {
    _apiKey = apiKey;
  }
}

part of color;

class RgbColor extends Color implements CssColorSpace {
  final num r;
  final num g;
  final num b;
  static const int rMin = 0;
  static const int gMin = 0;
  static const int bMin = 0;
  static const int rMax = 255;
  static const int gMax = 255;
  static const int bMax = 255;

  /**
   * Creates a [Color] using a vector describing its red, green, and blue
   * values.
   *
   * The value for [r], [g], and [b] should be in the range between 0 and
   * 255 (inclusive).  Values above this range will be assumed to be a value
   * of 255, and values below this range will be assumed to be a value of 0.
   */
  const RgbColor(this.r, this.g, this.b);

  factory RgbColor.name(String name) {
    if (RgbColor.namedColors.containsKey(name)) {
      return RgbColor.namedColors[name]!;
    } else {
      throw new ArgumentError(
          "Only the color names defined by the CSS3 spec are supported. See http://www.w3.org/TR/css3-color/#svg-color for a list of valid color names.");
    }
  }

  RgbColor toRgbColor() => this;

  HslColor toHslColor() {
    num rf = r / 255;
    num gf = g / 255;
    num bf = b / 255;
    num cMax = [rf, gf, bf].reduce(max);
    num cMin = [rf, gf, bf].reduce(min);
    num delta = cMax - cMin;
    num hue;
    num saturation;
    num luminance;

    if (cMax == rf) {
      hue = 60 * ((gf - bf) / delta % 6);
    } else if (cMax == gf) {
      hue = 60 * ((bf - rf) / delta + 2);
    } else {
      hue = 60 * ((rf - gf) / delta + 4);
    }

    if (hue.isNaN || hue.isInfinite) {
      hue = 0;
    }

    luminance = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (luminance * 2 - 1).abs());
    }

    return new HslColor(hue, saturation * 100, luminance * 100);
  }

  HsvColor toHsvColor() => toHslColor().toHsvColor();

  XyzColor toXyzColor() {
    Map<String, num> rgb = {'r': r / 255, 'g': g / 255, 'b': b / 255};

    rgb.forEach((key, value) {
      if (value > 0.04045) {
        rgb[key] = pow((value + 0.055) / 1.055, 2.4);
      } else {
        rgb[key] = value / 12.92;
      }
      rgb[key] = rgb[key]! * 100;
    });

    num x = rgb['r']! * 0.4124 + rgb['g']! * 0.3576 + rgb['b']! * 0.1805;
    num y = rgb['r']! * 0.2126 + rgb['g']! * 0.7152 + rgb['b']! * 0.0722;
    num z = rgb['r']! * 0.0193 + rgb['g']! * 0.1192 + rgb['b']! * 0.9505;

    return XyzColor(x, y, z);
  }

  CielabColor toCielabColor() => this.toXyzColor().toCielabColor();

  HexColor toHexColor() => new HexColor.fromRgb(r, g, b);

  String toString() => "r: $r, g: $g, b: $b";

  String toCssString() => 'rgb(${r.toInt()}, ${g.toInt()}, ${b.toInt()})';

  Map<String, num?> toMap() => {'r': r, 'g': g, 'b': b};

  static const Map<String, RgbColor> namedColors = const {
    'aliceblue': const Color.rgb(240, 248, 255) as RgbColor,
    'antiquewhite': const Color.rgb(250, 235, 215) as RgbColor,
    'aqua': const Color.rgb(0, 255, 255) as RgbColor,
    'aquamarine': const Color.rgb(127, 255, 212) as RgbColor,
    'azure': const Color.rgb(240, 255, 255) as RgbColor,
    'beige': const Color.rgb(245, 245, 220) as RgbColor,
    'bisque': const Color.rgb(255, 228, 196) as RgbColor,
    'black': const Color.rgb(0, 0, 0) as RgbColor,
    'blanchedalmond': const Color.rgb(255, 235, 205) as RgbColor,
    'blue': const Color.rgb(0, 0, 255) as RgbColor,
    'blueviolet': const Color.rgb(138, 43, 226) as RgbColor,
    'brown': const Color.rgb(165, 42, 42) as RgbColor,
    'burlywood': const Color.rgb(222, 184, 135) as RgbColor,
    'cadetblue': const Color.rgb(95, 158, 160) as RgbColor,
    'chartreuse': const Color.rgb(127, 255, 0) as RgbColor,
    'chocolate': const Color.rgb(210, 105, 30) as RgbColor,
    'coral': const Color.rgb(255, 127, 80) as RgbColor,
    'cornflowerblue': const Color.rgb(100, 149, 237) as RgbColor,
    'cornsilk': const Color.rgb(255, 248, 220) as RgbColor,
    'crimson': const Color.rgb(220, 20, 60) as RgbColor,
    'cyan': const Color.rgb(0, 255, 255) as RgbColor,
    'darkblue': const Color.rgb(0, 0, 139) as RgbColor,
    'darkcyan': const Color.rgb(0, 139, 139) as RgbColor,
    'darkgoldenrod': const Color.rgb(184, 134, 11) as RgbColor,
    'darkgray': const Color.rgb(169, 169, 169) as RgbColor,
    'darkgreen': const Color.rgb(0, 100, 0) as RgbColor,
    'darkgrey': const Color.rgb(169, 169, 169) as RgbColor,
    'darkkhaki': const Color.rgb(189, 183, 107) as RgbColor,
    'darkmagenta': const Color.rgb(139, 0, 139) as RgbColor,
    'darkolivegreen': const Color.rgb(85, 107, 47) as RgbColor,
    'darkorange': const Color.rgb(255, 140, 0) as RgbColor,
    'darkorchid': const Color.rgb(153, 50, 204) as RgbColor,
    'darkred': const Color.rgb(139, 0, 0) as RgbColor,
    'darksalmon': const Color.rgb(233, 150, 122) as RgbColor,
    'darkseagreen': const Color.rgb(143, 188, 143) as RgbColor,
    'darkslateblue': const Color.rgb(72, 61, 139) as RgbColor,
    'darkslategray': const Color.rgb(47, 79, 79) as RgbColor,
    'darkslategrey': const Color.rgb(47, 79, 79) as RgbColor,
    'darkturquoise': const Color.rgb(0, 206, 209) as RgbColor,
    'darkviolet': const Color.rgb(148, 0, 211) as RgbColor,
    'deeppink': const Color.rgb(255, 20, 147) as RgbColor,
    'deepskyblue': const Color.rgb(0, 191, 255) as RgbColor,
    'dimgray': const Color.rgb(105, 105, 105) as RgbColor,
    'dimgrey': const Color.rgb(105, 105, 105) as RgbColor,
    'dodgerblue': const Color.rgb(30, 144, 255) as RgbColor,
    'firebrick': const Color.rgb(178, 34, 34) as RgbColor,
    'floralwhite': const Color.rgb(255, 250, 240) as RgbColor,
    'forestgreen': const Color.rgb(34, 139, 34) as RgbColor,
    'fuchsia': const Color.rgb(255, 0, 255) as RgbColor,
    'gainsboro': const Color.rgb(220, 220, 220) as RgbColor,
    'ghostwhite': const Color.rgb(248, 248, 255) as RgbColor,
    'gold': const Color.rgb(255, 215, 0) as RgbColor,
    'goldenrod': const Color.rgb(218, 165, 32) as RgbColor,
    'gray': const Color.rgb(128, 128, 128) as RgbColor,
    'green': const Color.rgb(0, 128, 0) as RgbColor,
    'greenyellow': const Color.rgb(173, 255, 47) as RgbColor,
    'grey': const Color.rgb(128, 128, 128) as RgbColor,
    'honeydew': const Color.rgb(240, 255, 240) as RgbColor,
    'hotpink': const Color.rgb(255, 105, 180) as RgbColor,
    'indianred': const Color.rgb(205, 92, 92) as RgbColor,
    'indigo': const Color.rgb(75, 0, 130) as RgbColor,
    'ivory': const Color.rgb(255, 255, 240) as RgbColor,
    'khaki': const Color.rgb(240, 230, 140) as RgbColor,
    'lavender': const Color.rgb(230, 230, 250) as RgbColor,
    'lavenderblush': const Color.rgb(255, 240, 245) as RgbColor,
    'lawngreen': const Color.rgb(124, 252, 0) as RgbColor,
    'lemonchiffon': const Color.rgb(255, 250, 205) as RgbColor,
    'lightblue': const Color.rgb(173, 216, 230) as RgbColor,
    'lightcoral': const Color.rgb(240, 128, 128) as RgbColor,
    'lightcyan': const Color.rgb(224, 255, 255) as RgbColor,
    'lightgoldenrodyellow': const Color.rgb(250, 250, 210) as RgbColor,
    'lightgray': const Color.rgb(211, 211, 211) as RgbColor,
    'lightgreen': const Color.rgb(144, 238, 144) as RgbColor,
    'lightgrey': const Color.rgb(211, 211, 211) as RgbColor,
    'lightpink': const Color.rgb(255, 182, 193) as RgbColor,
    'lightsalmon': const Color.rgb(255, 160, 122) as RgbColor,
    'lightseagreen': const Color.rgb(32, 178, 170) as RgbColor,
    'lightskyblue': const Color.rgb(135, 206, 250) as RgbColor,
    'lightslategray': const Color.rgb(119, 136, 153) as RgbColor,
    'lightslategrey': const Color.rgb(119, 136, 153) as RgbColor,
    'lightsteelblue': const Color.rgb(176, 196, 222) as RgbColor,
    'lightyellow': const Color.rgb(255, 255, 224) as RgbColor,
    'lime': const Color.rgb(0, 255, 0) as RgbColor,
    'limegreen': const Color.rgb(50, 205, 50) as RgbColor,
    'linen': const Color.rgb(250, 240, 230) as RgbColor,
    'magenta': const Color.rgb(255, 0, 255) as RgbColor,
    'maroon': const Color.rgb(128, 0, 0) as RgbColor,
    'mediumaquamarine': const Color.rgb(102, 205, 170) as RgbColor,
    'mediumblue': const Color.rgb(0, 0, 205) as RgbColor,
    'mediumorchid': const Color.rgb(186, 85, 211) as RgbColor,
    'mediumpurple': const Color.rgb(147, 112, 219) as RgbColor,
    'mediumseagreen': const Color.rgb(60, 179, 113) as RgbColor,
    'mediumslateblue': const Color.rgb(123, 104, 238) as RgbColor,
    'mediumspringgreen': const Color.rgb(0, 250, 154) as RgbColor,
    'mediumturquoise': const Color.rgb(72, 209, 204) as RgbColor,
    'mediumvioletred': const Color.rgb(199, 21, 133) as RgbColor,
    'midnightblue': const Color.rgb(25, 25, 112) as RgbColor,
    'mintcream': const Color.rgb(245, 255, 250) as RgbColor,
    'mistyrose': const Color.rgb(255, 228, 225) as RgbColor,
    'moccasin': const Color.rgb(255, 228, 181) as RgbColor,
    'navajowhite': const Color.rgb(255, 222, 173) as RgbColor,
    'navy': const Color.rgb(0, 0, 128) as RgbColor,
    'oldlace': const Color.rgb(253, 245, 230) as RgbColor,
    'olive': const Color.rgb(128, 128, 0) as RgbColor,
    'olivedrab': const Color.rgb(107, 142, 35) as RgbColor,
    'orange': const Color.rgb(255, 165, 0) as RgbColor,
    'orangered': const Color.rgb(255, 69, 0) as RgbColor,
    'orchid': const Color.rgb(218, 112, 214) as RgbColor,
    'palegoldenrod': const Color.rgb(238, 232, 170) as RgbColor,
    'palegreen': const Color.rgb(152, 251, 152) as RgbColor,
    'paleturquoise': const Color.rgb(175, 238, 238) as RgbColor,
    'palevioletred': const Color.rgb(219, 112, 147) as RgbColor,
    'papayawhip': const Color.rgb(255, 239, 213) as RgbColor,
    'peachpuff': const Color.rgb(255, 218, 185) as RgbColor,
    'peru': const Color.rgb(205, 133, 63) as RgbColor,
    'pink': const Color.rgb(255, 192, 203) as RgbColor,
    'plum': const Color.rgb(221, 160, 221) as RgbColor,
    'powderblue': const Color.rgb(176, 224, 230) as RgbColor,
    'purple': const Color.rgb(128, 0, 128) as RgbColor,
    'rebeccapurple': const Color.rgb(102, 51, 153) as RgbColor,
    'red': const Color.rgb(255, 0, 0) as RgbColor,
    'rosybrown': const Color.rgb(188, 143, 143) as RgbColor,
    'royalblue': const Color.rgb(65, 105, 225) as RgbColor,
    'saddlebrown': const Color.rgb(139, 69, 19) as RgbColor,
    'salmon': const Color.rgb(250, 128, 114) as RgbColor,
    'sandybrown': const Color.rgb(244, 164, 96) as RgbColor,
    'seagreen': const Color.rgb(46, 139, 87) as RgbColor,
    'seashell': const Color.rgb(255, 245, 238) as RgbColor,
    'sienna': const Color.rgb(160, 82, 45) as RgbColor,
    'silver': const Color.rgb(192, 192, 192) as RgbColor,
    'skyblue': const Color.rgb(135, 206, 235) as RgbColor,
    'slateblue': const Color.rgb(106, 90, 205) as RgbColor,
    'slategray': const Color.rgb(112, 128, 144) as RgbColor,
    'slategrey': const Color.rgb(112, 128, 144) as RgbColor,
    'snow': const Color.rgb(255, 250, 250) as RgbColor,
    'springgreen': const Color.rgb(0, 255, 127) as RgbColor,
    'steelblue': const Color.rgb(70, 130, 180) as RgbColor,
    'tan': const Color.rgb(210, 180, 140) as RgbColor,
    'teal': const Color.rgb(0, 128, 128) as RgbColor,
    'thistle': const Color.rgb(216, 191, 216) as RgbColor,
    'tomato': const Color.rgb(255, 99, 71) as RgbColor,
    'turquoise': const Color.rgb(64, 224, 208) as RgbColor,
    'violet': const Color.rgb(238, 130, 238) as RgbColor,
    'wheat': const Color.rgb(245, 222, 179) as RgbColor,
    'white': const Color.rgb(255, 255, 255) as RgbColor,
    'whitesmoke': const Color.rgb(245, 245, 245) as RgbColor,
    'yellow': const Color.rgb(255, 255, 0) as RgbColor,
    'yellowgreen': const Color.rgb(154, 205, 50) as RgbColor
  };
}

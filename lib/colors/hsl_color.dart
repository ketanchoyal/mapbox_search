part of color;

class HslColor extends Color implements CssColorSpace {
  final num h;
  final num s;
  final num l;
  static const num hMin = 0;
  static const num sMin = 0;
  static const num lMin = 0;
  static const num hMax = 360;
  static const num sMax = 100;
  static const num lMax = 100;

  /**
   * Creates a [HslColor] using a vector describing its hue, saturation, and
   * luminance.
   *
   * The [hue] is given as a number in degrees, typically ranging in value
   * between 0 and 360.  Values outside of this converted as `hue % 360` to
   * be fit into the standard angle range.
   *
   * The [saturation] is given as a percentage between 0 and 100 (inclusive).
   *
   * The [luminance] is given as a percentage between 0 and 100 (inclusive).
   */
  const HslColor(num this.h, num this.s, num this.l);

  RgbColor toRgbColor() {
    List<num> rgb = [0, 0, 0];

    num hue = h / 360 % 1;
    num saturation = s / 100;
    num luminance = l / 100;

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb = rgb.map((val) => val + (1 - saturation) * (0.5 - val)).toList();

    if (luminance < 0.5) {
      rgb = rgb.map((val) => luminance * 2 * val).toList();
    } else {
      rgb = rgb.map((val) => luminance * 2 * (1 - val) + 2 * val - 1).toList();
    }

    rgb = rgb.map((val) => (val * 255).round()).toList();

    return new RgbColor(rgb[0], rgb[1], rgb[2]);
  }

  HslColor toHslColor() => this;

  HsvColor toHsvColor() {
    num hslSaturation = s / 100;
    num lightness = l / 100;

    num value = lightness + hslSaturation * min(lightness, 1 - lightness);
    num saturation = value == 0 ? 0 : 2 * (1 - lightness / value);

    return HsvColor(h, saturation * 100, value * 100);
  }

  XyzColor toXyzColor() => this.toRgbColor().toXyzColor();

  CielabColor toCielabColor() => this.toRgbColor().toXyzColor().toCielabColor();

  String toString() => "h: $h, s: $s%, l: $l%";

  String toCssString() => 'hsl($h, $s%, $l%)';

  Map<String, num> toMap() => {'h': h, 's': s, 'l': l};
}

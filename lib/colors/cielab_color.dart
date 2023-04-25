part of color;

/// A color in the CIELAB color space.
class CielabColor extends Color {
  final num l;
  final num a;
  final num b;

  const CielabColor(this.l, this.a, this.b);

  RgbColor toRgbColor() {
    XyzColor xyz = toXyzColor();
    return xyz.toRgbColor();
  }

  /// Converts the color to HSL color space.
  HslColor toHslColor() => this.toRgbColor().toHslColor();

  /// Converts the color to HSV color space.
  HsvColor toHsvColor() => this.toRgbColor().toHsvColor();

  /// Converts the color to XYZ color space.
  XyzColor toXyzColor() {
    Map<String, num> xyz = {
      'x': a / 500 + (l + 16) / 116,
      'y': (l + 16) / 116,
      'z': (l + 16) / 116 - b / 200
    };

    xyz.forEach((key, value) {
      num cube = pow(value, 3);
      if (cube > 0.008856) {
        xyz[key] = cube;
      } else {
        xyz[key] = (value - 16 / 116) / 7.787;
      }
      xyz[key] = xyz[key]! * XyzColor.referenceWhite[key];
    });

    return XyzColor(xyz['x']!, xyz['y']!, xyz['z']!);
  }

  // Returns a CielabColor with the same color values as this Color.
  CielabColor toCielabColor() => this;

  String toString() => "l: $l, a: $a, b: $b";

  Map<String, num?> toMap() => {'l': l, 'a': a, 'b': b};
}

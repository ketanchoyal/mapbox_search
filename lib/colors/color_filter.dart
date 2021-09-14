part of color;

typedef Color FilterFunction(Color color, [List? args]);

class ColorFilter {
  final FilterFunction filterFunction;
  final Type baseType;

  ColorFilter(FilterFunction this.filterFunction, Type this.baseType);

  /**
   * Makes the color lighter by the percentage specified in the first argument, or by 10% if no percentage is specified. Percentages should be specified as a float, e.g. an argument of 0.25 will result in a color 25% lighter than the original. The lightening conversion is performed by adjusting the y component of the color in XYZ color space.
   */
  static ColorFilter lighten = new ColorFilter((Color inputColor, [List? args]) {
    CielabColor color = inputColor.toCielabColor();
    num percent = 0.1;
    if (args is List && args.length > 0 && args[0] is num) {
      percent = args[0];
    }
    return new CielabColor(color.l * (1 + percent), color.a, color.b);
  }, CielabColor);

  /**
   * Makes the color darker by the percentage specified in the first argument, or by 10% if no percentage is specified. Percentages should be specified as a float, e.g. an argument of 0.25 will result in a color 25% darker than the original. The darkening conversion is performed by adjusting the y component of the color in XYZ color space.
   */
  static ColorFilter darken = new ColorFilter((Color inputColor, [List? args]) {
    CielabColor color = inputColor.toCielabColor();
    num percent = 0.1;
    if (args is List && args.length > 0 && args[0] is num) {
      percent = args[0];
    }
    return new CielabColor(color.l * (1 - percent), color.a, color.b);
  }, CielabColor);

  /**
   * Converts the color into its sepia tone equivalent.
   */
  static ColorFilter sepia = new ColorFilter((Color baseColor, [List? args]) {
    RgbColor color = baseColor.toRgbColor();
    return new RgbColor(min(RgbColor.rMax, (color.r * 0.393 + color.g * 0.769 + color.b * 0.189)),
        min(RgbColor.gMax, (color.r * 0.349 + color.g * 0.686 + color.b * 0.168)),
        min(RgbColor.bMax, (color.r * 0.272 + color.g * 0.534 + color.b * 0.131))).toCielabColor();
  }, RgbColor);

  /**
   * Creates a greyscale color with the same perceived luminance as the source color (as given by the L* value of the color in the CieLAB color space).
   */
  static ColorFilter greyscale = new ColorFilter((Color inputColor, [List? args]) {
    CielabColor color = inputColor.toCielabColor();
    num rgbLevel = color.l * 255 / 100;
    return new RgbColor(rgbLevel, rgbLevel, rgbLevel).toCielabColor();
  }, CielabColor);

  /**
   * Inverts the color by flipping it along the red/green, blue/yellow, and light/dark axes.
   */
  static ColorFilter invert = new ColorFilter((Color inputColor, [List? args]) {
    CielabColor color = inputColor.toCielabColor();
    return new CielabColor(100 - color.l, -1 * color.a, -1 * color.b);
  }, CielabColor);

  /**
   * Magic method that allows instances of ColorFilter to be called as functions. The filter itself should be called as a function, rather than calling this method directly.
   */
  Color call(Color color, List args) {
    Type startingColorSpace = color.runtimeType;
    color = color._convert(this.baseType);
    color = this.filterFunction(color, args);
    color = color._convert(startingColorSpace);
    return color;
  }
}

part of color;

class HexColor extends RgbColor implements CssColorSpace {
  /**
   * Creates a [HexColor] using a [String] describing its RGB value in hex.
   *
   * The [hexCode] should be a string of 6 characters, each of which is a
   * valid hex character (0 through 9 and A through F).  Capital and lowercase
   * letters will work equally well.  Characters after the first 6 characters
   * will be ignored.  If non-valid hex characters are encountered, a
   * [FormatException] will be thrown.
   *
   * The [hexCode] should not be preceeded with a pound sign (#).
   */
  factory HexColor(String hexCode) {
    if (hexCode.startsWith('#')) {
      hexCode = hexCode.substring(1);
    }
    List<String> hexDigits = hexCode.split('');
    int r = int.parse(hexDigits.sublist(0, 2).join(), radix: 16);
    int g = int.parse(hexDigits.sublist(2, 4).join(), radix: 16);
    int b = int.parse(hexDigits.sublist(4).join(), radix: 16);
    return new HexColor.fromRgb(r, g, b);
  }

  const HexColor.fromRgb(num r, num g, num b) : super(r, g, b);

  get rHex => r.toInt().toRadixString(16).padLeft(2, '0');
  get gHex => g.toInt().toRadixString(16).padLeft(2, '0');
  get bHex => b.toInt().toRadixString(16).padLeft(2, '0');

  HexColor toHexColor() => this;

  String toString() => '$rHex$gHex$bHex';

  String toCssString() => '#$rHex$gHex$bHex';
}

part of color;

class ColorParser {
  static final RegExp _beginsHash = new RegExp("^#");
  static final RegExp _hexColorRegExp = new RegExp("^#?([\\da-fA-F]{6})\$");
  static final RegExp _hexColorAbbreviatedRegExp =
      new RegExp("^#?([\\da-fA-F]{3})\$");
  static final RegExp _rgbColorImplicitRegExp =
      new RegExp("^(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\$");
  static final RegExp _rgbColorExplicitRegExp = new RegExp(
      "^rgb\\(\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*\\)\$");
  static final RegExp _hslColorRegExp = new RegExp(
      "^hsl\\(\\s*(\\d{1,3})\\s*,\\s*(\\d+(\\.\\d*)?|\\.\\d+)%\\s*,\\s*(\\d+(\\.\\d*)?|\\.\\d+)%\\s*\\)\$");

  ///* The code above does the following:
  ///1. Trim the string to parse
  ///2. If it starts with #, it is a hex color
  ///3. If it matches the hex color regexp, it is a hex color
  ///4. If it matches the abbreviated hex color regexp, it is a hex color
  ///5. If it matches the rgb regexp, it is an rgb color
  ///6. If it matches the rgb regexp, it is an rgb color
  ///7. If it matches the hsl regexp, it is an hsl color
  ///8. If it matches the named regexp, it is a named color
  ///9. If none of the above are true, return null or the fallback color */
  Color? parse(String toParse, {Color orElse()?}) {
    toParse = toParse.trim();
    return _parseRgb(toParse) ??
        _parseHex(toParse) ??
        _parseHsl(toParse) ??
        _parseNamed(toParse) ??
        orElse?.call() ??
        null;
  }

  Color? _parseHex(String toParse) {
    if (_hexColorRegExp.hasMatch(toParse)) {
      return new HexColor(toParse);
    }

    if (_hexColorAbbreviatedRegExp.hasMatch(toParse)) {
      String _unAbbreviated = new String.fromCharCodes(toParse
          .replaceFirst(_beginsHash, "")
          .codeUnits
          .map((c) => [c, c])
          .expand((c) => c));
      return new HexColor(_unAbbreviated);
    }

    return null;
  }

  Color? _parseHsl(String toParse) {
    if (_hslColorRegExp.hasMatch(toParse)) {
      Match match = _hslColorRegExp.allMatches(toParse).first;
      return new HslColor(
          int.parse(match.group(1)!),
          double.parse(match.group(2) ?? match.group(3)!),
          double.parse(match.group(4) ?? match.group(5)!));
    }

    return null;
  }

  Color? _parseRgb(String toParse) {
    if (_rgbColorImplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbColorImplicitRegExp.allMatches(toParse).first;
      return new RgbColor(int.parse(match.group(1)!),
          int.parse(match.group(2)!), int.parse(match.group(3)!));
    }

    if (_rgbColorExplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbColorExplicitRegExp.allMatches(toParse).first;
      return new RgbColor(int.parse(match.group(1)!),
          int.parse(match.group(2)!), int.parse(match.group(3)!));
    }

    return null;
  }

  Color? _parseNamed(String toParse) {
    try {
      return new RgbColor.name(toParse.toLowerCase());
    } catch (argumentError) {
      return null;
    }
  }
}

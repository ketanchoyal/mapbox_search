import 'dart:io';

import 'enum_values.dart';

void main() {
  _logic('POICategory', poi_values, 'poi_category.dart');
}

// codegen function

void _logic(String enumName, List<String> values, String fileName) {
  final StringBuffer enumStringBuffer = StringBuffer(
      '/// This file is auto-generated. Do not modify it manually.\n\n');

  enumStringBuffer.write('enum $enumName {\n');
  for (final value in values) {
    final isLast = value == values.last;
    String camelCaseValue = _toCamelCase(value);
    if (isLast) {
      enumStringBuffer.write('  ${camelCaseValue}(\'${value}\');\n');
    } else {
      enumStringBuffer.write('  ${camelCaseValue}(\'${value}\'),\n');
    }
  }
  enumStringBuffer.write('\n');
  enumStringBuffer.write('  const $enumName(this.value);\n');
  enumStringBuffer.write('  final String value;\n');
  enumStringBuffer.write('}\n');

  enumStringBuffer.write('\n');

  // Extension Method
  enumStringBuffer.write('extension ${enumName}Extension on $enumName {\n');
  enumStringBuffer.write("  $enumName? fromString(String? value) {\n");
  enumStringBuffer.write("    if (value == null) return null;\n");
  enumStringBuffer.write("    try {\n");
  enumStringBuffer.write(
      "      return $enumName.values.firstWhere((e) => e.value == value);\n");
  enumStringBuffer.write("    } catch (e) {\n");
  enumStringBuffer.write("      return null;\n");
  enumStringBuffer.write("    }\n");
  enumStringBuffer.write("  }\n");
  enumStringBuffer.write("}\n");

  final File file = File('lib/generated_enums/$fileName');
  if (file.existsSync()) {
    file.deleteSync();
  }
  file.writeAsStringSync(enumStringBuffer.toString());

  print('Enum written to file.');
}

String _toCamelCase(String value) {
  final List<String> parts =
      value.contains(' ') ? value.split(' ') : value.split('_');
  final StringBuffer camelCaseStringBuffer = StringBuffer(parts[0]);

  for (int i = 1; i < parts.length; i++) {
    camelCaseStringBuffer
        .write(parts[i][0].toUpperCase() + parts[i].substring(1));
  }

  return camelCaseStringBuffer.toString();
}

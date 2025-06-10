import 'dart:convert';
import 'dart:io';

void main() async {
  const inputFilePath = 'assets/strings.json';
  const outputFilePath = 'lib/src/utils/app_strings.dart';

  // read json file
  final inputFile = File(inputFilePath);
  if (!await inputFile.exists()) {
    exit(1);
  }

  final jsonContent = await inputFile.readAsString();
  final Map<String, dynamic> strings = json.decode(jsonContent);

  // build dart file content
  final buffer = StringBuffer();
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: constant_identifier_names');
  buffer.writeln('');
  buffer.writeln('class SubscriptionsManagementStrings {');
  buffer.writeln(
    '  SubscriptionsManagementStrings(); // Construtor privado para evitar instâncias',
  );
  buffer.writeln('');

  strings.forEach((key, value) {
    buffer.writeln('  final String $key = \'$value\';');
  });

  buffer.writeln('}');

  // Write the output content
  final outputFile = File(outputFilePath);
  await outputFile.writeAsString(buffer.toString());
}

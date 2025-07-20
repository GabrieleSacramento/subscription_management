import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(num value) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(value);
  }

  static String formatInput(String value) {
    if (value.isEmpty) return '';

    String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericValue.isEmpty) return '';

    double amount = double.parse(numericValue) / 100;

    return format(amount);
  }

  static double? parse(String value) {
    if (value.isEmpty) return null;

    // Remove o símbolo da moeda (R$), espaços e pontos de milhares
    String cleanValue = value
        .replaceAll('R\$', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '.');

    return double.tryParse(cleanValue);
  }
}

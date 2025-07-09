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
}

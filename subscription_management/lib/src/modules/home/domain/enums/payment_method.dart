enum PaymentMethod {
  creditCard,
  debitCard,
  pix;

  String get name {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Crédito';
      case PaymentMethod.debitCard:
        return 'Débito';
      case PaymentMethod.pix:
        return 'Pix';
    }
  }

  static PaymentMethod? getPaymentMethodFromString(String? value) {
    switch (value) {
      case 'Cartão de Débito': // ou strings.debitCard
        return PaymentMethod.debitCard;
      case 'Cartão de Crédito': // ou strings.creditCard
        return PaymentMethod.creditCard;
      case 'PIX': // ou strings.pix
        return PaymentMethod.pix;
      default:
        return null;
    }
  }
}

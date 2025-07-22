enum PaymentMethod {
  creditCard,
  debitCard,
  pix;

  static String? getStringFromPaymentMethod(PaymentMethod? paymentMethod) {
    switch (paymentMethod) {
      case null:
        return null;
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
      case 'Débito':
        return PaymentMethod.debitCard;
      case 'Crédito':
        return PaymentMethod.creditCard;
      case 'Pix':
        return PaymentMethod.pix;
      default:
        return null;
    }
  }
}

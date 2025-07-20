// Pode ser adicionado na StreamingEntity ou como método utilitário
int getDaysUntilRenewal(DateTime renewalDate) {
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final renewal = DateTime(
    renewalDate.year,
    renewalDate.month,
    renewalDate.day,
  );

  final difference = renewal.difference(todayDate).inDays;

  // Se já passou da data, calcular próxima renovação
  if (difference < 0) {
    // Assumindo renovação mensal, você pode ajustar conforme sua lógica
    final nextRenewal = DateTime(
      renewalDate.year,
      renewalDate.month + 1,
      renewalDate.day,
    );
    return nextRenewal.difference(todayDate).inDays;
  }

  return difference;
}

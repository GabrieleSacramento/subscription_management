import 'package:flutter/material.dart';

// Calcula os dias até a renovação
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

// Formata a mensagem de renovação com casos especiais
String formatRenewalDate(DateTime renewalDate) {
  final daysUntil = getDaysUntilRenewal(renewalDate);

  if (daysUntil < 0) {
    return 'Venceu há ${daysUntil.abs()} dias';
  } else if (daysUntil == 0) {
    return 'Renova hoje';
  } else if (daysUntil == 1) {
    return 'Renova amanhã';
  } else {
    return 'Renova em $daysUntil dias';
  }
}

// Retorna a cor baseada na urgência da renovação
Color getRenewalColor(DateTime renewalDate) {
  final daysUntil = getDaysUntilRenewal(renewalDate);

  if (daysUntil < 0) {
    return Colors.red; // Vencido
  } else if (daysUntil <= 3 || daysUntil <= 7) {
    return const Color.fromARGB(255, 199, 124, 10); // Urgente (3 dias ou menos)
  } else {
    return const Color.fromRGBO(77, 77, 97, 1); // Normal
  }
}

// Retorna ícone baseado na urgência
IconData getRenewalIcon(DateTime renewalDate) {
  final daysUntil = getDaysUntilRenewal(renewalDate);

  if (daysUntil < 0) {
    return Icons.error; // Vencido
  } else if (daysUntil <= 3) {
    return Icons.warning; // Urgente
  } else if (daysUntil <= 7) {
    return Icons.schedule; // Próximo
  } else {
    return Icons.check_circle_outline; // Normal
  }
}

// Enum para categorizar o status da renovação
enum RenewalStatus {
  overdue, // Vencido
  urgent, // Urgente (≤ 3 dias)
  upcoming, // Próximo (≤ 7 dias)
  normal, // Normal (> 7 dias)
}

// Retorna o status da renovação
RenewalStatus getRenewalStatus(DateTime renewalDate) {
  final daysUntil = getDaysUntilRenewal(renewalDate);

  if (daysUntil < 0) {
    return RenewalStatus.overdue;
  } else if (daysUntil <= 3) {
    return RenewalStatus.urgent;
  } else if (daysUntil <= 7) {
    return RenewalStatus.upcoming;
  } else {
    return RenewalStatus.normal;
  }
}

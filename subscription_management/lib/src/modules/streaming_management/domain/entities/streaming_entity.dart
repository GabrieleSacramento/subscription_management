import 'package:equatable/equatable.dart';
import 'package:subscription_management/src/modules/home/domain/enums/payment_method.dart';

class StreamingEntity extends Equatable {
  final String? streamingId;
  final String streamingName;
  final String? streamingImage;
  final num? streamingValue;
  final DateTime? startsAt;
  final DateTime? renewalDate;
  final PaymentMethod? paymentMethod;

  const StreamingEntity({
    this.startsAt,
    this.streamingId,
    this.paymentMethod,
    this.streamingValue,
    this.renewalDate,
    this.streamingImage,
    required this.streamingName,
  });

  @override
  List<Object?> get props => [streamingId, streamingName, streamingImage];
}

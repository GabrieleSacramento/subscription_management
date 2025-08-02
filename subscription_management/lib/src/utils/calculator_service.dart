import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';

class CalculatorService {
  static double calculateTotalSpent(List<StreamingEntity> streamings) {
    return streamings.fold(
      0.0,
      (total, streaming) => total + (streaming.streamingValue ?? 0.0),
    );
  }
}

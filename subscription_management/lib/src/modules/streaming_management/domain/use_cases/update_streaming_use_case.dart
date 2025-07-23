import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';

abstract class UpdateStreamingUseCase {
  Future<void> call(StreamingEntity streaming);
}

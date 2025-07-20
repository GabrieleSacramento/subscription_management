import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';

abstract class AddStreamingUseCase {
  Future<void> addStreaming(StreamingEntity streaming);
}

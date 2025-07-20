import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';

abstract class StreamingRepository {
  Future<void> addStreaming(StreamingEntity streaming);
  Stream<List<StreamingEntity>> getStreamings();
}

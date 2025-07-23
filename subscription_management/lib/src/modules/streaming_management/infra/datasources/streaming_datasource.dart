import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';

abstract class StreamingDataSource {
  Future<void> addStreaming(StreamingEntity streaming);
  Stream<List<StreamingEntity>> getStreaming();
  Future<void> updateStreaming(StreamingEntity streaming);
  Future<void> deleteStreaming(String streamingId);
}

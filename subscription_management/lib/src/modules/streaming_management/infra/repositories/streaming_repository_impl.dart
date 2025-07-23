import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/repositories/streaming_repository.dart';
import 'package:subscription_management/src/modules/streaming_management/infra/datasources/streaming_datasource.dart';

class StreamingRepositoryImpl implements StreamingRepository {
  final StreamingDataSource dataSource;

  StreamingRepositoryImpl({required this.dataSource});

  @override
  Future<void> addStreaming(StreamingEntity streaming) {
    return dataSource.addStreaming(streaming);
  }

  @override
  Stream<List<StreamingEntity>> getStreamings() {
    return dataSource.getStreaming();
  }

  @override
  Future<void> deleteStreaming(String streamingId) {
    return dataSource.deleteStreaming(streamingId);
  }

  @override
  Future<void> updateStreaming(StreamingEntity streaming) async {
    return await dataSource.updateStreaming(streaming);
  }
}

import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/repositories/streaming_repository.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/use_cases/add_streaming_use_case.dart';

class AddStreamingUseCaseImpl implements AddStreamingUseCase {
  final StreamingRepository repository;

  AddStreamingUseCaseImpl({required this.repository});

  @override
  Future<void> addStreaming(StreamingEntity streaming) {
    return repository.addStreaming(streaming);
  }
}

import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/repositories/streaming_repository.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/use_cases/update_streaming_use_case.dart';

class UpdateStreamingUseCaseImpl implements UpdateStreamingUseCase {
  final StreamingRepository repository;

  UpdateStreamingUseCaseImpl({required this.repository});

  @override
  Future<void> call(StreamingEntity streaming) async {
    return await repository.updateStreaming(streaming);
  }
}

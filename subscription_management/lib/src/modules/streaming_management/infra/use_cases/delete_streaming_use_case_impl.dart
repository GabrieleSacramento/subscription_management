import 'package:subscription_management/src/modules/streaming_management/domain/repositories/streaming_repository.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/use_cases/delete_streaming_use_case.dart';

class DeleteStreamingUseCaseImpl implements DeleteStreamingUseCase {
  final StreamingRepository repository;

  DeleteStreamingUseCaseImpl({required this.repository});

  @override
  Future<void> call(String streaming) async {
    return await repository.deleteStreaming(streaming);
  }
}

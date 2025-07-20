import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/repositories/streaming_repository.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/use_cases/get_streaming_use_case.dart';

class GetStreamingUseCaseImpl implements GetStreamingUseCase {
  final StreamingRepository repository;

  GetStreamingUseCaseImpl({required this.repository});

  @override
  Stream<List<StreamingEntity>> call() {
    return repository.getStreamings();
  }
}

import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';

abstract class GetStreamingUseCase {
  Stream<List<StreamingEntity>> call();
}

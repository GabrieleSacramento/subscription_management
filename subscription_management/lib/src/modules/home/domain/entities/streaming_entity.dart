import 'package:equatable/equatable.dart';

class StreamingEntity extends Equatable {
  final String streamingId;
  final String streamingName;
  final String streamingImage;

  const StreamingEntity({
    required this.streamingId,
    required this.streamingName,
    required this.streamingImage,
  });

  @override
  List<Object?> get props => [streamingId, streamingName, streamingImage];
}

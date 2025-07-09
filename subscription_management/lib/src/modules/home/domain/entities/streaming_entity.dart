import 'package:equatable/equatable.dart';

class StreamingEntity extends Equatable {
  final String? streamingId;
  final String streamingName;
  final String streamingImage;
  final num? streamingValue;
  final String? renewalDate;

  const StreamingEntity({
    this.streamingId,
    this.streamingValue,
    this.renewalDate,
    required this.streamingName,
    required this.streamingImage,
  });

  @override
  List<Object?> get props => [streamingId, streamingName, streamingImage];
}

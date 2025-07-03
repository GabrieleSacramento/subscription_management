import 'package:subscription_management/src/modules/home/domain/entities/streaming_entity.dart';

class StreamingModel {
  final String streamingId;
  final String streamingName;
  final String streamingImage;

  const StreamingModel({
    required this.streamingId,
    required this.streamingName,
    required this.streamingImage,
  });

  factory StreamingModel.fromJson(Map<String, dynamic> json) {
    return StreamingModel(
      streamingId: json['streamingId'] as String,
      streamingName: json['streamingName'] as String,
      streamingImage: json['streamingImage'] as String,
    );
  }

  StreamingEntity toEntity() {
    return StreamingEntity(
      streamingId: streamingId,
      streamingName: streamingName,
      streamingImage: streamingImage,
    );
  }
}

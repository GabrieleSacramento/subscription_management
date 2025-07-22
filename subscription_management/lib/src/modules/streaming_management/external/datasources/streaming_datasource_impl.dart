import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subscription_management/src/modules/streaming_management/data/models/streaming_model.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/infra/datasources/streaming_datasource.dart';

class StreamingDataSourceImpl implements StreamingDataSource {
  final FirebaseFirestore firestore;

  StreamingDataSourceImpl({required this.firestore});

  @override
  Future<void> addStreaming(StreamingEntity streaming) async {
    final streamingModel = StreamingModel.fromEntity(streaming);
    await firestore.collection("streaming").add(streamingModel.toJson());
  }

  @override
  Stream<List<StreamingEntity>> getStreaming() {
    return firestore.collection("streaming").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => StreamingModel.fromJson(doc.data()).toEntity())
          .toList();
    });
  }
}

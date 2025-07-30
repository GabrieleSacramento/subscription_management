import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subscription_management/src/modules/streaming_management/data/models/streaming_model.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/infra/datasources/streaming_datasource.dart';

class StreamingDataSourceImpl implements StreamingDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth = FirebaseAuth.instance;

  StreamingDataSourceImpl({required this.firestore});

  @override
  Future<void> addStreaming(StreamingEntity streaming) async {
    final userId = auth.currentUser?.uid;
    final streamingModel = StreamingModel.fromEntity(streaming);
    await firestore
        .collection("streaming")
        .doc(userId)
        .collection("list")
        .add(streamingModel.toJson());
  }

  @override
  Stream<List<StreamingEntity>> getStreaming() {
    final userId = auth.currentUser?.uid;
    return firestore
        .collection("streaming")
        .doc(userId)
        .collection("list")
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) {
                try {
                  final data = doc.data();
                  data['streamingId'] = doc.id;
                  return StreamingModel.fromJson(data).toEntity();
                } catch (e) {
                  return null;
                }
              })
              .whereType<StreamingEntity>()
              .toList();
        });
  }

  @override
  Future<void> updateStreaming(StreamingEntity streaming) async {
    final userId = auth.currentUser?.uid;
    if (streaming.streamingId == null || streaming.streamingId!.isEmpty) {
      throw Exception('ID do streaming é obrigatório para atualização');
    }

    final streamingModel = StreamingModel.fromEntity(streaming);
    final data = streamingModel.toJson();

    data['updatedAt'] = FieldValue.serverTimestamp();

    await firestore
        .collection("streaming")
        .doc(userId)
        .collection("list")
        .doc(streaming.streamingId!)
        .update(data);
  }

  @override
  Future<void> deleteStreaming(String streamingId) async {
    final userId = auth.currentUser?.uid;
    await firestore
        .collection("streaming")
        .doc(userId)
        .collection("list")
        .doc(streamingId)
        .delete();
  }
}

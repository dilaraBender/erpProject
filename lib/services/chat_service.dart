import 'package:cloud_firestore/cloud_firestore.dart';

// Mesajlaşma için WebApi ile bağlantı kurduğumuz servis
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages(int appointmentId) {
    return _firestore
        .collection('chats')
        .doc('appointment_$appointmentId')
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> sendMessage({
    required int appointmentId,
    required int senderId,
    required String message,
  }) async {
    await _firestore
        .collection('chats')
        .doc('appointment_$appointmentId')
        .collection('messages')
        .add({
          'senderId': senderId,
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }
}

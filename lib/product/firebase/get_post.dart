import 'package:cloud_firestore/cloud_firestore.dart';

// Veriler ile ilgili sınıf
class GetPost {
  final _cloud = FirebaseFirestore.instance;
//Veri Getirme
  Stream<QuerySnapshot> getUserPost() {
    var ref = _cloud.collection("Users").snapshots();
    return ref;
  }

  // Veri Kaydetme
  Future<DocumentReference<Map<String, dynamic>>> addPost(
      String noteValue, String userEmail) {
    var ref = _cloud.collection("Users").add({
      "time": DateTime.now().toString().substring(0, 16),
      "message": noteValue,
      "userName": userEmail,
      "isActive": true,
    });
    return ref;
  }
}

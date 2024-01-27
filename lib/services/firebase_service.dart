import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication/util/catdata.dart';

class FirebaseService {
  static final COLLECTION_REF = 'cat';

  final firestore = FirebaseFirestore.instance;
  late final CollectionReference catRef;

  FirebaseService() {
    catRef = firestore.collection(COLLECTION_REF);
  }

  void add(CatData catData) {
    DocumentReference documentReference = catRef.doc(catData.statement);
    documentReference.set(catData.toJson());
  }

  Stream<QuerySnapshot<Object?>> index() {
    return catRef.snapshots();
  }

  void delete(CatData catData) {
    DocumentReference documentReference = catRef.doc(catData.statement);
    documentReference.delete();
  }
}

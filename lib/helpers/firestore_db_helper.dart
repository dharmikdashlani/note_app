import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBHelper {
  FirestoreDBHelper._();

  static final FirestoreDBHelper firestoreDBHelper = FirestoreDBHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  insertNotes({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> counter =
        await db.collection("counter").doc("notes_counter").get();

    int id = counter['id'];
    int length = counter['length'];

    await db.collection("notes").doc("${++id}").set(data);

    await db.collection("counter").doc("notes_counter").update({"id": id});

    await db
        .collection("counter")
        .doc("notes_counter")
        .update({"length": ++length});
  }

  deleteNotes({required String id}) async {
    await db.collection("notes").doc(id).delete();

    DocumentSnapshot<Map<String, dynamic>> counter =
        await db.collection("counter").doc("notes_counter").get();

    int length = counter['length'];

    await db
        .collection("counter")
        .doc("notes_counter")
        .update({"length": --length});
  }

  // updateNotes(
  //     {required String id,
  //     required String title,
  //     required String description}) async {
  //   await db.collection("notes").doc(id).update({"title":title,"description":description});
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/questionModel.dart';

class CloudFirestoreService {
  final FirebaseFirestore db;

  const CloudFirestoreService(this.db);

  void addProductToFirebase(List<QuestionsModel> questionsModel) async {
    // DocumentReference? docRef;
    // CollectionReference questions =
    //     FirebaseFirestore.instance.collection("interview");
    for (int i = 0; i < questionsModel.length; i++) {
      // FirebaseFirestore.instance
      //     .collection("Base")
      //     .add(questionsModel[i].toMap());

      FirebaseFirestore.instance
          .collection("interViewQuestions")
          .doc()
          .set(questionsModel[i].toMap())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      // questions.doc("interview").set(questionsModel.toList()[i].toMap());
      // docRef = await questions.add(questionsModel.toList()[i].toMap());

      // await docRef.update({'id': docRef.id});
    }
    //   for(var i in value.docs) {
    //     // data.add(i.data());
    //        docRef = await questions.add(questionsModel.toList()[i].toMap());
    //         await docRef!.update({'id': docRef!.id});
    //   }
    // });

    // DocumentReference? docRef;
    // CollectionReference questions =
    //     FirebaseFirestore.instance.collection('interView');
    // for (int i = 0; i < questionsModel.length; i++) {
    //   // for (var inter in questionsModel) {
    //   docRef = await questions.add(questionsModel.toList()[i].toMap());
    //   // inter.toMap()
    //   await docRef.update({'id': docRef.id});
    //   // }
    // }
  }

  // Future delete() async {
  //   // final document =
  //   await db.collection('questions').withConverter(
  //       fromFirestore: Questions.fromFirestore,
  //       toFirestore: (Questions ques, _) => ques.toFirestore().remove(key));
  //   // document.update(document);
  // }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getQuestions() {
  //   return db.collection('questions').snapshots();
  // }

  // Stream<QuerySnapshot<QuestionsFirebase>> getQuestions() {
  //   final reference = db.collection('allQuestions').withConverter(
  //         fromFirestore: QuestionsFirebase.fromFirestore,
  //         toFirestore: (QuestionsFirebase ques, _) => ques.toFirestore(),
  //       );

  //   return reference.snapshots();
  // }
}

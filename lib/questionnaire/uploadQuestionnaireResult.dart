import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuestionNairService {
  Future<void> uploadQuestionnairResult({required int totalScore}) async {
    try {
      final _user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.email)
          .update({"Score": totalScore});
      print('success');
    } catch (err) {
      print(err.toString());
    }
  }
}

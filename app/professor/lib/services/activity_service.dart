import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  final activitites = FirebaseFirestore.instance.collection('atividades');

  Stream<QuerySnapshot<Map<String, dynamic>>> getActivities(String turmaId) {
    return activitites.where('turmaId', isEqualTo: turmaId).snapshots();
  }

  Future<void> addActivity({
    required String descricao,
    required String turmaId,
  }) {
    Map<String, dynamic> data = {
      'descricao': descricao,
      'turmaId': turmaId,
      'timeStamp': Timestamp.now(),
    };
    return activitites.add(data);
  }

  Future<void> updateActivity({
    required String descricao,
    required String id,
  }) {
    return activitites.doc(id).update({'descricao': descricao});
  }

  Future<void> removeActivity(String id) {
    return activitites.doc(id).delete(); 
  }
}

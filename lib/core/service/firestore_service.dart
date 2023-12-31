import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/personal_data.dart';

abstract class FireStoreService {
  Future<List<PersonalDataForm>> getMembersCollection();
  Future<PersonalDataForm> getCurrentUser(String userId);
  Future<void> uploadMemberInformation(Map<String, dynamic> jsonData, uid);
  Future<void> saveDataAsJson(List<Map<String, String>> list);
  Future<bool> checkUserIsCreated(String userId);
  Future<void> extractAndDownloadData(
      QuerySnapshot<Map<String, dynamic>> response,
      Map<String, List<String>> dataJson);
}

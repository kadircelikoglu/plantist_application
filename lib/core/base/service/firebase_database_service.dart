import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:plantist_case/core/base/models/todo_model.dart';

final class FirebaseDataBaseService {
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('todos');
 
  final DateTime now = DateTime.now();

  Future<String?> uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('files/${now.millisecondsSinceEpoch}.jpg}');
      await imageRef.putFile(imageFile);
      final downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  Future<DocumentReference> createTodo({
    required Todo todoModel,
    File? imageFile,
  }) async {
    String? imageUrl;

    if (imageFile != null) {
      imageUrl = await uploadImage(imageFile);
      log('Image is not null: $imageUrl');
    }

    final newTodoRef = await todoCollection.add({
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'title': todoModel.title,
      'note': todoModel.note,
      'priority': todoModel.priority,
      'timeStamp': todoModel.timeStamp,
      'category': todoModel.category,
      'tags': todoModel.tags,
      'imageUrl': imageUrl,
    });

    return newTodoRef;
  }

  Future<void> updateTodo(String id, Todo todoModel, File? imageFile) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await uploadImage(imageFile);
    }
    return todoCollection.doc(id).update({
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'title': todoModel.title,
      'note': todoModel.note,
      'priority': todoModel.priority,
      'timeStamp': todoModel.timeStamp,
      'category': todoModel.category,
      'tags': todoModel.tags,
      if (imageUrl != null) 'imageUrl': imageUrl,
    });
  }

  Future<void> deleteTodo(String id) async {
    return todoCollection.doc(id).delete();
  }

  Future<Map<String, List<QueryDocumentSnapshot>>> fetchTodos() async {
    final querySnapshot = await todoCollection
        .where(
          'timeStamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(
            DateTime(now.year, now.month, now.day),
          ),
        )
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy('timeStamp', descending: false)
        .orderBy('priority', descending: true)
        .get();

    final groupedData = <String, List<QueryDocumentSnapshot>>{};

    for (final doc in querySnapshot.docs) {
      final timeStamp = (doc['timeStamp'] as Timestamp).toDate();
      final formattedDate = '${timeStamp.year}-${timeStamp.month}-${timeStamp.day}';
      if (!groupedData.containsKey(formattedDate)) {
        groupedData[formattedDate] = [];
      }
      groupedData[formattedDate]!.add(doc);
    }

    groupedData.forEach((date, documents) {
      documents.sort(
        (a, b) => (b['priority'] as int).compareTo(a['priority'] as int),
      );
    });
    return groupedData;
  }
}

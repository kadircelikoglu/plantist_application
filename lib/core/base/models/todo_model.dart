import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
final class Todo {
  const Todo({
    required this.priority,
    required this.timeStamp,
    this.title,
    this.note,
    this.category,
    this.tags,
  });

  final String? title;
  final String? note;
  final String? category;
  final String? tags;
  final int priority;
  final Timestamp timeStamp;
}

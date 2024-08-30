import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantist_case/core/base/models/todo_model.dart';
import 'package:plantist_case/core/base/service/firebase_database_service.dart';
import 'package:plantist_case/core/base/service/image_service.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/features/home/view/home_view.dart';

final class ReminderController extends GetxController {
  // MARK: - Controllers
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final tagsController = TextEditingController();

  // MARK: - Services
  final FirebaseDataBaseService _firebaseDataBaseService = FirebaseDataBaseService();
  final ImagePicker _picker = ImagePicker();

  // MARK: - Reactive State Variables
  final Rx<DateTime?> _selectedDate = Rx<DateTime?>(null);
  final Rx<Duration?> _selectedTime = Rx<Duration?>(null);
  RxInt selectedPriority = 1.obs;
  RxString selectedCategory = 'None'.obs;
  final isLoading = false.obs;
  Rx<File?> selectedImageFile = Rx<File?>(null);
  RxBool isDateSwitchOn = false.obs;
  RxBool isTimeSwitchOn = false.obs;

  // MARK: - Data
  final Map<String, int> priorityMap = {
    'None': 1,
    'Low': 2,
    'Medium': 3,
    'High': 4,
  };

  final List<String> categories = [
    'Technology',
    'Health',
    'Sport',
    'News',
    'Cars',
    'Space',
    'Magazine',
  ];

  // MARK: - Getters and Setters
  DateTime? get selectedDate => _selectedDate.value;

  set selectedDate(DateTime? date) => _selectedDate.value = date;

  Duration? get selectedTime => _selectedTime.value;

  set selectedTime(Duration? time) => _selectedTime.value = time;

  // MARK: - Priority and Category Management
  void updateSelectedPriority(String priority) {
    if (priorityMap.containsKey(priority)) {
      selectedPriority.value = priorityMap[priority]!;
    }
  }

  void updateSelectedCategory(String category) {
    if (categories.contains(category)) {
      selectedCategory.value = category;
    }
  }

  String get selectedPriorityKey {
    return priorityMap.keys.firstWhere(
      (key) => priorityMap[key] == selectedPriority.value,
      orElse: () => 'None',
    );
  }

  // MARK: - DateTime Management for Timestamp convert
  Timestamp? get combinedTimestamp {
    if (_selectedDate.value != null && _selectedTime.value != null) {
      final date = _selectedDate.value!;
      final time = _selectedTime.value!;
      final combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.inHours,
        time.inMinutes % 60,
      );
      return Timestamp.fromDate(combinedDateTime);
    }
    return null;
  }

  // MARK: - Create 'todo' function
  Future<void> createTodoFunction({required BuildContext context, required Todo todoModel}) async {
    try {
      isLoading.value = true;
      await _createTodoInDatabase(todoModel);
      _handleSuccess('Todo was created successfully');
    } catch (e) {
      _handleError(e, 'An error occurred while creating Todo');
    } finally {
      isLoading.value = false;
    }
  }

  // MARK: - Update 'Todo' method
  Future<void> updateTodoFunction({required BuildContext context, required String id, required Todo todoModel}) async {
    try {
      isLoading.value = true;
      await _updateTodoInDatabase(id, todoModel);
      _handleSuccess('Todo was updated successfully');
    } catch (e) {
      _handleError(e, 'An error occurred while updating Todo');
    } finally {
      isLoading.value = false;
    }
  }

  // MARK: - Pick Image from Gallery method
  Future<void> pickImageFromGallery() async {
    final hasPermission = await ImagePickerService().checkCameraPermission();
    if (!hasPermission) {
      if (kDebugMode) {
        print('Camera permission denied.');
      }
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImageFile.value = File(pickedFile.path);
      log(selectedImageFile.value!.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  // MARK: - Create `todo` service
  Future<void> _createTodoInDatabase(Todo todoModel) async {
    await _firebaseDataBaseService.createTodo(
      todoModel: todoModel,
      imageFile: selectedImageFile.value,
    );
    log('Create todo: ${selectedImageFile.value}');
  }

  Future<void> _updateTodoInDatabase(String id, Todo todoModel) async {
    await _firebaseDataBaseService.updateTodo(id, todoModel, selectedImageFile.value);
    log('Update todo: ${selectedImageFile.value}');
  }

  void _handleSuccess(String message) {
    Get.back<void>(closeOverlays: true);
    Get
      ..offAll(() => const HomeView())
      ..snackbar('Success', message, backgroundColor: Colors.green);
  }

  void _handleError(Object error, String errorMessage) {
    log('Exception occurred: $error');
    Get.snackbar('Error', errorMessage, backgroundColor: ColorConstants().red400);
  }
}

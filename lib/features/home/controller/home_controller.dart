import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist_case/core/base/service/firebase_database_service.dart';
import 'package:plantist_case/core/init/notification/local_notifications.dart';
import 'package:plantist_case/features/auth/landing/view/landing_view.dart';

final class HomeController extends GetxController {
  final FirebaseDataBaseService _databaseService = FirebaseDataBaseService();
  final now = DateTime.now();
  final groupedTodos = <String, List<QueryDocumentSnapshot>>{}.obs;
  final upcomingTodos = <QueryDocumentSnapshot>[].obs;
  final isLoading = false.obs;

  final today = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  final tomorrow = '${DateTime.now().add(const Duration(days: 1)).year}-${DateTime.now().add(const Duration(days: 1)).month}-${DateTime.now().add(const Duration(days: 1)).day}';

  RxBool isSearchVisible = false.obs;
  final searchController = TextEditingController();

  RxList<QueryDocumentSnapshot> filteredTodos = <QueryDocumentSnapshot>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchTodos();
    ever(groupedTodos, (_) {
      _updateFilteredTodos();
      scheduleTodoNotification();
    });
    ever(upcomingTodos, (_) => _updateFilteredTodos());
    searchController.addListener(() {
      filterTodos(searchController.text);
    });
  }

//MARK: Helper function that allows us to add a newly added data to the list
  void setGroupedTodos(Map<String, List<QueryDocumentSnapshot>> newData) {
    if (newData.isNotEmpty) {
      groupedTodos.value = newData;
      updateUpcomingTodos();
    }
  }

  //MARK: Function that retrieves todos created in the system
  Future<void> fetchTodos() async {
    isLoading.value = true;
    try {
      final groupedData = await _databaseService.fetchTodos();
      setGroupedTodos(groupedData);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching todos: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // MARK: Delete `todo` function
  Future<void> deleteTodo(BuildContext context, {required String todoId}) async {
    try {
      await _databaseService.deleteTodo(todoId);
      Get.back<void>(closeOverlays: true);
      await fetchTodos();
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while deleting the Todo',
        backgroundColor: Colors.red,
      );
    }
  }

// MARK: Fetch `upcoming` todos function
  void updateUpcomingTodos() {
    final todayTodos = groupedTodos[today] ?? [];
    final tomorrowTodos = groupedTodos[tomorrow] ?? [];
    upcomingTodos.value = groupedTodos.values.expand((todos) => todos).where((todo) => !todayTodos.contains(todo) && !tomorrowTodos.contains(todo)).toList();
  }

// MARK: The method that allows us to log out
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    groupedTodos.clear();
    upcomingTodos.clear();
    Get.off(const LandingView());
  }

  // MARK: Function that allows us to search for todos with filtering
  void filterTodos(String query) {
    if (query.isEmpty) {
      _updateFilteredTodos();
    } else {
      filteredTodos.value = groupedTodos.values.expand((todos) => todos).where((todo) {
        final data = todo.data()! as Map<String, dynamic>;
        final title = data['title'] as String? ?? '';
        final note = data['note'] as String? ?? '';
        return title.toLowerCase().contains(query.toLowerCase()) ||
            note.toLowerCase().contains(
                  query.toLowerCase(),
                );
      }).toList();
    }
  }

  //MARK: Function to make textfield visible and close it again for filtering
  void toggleSearchVisibility() {
    isSearchVisible.value = !isSearchVisible.value;
  }

//MARK: Function to make textfield visible and close it again for filtering
  void _updateFilteredTodos() {
    final allTodos = groupedTodos.values.expand((todos) => todos).toList();
    if (searchController.text.isEmpty) {
      filteredTodos.value = allTodos;
    } else {
      filterTodos(searchController.text);
    }
  }

  //MARK: Helper function that updates the filtered list
  void scheduleTodoNotification() {
    final todayTodos = groupedTodos[today] ?? [];
    todayTodos.sort((a, b) {
      final aTime = (a.data()! as Map<String, dynamic>)['timeStamp'] as Timestamp;
      final bTime = (b.data()! as Map<String, dynamic>)['timeStamp'] as Timestamp;
      return aTime.toDate().compareTo(bTime.toDate());
    });

    final now = DateTime.now();
    final nextTodo = todayTodos.firstWhereOrNull((todo) {
      final timeStamp = (todo.data()! as Map<String, dynamic>)['timeStamp'] as Timestamp;
      return timeStamp.toDate().isAfter(now);
    });

    if (nextTodo != null) {
      final nextTodoData = nextTodo.data()! as Map<String, dynamic>;
      final timeStamp = nextTodoData['timeStamp'] as Timestamp;
      var notificationTime = timeStamp.toDate().subtract(const Duration(minutes: 1));
      if (notificationTime.isBefore(now)) {
        notificationTime = now.add(const Duration(seconds: 5));
      }
      LocalNotifications.showScheduleNotification(
        title: 'Upcoming Todo',
        body: 'You have an upcoming task: ${nextTodoData['title']}',
        payload: 'todo_${nextTodoData['id']}',
        scheduledTime: notificationTime,
      );
      LocalNotifications.onClickNotification.stream.listen((event) {
        scheduleTodoNotification();
      });
    } else {
      LocalNotifications.cancelAllNotifications();
    }
  }
}

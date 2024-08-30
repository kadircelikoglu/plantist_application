import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/button/app_primary_button.dart';
import 'package:plantist_case/core/components/popups/create_reminder_sheet.dart';
import 'package:plantist_case/core/components/scaffold/custom_scaffold.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/global_extension.dart';
import 'package:plantist_case/features/home/controller/home_controller.dart';
import 'package:plantist_case/features/home/widgets/home_header.dart';
import 'package:plantist_case/features/home/widgets/section_widget.dart';
import 'package:plantist_case/features/home/widgets/todo_item.dart';

final class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return CustomScaffold(
      onPressed: homeController.logout,
      body: Obx(
        () {
          if (homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          final hasFilteredTodos = homeController.filteredTodos.isNotEmpty;
          final showFilteredTodos = homeController.isSearchVisible.value && hasFilteredTodos;
          return SafeArea(
            child: Column(
              children: [
                HomeHeader(homeController: homeController),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: context.padding.horizontalMedium * .5 + context.padding.onlyTopNormal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showFilteredTodos) const SectionWidget(title: 'Filtered TODOs') else if (!showFilteredTodos) const SectionWidget(title: 'Today'),
                          if (showFilteredTodos)
                            _buildTodoList(
                              homeController.filteredTodos,
                              context,
                              homeController,
                              noDataMessage: 'No TODOs found for the search query.',
                            )
                          else ...[
                            _buildTodoList(
                              homeController.groupedTodos[homeController.today]?.toList() ?? [],
                              context,
                              homeController,
                            ),
                            const SectionWidget(title: 'Tomorrow'),
                            _buildTodoList(
                              homeController.groupedTodos[homeController.tomorrow]?.toList() ?? [],
                              context,
                              homeController,
                              noDataMessage: 'No TODOs for tomorrow.',
                            ),
                            const SectionWidget(title: 'Others'),
                            _buildTodoList(
                              homeController.groupedTodos.values
                                  .expand((todos) => todos)
                                  .where(
                                    (todo) => !((homeController.groupedTodos[homeController.today] ?? []).contains(todo) ||
                                        (homeController.groupedTodos[homeController.tomorrow] ?? []).contains(todo)),
                                  )
                                  .toList(),
                              context,
                              homeController,
                              noDataMessage: 'No upcoming TODOs.',
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                _buildNewReminderButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodoList(
    List<QueryDocumentSnapshot> todos,
    BuildContext context,
    HomeController homeController, {
    String noDataMessage = "No TODO's available.",
  }) {
    if (todos.isEmpty) {
      return Center(child: Text(noDataMessage));
    }
    return ListView.builder(
      itemCount: todos.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildTodoItem(todos[index], context, homeController);
      },
    );
  }

  Widget _buildTodoItem(
    QueryDocumentSnapshot doc,
    BuildContext context,
    HomeController homeController,
  ) {
    final priority = doc['priority'] as int;
    final timeStamp = doc['timeStamp'] as Timestamp;
    final priorityLevel = getPriorityLevel(priority);
    final dateTime = timeStamp.toDate();
    final dateFormatter = DateFormat('dd.MM.yyyy');
    final timeFormatter = DateFormat('HH:mm');

    return TodoItem(
      priorityLevel: priorityLevel,
      doc: doc,
      dateFormatter: dateFormatter,
      timeFormatter: timeFormatter,
      dateTime: dateTime,
      homeController: homeController,
    );
  }

  Widget _buildNewReminderButton(BuildContext context) {
    return Padding(
      padding: context.padding.verticalLow,
      child: AppPrimaryButton(
        onTap: () => createReminderSheet(context),
        text: 'New Reminder',
        icon: IconEnums.plus,
        buttonColor: ColorConstants().black,
        textColor: ColorConstants().white,
        fontSize: 17,
      ),
    );
  }
}

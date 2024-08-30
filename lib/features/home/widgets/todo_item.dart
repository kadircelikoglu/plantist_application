import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/popups/app_popups.dart';
import 'package:plantist_case/core/components/popups/create_reminder_sheet.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/global_extension.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';
import 'package:plantist_case/features/home/controller/home_controller.dart';

final class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.priorityLevel,
    required this.doc,
    required this.dateFormatter,
    required this.timeFormatter,
    required this.dateTime,
    required this.homeController,
    super.key,
  });
  final PriorityLevel priorityLevel;
  final QueryDocumentSnapshot doc;
  final DateFormat dateFormatter;
  final DateFormat timeFormatter;
  final DateTime dateTime;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          key: ValueKey(doc.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await AppPopups.deleteTodoPopup(context, homeController, doc.id);
                },
                backgroundColor: ColorConstants().red400,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (_) {
                  createReminderSheet(
                    context,
                    id: doc.id,
                    title: doc['title'] as String,
                    note: doc['note'] as String,
                    tags: doc['tags'] as String,
                    dateTime: dateTime,
                    selectedCategory: doc['category'] as String,
                    selectedPriority: doc['priority'] as int,
                    path: doc['imageUrl'] != null ? doc['imageUrl'] as String : null,
                    isEditReminder: true,
                  );
                },
                backgroundColor: ColorConstants().gray400,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          child: Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(priorityLevel.svgPath),
                  15.w.pw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.sized.width / 1.75,
                        child: CustomText(
                          doc['title'].toString(),
                          fontSize: 18,
                        ),
                      ),
                      CustomText(
                        doc['category'].toString(),
                        fontSize: 16,
                        textColor: ColorConstants().gray200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(IconEnums.miniCalender.svgPath),
                          3.w.pw,
                          CustomText(
                            dateFormatter.format(dateTime),
                            textColor: ColorConstants().gray400,
                          ),
                          10.w.pw,
                          SvgPicture.asset(IconEnums.miniClock.svgPath),
                          3.w.pw,
                          CustomText(
                            timeFormatter.format(dateTime),
                            textColor: ColorConstants().gray400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (doc['imageUrl'] != null)
                    Row(
                      children: [
                        SvgPicture.asset(IconEnums.attach.svgPath),
                        CustomText(
                          '1 Attach',
                          textColor: ColorConstants().gray200,
                          fontSize: 16,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: context.padding.verticalLow * .5,
          child: Divider(indent: 45.w),
        ),
      ],
    );
  }
}

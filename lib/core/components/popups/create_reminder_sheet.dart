import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/components/popups/controller/reminder_controller.dart';
import 'package:plantist_case/core/components/popups/main/main_sheet.dart';
import 'package:plantist_case/core/components/popups/picker_reminder_sheet.dart';
import 'package:plantist_case/core/components/popups/widgets/custom_option_widget.dart';
import 'package:plantist_case/core/components/popups/widgets/reminder_top_widget.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/components/textField/custom_text_field.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';

Future<void> createReminderSheet(
  BuildContext context, {
  bool isEditReminder = false,
  String? id,
  String? title,
  String? note,
  String? tags,
  DateTime? dateTime,
  String? selectedCategory,
  int? selectedPriority,
  String? path,
}) {
  log(path.toString());
  final reminderController = Get.put<ReminderController>(ReminderController());
  if (isEditReminder) {
    reminderController.titleController.text = title.toString();
    reminderController.noteController.text = note.toString();
    reminderController.tagsController.text = tags.toString();
    reminderController.selectedPriority.value = selectedPriority ?? 1;
    reminderController.selectedCategory.value = selectedCategory ?? '';
    reminderController
      ..selectedDate = DateTime(dateTime!.year, dateTime.month, dateTime.day)
      ..selectedTime = Duration(hours: dateTime.hour, minutes: dateTime.minute);
    if (path != null) {
      reminderController.selectedImageFile.value = File(path);
    }
  }
  return MainBottomSheet().mainSheet(
    context,
    child: Obx(
      () {
        return Padding(
          padding: context.padding.normal,
          child: Column(
            children: [
              ReminderTopWidget(
                title: 'New Reminder',
                onPressed: () {},
                isCreateReminder: false,
              ),
              Padding(
                padding: context.padding.onlyBottomNormal,
                child: CustomTextField(
                  hintText: 'Title',
                  textEditingController: reminderController.titleController,
                ),
              ),
              Padding(
                padding: context.padding.onlyBottomLow,
                child: CustomTextField(
                  hintText: 'Tags',
                  textEditingController: reminderController.tagsController,
                ),
              ),
              CustomTextField(
                hintText: 'Notes',
                enabledBorderColor: ColorConstants().white,
                focusedEnabledColor: ColorConstants().white,
                textEditingController: reminderController.noteController,
                maxLines: 3,
              ),
              CustomOptionWidget(
                onTap: () async {
                  if (reminderController.titleController.text.isNotEmpty && reminderController.noteController.text.isNotEmpty) {
                    await pickerReminderSheet(
                      context,
                      reminderController.tagsController.text,
                      title: reminderController.titleController.text,
                      note: reminderController.noteController.text,
                      isEditReminder: isEditReminder,
                      dateTime: dateTime,
                      selectedCategory: selectedCategory.toString(),
                      selectedPriority: selectedPriority,
                      id: id,
                    );
                  } else {
                    Get.snackbar('Eksik bilgi', 'Lütfen eksik alanları doldurunuz', backgroundColor: ColorConstants().blue400);
                  }
                },
                child: Padding(
                  padding: context.padding.horizontalLow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            'Details',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          CustomText(
                            reminderController.selectedDate != null
                                ? '${reminderController.selectedDate?.day}.${reminderController.selectedDate?.month}.${reminderController.selectedDate?.year}'
                                : '',
                            fontWeight: FontWeight.w600,
                            textColor: ColorConstants().gray100,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      SvgPicture.asset(IconEnums.arrowRight.svgPath),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:plantist_case/core/base/models/todo_model.dart';
import 'package:plantist_case/core/components/dropdown/custom_dropdown.dart';
import 'package:plantist_case/core/components/popups/controller/reminder_controller.dart';
import 'package:plantist_case/core/components/popups/main/main_sheet.dart';
import 'package:plantist_case/core/components/popups/widgets/custom_option_widget.dart';
import 'package:plantist_case/core/components/popups/widgets/reminder_top_widget.dart';
import 'package:plantist_case/core/components/text/custom_text.dart';
import 'package:plantist_case/core/constants/app/color_constants.dart';
import 'package:plantist_case/core/constants/enums/icon_enums.dart';
import 'package:plantist_case/core/helpers/extensions/num_extension.dart';

Future<void> pickerReminderSheet(
  BuildContext context,
  String tags, {
  required String title,
  required String note,
  required bool isEditReminder,
  String? id,
  DateTime? dateTime,
  String? selectedCategory,
  int? selectedPriority,
}) {
  final controller = Get.put<ReminderController>(ReminderController());

  return MainBottomSheet().mainSheet(
    context,
    child: Obx(
      () {
        return Padding(
          padding: context.padding.normal,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (controller.isLoading.value)
                  const CircularProgressIndicator.adaptive()
                else
                  ReminderTopWidget(
                    title: 'Details',
                    onPressed: () async {
                      if (controller.combinedTimestamp != null) {
                        isEditReminder == false
                            ? await controller.createTodoFunction(
                                context: context,
                                todoModel: Todo(
                                  priority: controller.selectedPriority.value,
                                  timeStamp: controller.combinedTimestamp!,
                                  note: note,
                                  title: title,
                                  category: controller.selectedCategory.value,
                                  tags: tags,
                                ),
                              )
                            : await controller.updateTodoFunction(
                                context: context,
                                todoModel: Todo(
                                  priority: controller.selectedPriority.value,
                                  timeStamp: controller.combinedTimestamp!,
                                  note: note,
                                  title: title,
                                  category: controller.selectedCategory.value,
                                  tags: tags,
                                ),
                                id: id.toString(),
                              );
                        log(controller.selectedImageFile.value!.path);
                      } else {
                        Get.snackbar('Eksik bilgi', 'Lütfen tarih ve saat alanlarını doldurunuz');
                      }
                    },
                    buttonText: isEditReminder ? 'Update' : 'Add',
                  ),
                Padding(
                  padding: context.padding.horizontalNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(IconEnums.calender.svgPath),
                              5.w.pw,
                              const CustomText(
                                'Date',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CupertinoSwitch(
                                value: controller.isDateSwitchOn.value,
                                onChanged: (val) {
                                  controller.isDateSwitchOn.toggle();
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (controller.isDateSwitchOn.value)
                        SizedBox(
                          height: context.sized.height / 2.5,
                          width: context.sized.width,
                          child: CalendarDatePicker(
                            initialDate: controller.selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            onDateChanged: (val) {
                              controller.selectedDate = val;
                              log(controller.selectedDate.toString());
                            },
                          ),
                        ),
                      Padding(
                        padding: context.padding.verticalLow * .5,
                        child: Divider(
                          color: ColorConstants().gray200,
                          indent: 50.w,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    IconEnums.clock.svgPath,
                                    height: 48.h,
                                  ),
                                  5.w.pw,
                                  const CustomText(
                                    'Time',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                              CupertinoSwitch(
                                value: controller.isTimeSwitchOn.value,
                                onChanged: (val) {
                                  controller.isTimeSwitchOn.toggle();
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          if (controller.isTimeSwitchOn.value)
                            CupertinoTimerPicker(
                              onTimerDurationChanged: (val) {
                                controller.selectedTime = val;
                                log(controller.selectedTime.toString());
                              },
                              initialTimerDuration: controller.selectedTime ?? Duration.zero,
                              mode: CupertinoTimerPickerMode.hm,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: context.padding.onlyTopNormal,
                  child: CustomDropdown(
                    items: controller.priorityMap.keys.toList(),
                    selectedItem: controller.selectedPriorityKey,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateSelectedPriority(value);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: context.padding.onlyTopLow * 1.5,
                  child: CustomDropdown(
                    items: controller.categories,
                    title: 'Category',
                    selectedItem: controller.selectedCategory.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateSelectedCategory(value);
                      }
                    },
                  ),
                ),
                CustomOptionWidget(
                  onTap: controller.pickImageFromGallery,
                  padding: context.padding.onlyTopLow * 1.5,
                  child: Padding(
                    padding: context.padding.horizontalNormal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          'Attach a file',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        Row(
                          children: [
                            CustomText(
                              controller.selectedImageFile.value?.path.substring(0, 15) ?? 'None',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              textColor: ColorConstants().gray400,
                            ),
                            10.w.pw,
                            SvgPicture.asset(
                              IconEnums.attach.svgPath,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

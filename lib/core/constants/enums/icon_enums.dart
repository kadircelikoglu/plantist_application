import 'package:plantist_case/core/helpers/extensions/string_extension.dart';

enum IconEnums {
  arrowLeft('arrow_left'),
  arrowRight('arrow_right'),
  attach('attach'),
  bluePoint('blue_point'),
  calender('calender'),
  clock('clock'),
  closeEye('close_eye'),
  done('done'),
  grayPoint('gray_point'),
  message('message'),
  miniCalender('mini_calender'),
  miniClock('mini_clock'),
  landing('landing'),
  openEye('open_eye'),
  orangePoint('orange_point'),
  plus('plus'),
  redPoint('red_point'),
  search('search'),

  youtube('youtube');

  const IconEnums(this.iconName);

  final String iconName;
  String get svgPath => iconName.toSvg;
}

import 'package:plantist_case/core/constants/enums/icon_enums.dart';

enum PriorityLevel { high, mediumHigh, medium, low }

extension PriorityLevelExtension on PriorityLevel {
  String get svgPath {
    switch (this) {
      case PriorityLevel.high:
        return IconEnums.redPoint.svgPath;
      case PriorityLevel.mediumHigh:
        return IconEnums.orangePoint.svgPath;
      case PriorityLevel.medium:
        return IconEnums.bluePoint.svgPath;
      case PriorityLevel.low:
        return IconEnums.grayPoint.svgPath;
    }
  }
}

PriorityLevel getPriorityLevel(int priority) {
  switch (priority) {
    case 4:
      return PriorityLevel.high;
    case 3:
      return PriorityLevel.mediumHigh;
    case 2:
      return PriorityLevel.medium;
    default:
      return PriorityLevel.low;
  }
}

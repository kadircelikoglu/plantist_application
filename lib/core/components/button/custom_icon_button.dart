import 'package:flutter/material.dart';

final class CustomIconButton extends IconButton {
  const CustomIconButton({
    required super.onPressed,
    required super.icon,
    super.padding = EdgeInsets.zero,
    super.key,
  });
}

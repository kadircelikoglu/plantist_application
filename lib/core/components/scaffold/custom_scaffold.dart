import 'package:flutter/material.dart';
import 'package:plantist_case/core/helpers/typedefs/typedefs.dart';

@immutable
final class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    required this.body,
    super.key,
    this.onItemTapped,
    this.scaffoldKey,
    this.currentIndex,
    this.backgroundColor = Colors.white,
    this.isFab = false,
    this.onPressed,
  });

  final Color? backgroundColor;
  final Widget body;
  final OnItemTapped onItemTapped;
  final int? currentIndex;
  final GlobalKey? scaffoldKey;
  final bool isFab;
  final OnFunction? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        body: body,
      ),
    );
  }
}

import 'package:plantist_case/core/components/scaffold/custom_scaffold.dart';

/// [AppTextField]
typedef OnChangedFunction = String Function(String)?;
typedef ValidatorFunction = String? Function(String?)?;

/// [CustomScaffold]
typedef OnItemTapped = void Function(int)?;

typedef OnWillPop = Future<bool> Function()?;

typedef OnFunction = void Function();

typedef OnChanged = void Function(String);

typedef OnDropdownChanged = void Function(String?)?;

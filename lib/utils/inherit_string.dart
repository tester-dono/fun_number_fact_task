import 'package:flutter/widgets.dart';

class InheritString extends InheritedWidget {
  const InheritString({
    Key? key,
    required this.string,
    required Widget child,
  }) : super(key: key, child: child);

  final String string;

  static InheritString of(BuildContext context) {
    final InheritString? result = context.dependOnInheritedWidgetOfExactType<InheritString>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritString oldWidget) => string != oldWidget.string;
}
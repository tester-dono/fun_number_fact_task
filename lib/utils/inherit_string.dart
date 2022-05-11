import 'package:flutter/widgets.dart';

class StateWidget extends StatefulWidget {
  final Widget child;

  const StateWidget({
    required final this.child,
  });

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  CoreState state = CoreState(klass: VeryDifficultClass(counter: 0));

  void incrementCounter() {
    final klass = state.klass;
    klass.counter++;
    final newState = state.copy(klass: klass);

    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) => StateInheritedWidget(
        child: widget.child,
        state: state,
        stateWidget: this,
      );
}

class StateInheritedWidget extends InheritedWidget {
  final CoreState state;
  final _StateWidgetState stateWidget;

  const StateInheritedWidget({
    required Widget child,
    required this.state,
    required this.stateWidget,
  }) : super(child: child,);

  static _StateWidgetState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<StateInheritedWidget>()!
      .stateWidget;

  @override
  bool updateShouldNotify(StateInheritedWidget oldWidget) =>
      oldWidget.state != state;
}

class CoreState {
  final VeryDifficultClass klass;

  CoreState({
    required this.klass,
  });

  CoreState copy({
    required VeryDifficultClass klass,
  }) =>
      CoreState(
        klass: klass,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoreState &&
          runtimeType == other.runtimeType &&
          klass.counter == other.klass.counter;

  @override
  int get hashCode => klass.counter.hashCode;
}

class VeryDifficultClass {
  int counter;

  VeryDifficultClass({required this.counter});
}

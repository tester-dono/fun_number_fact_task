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

class StateWidget extends StatefulWidget {
  final Widget child;

  const StateWidget({
    required this.child,
  }) ;

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  CoreState state = CoreState();

  void incrementCounter() {
    final counter = state.counter + 1;
    final newState = state.copy(counter: counter);

    setState(() => state = newState);
  }

  void setCounter(int counter) {
    final newState = state.copy(counter: counter);

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

  StateInheritedWidget({
    required Widget child,
    required this.state,
    required this.stateWidget,
  }) : super(child: child);

  static _StateWidgetState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<StateInheritedWidget>()
      !.stateWidget;

  @override
  bool updateShouldNotify(StateInheritedWidget oldWidget) =>
      oldWidget.state != state;
}


class CoreState {
  final int counter;

  const CoreState({
    this.counter = 0,
  });

  CoreState copy({
    required int counter,
  }) =>
      CoreState(
        counter: counter,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CoreState &&
              runtimeType == other.runtimeType &&
              counter == other.counter ;

  @override
  int get hashCode => counter.hashCode;
}
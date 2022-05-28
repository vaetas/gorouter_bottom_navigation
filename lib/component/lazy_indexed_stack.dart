import 'package:flutter/material.dart';

/// [LazyIndexedStack] build [children] on demand. Children that are already
/// built but are not visible have disabled animations and are wrapped inside
/// [Offstage] Widget.
///
/// Once the child is built its state is kept even when switching [index].
class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    Key? key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const [],
  }) : super(key: key);

  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;
  final int index;
  final List<Widget> children;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _active = _initializeActivateList();
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    _setChildren();
  }

  List<bool> _initializeActivateList() {
    return List<bool>.generate(
      widget.children.length,
      (i) => i == widget.index,
    );
  }

  void _setChildren() {
    _active[widget.index] = true;
    children = List.generate(_active.length, (i) {
      return TickerMode(
        enabled: widget.index == i,
        child: Offstage(
          offstage: widget.index != i,
          child: _active[i] ? widget.children[i] : const SizedBox.shrink(),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _setChildren();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: widget.alignment,
      sizing: widget.sizing,
      textDirection: widget.textDirection,
      index: widget.index,
      children: children,
    );
  }
}

import 'package:flutter/material.dart';

class SwipeOnlySwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwipeOnlySwitch({super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SwipeOnlySwitch> createState() => _SwipeOnlySwitchState();
}

class _SwipeOnlySwitchState extends State<SwipeOnlySwitch> {
  late bool _isOn;

  /* You store the current state (_isOn) locally and sync it with widget.
  value when the widget first builds. When swiped, it toggles _isOn and
  informs the parent using onChanged.*/
  @override
  void initState() {
    super.initState();
    _isOn = widget.value; // initial state from parent
  }

  void _toggle() {
    setState(() {
      _isOn = !_isOn; // update internal state
    });
    widget.onChanged(_isOn); // notify parent
  }

  double _dragStartX = 0;

  @override
  Widget build(BuildContext context) {
    // Tracks finger movement (dx) only on the horizontal axis.
    return GestureDetector(
      // No response to taps — swipe only!
      onHorizontalDragStart: (details) {
        _dragStartX = details.localPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        double dx = details.localPosition.dx - _dragStartX;
        //If user swipes > 20px right, it toggles ON
        if (dx > 20 && !_isOn) {
          _toggle(); // swiped right: turn ON

        } else if (dx < -20 && _isOn) { // If user swipes < -20px left, it toggles OFF.
          _toggle(); // swiped left: turn OFF
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer( // gives you a smooth animation when toggling.
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isOn
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.secondary,
        ),
        // changes the position of the thumb (left ↔ right) based on _isOn.
        alignment: _isOn ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.all(4),
        // Inner Container is the thumb, styled as a circle.
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: _isOn
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.onSecondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

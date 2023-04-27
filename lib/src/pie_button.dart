import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:pie_menu/pie_menu.dart';

/// Displays [PieAction]s of the [PieMenu] on the [PieCanvas].
class PieButton extends StatefulWidget {
  /// Creates a [PieButton] that is specialized for a [PieAction].
  const PieButton({
    super.key,
    required this.action,
    required this.menuActive,
    required this.hovered,
    required this.center,
    required this.theme,
    required this.fadeDuration,
    required this.hoverDuration,
    required this.angle,
  });

  /// Action to display.
  final PieAction action;

  /// Whether the [PieMenu] this [PieButton] belongs to is open.
  final bool menuActive;

  /// Whether this [PieButton] is currently hovered.
  final bool hovered;

  /// Whether this is the center [PieButton]
  final bool center;

  /// Behavioral and visual structure of this button.
  final PieTheme theme;

  /// Duration of the [PieMenu] fade animation.
  final Duration fadeDuration;

  /// Duration of the [PieButton] hover animation.
  final Duration hoverDuration;

  /// Display angle of [PieButton] in radians.
  final double angle;

  @override
  State<PieButton> createState() => _PieButtonState();
}

class _PieButtonState extends State<PieButton>
    with SingleTickerProviderStateMixin {
  /// Controls [_animation].
  late final AnimationController _controller = AnimationController(
    duration: widget.fadeDuration,
    vsync: this,
  )..addListener(() => setState(() {}));

  /// Fade animation for the [PieButton]s.
  late final Animation _animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  /// Whether the [PieButton] is visible.
  bool visible = false;

  PieAction get _action => widget.action;
  PieTheme get _theme => widget.theme;

  PieButtonTheme get _buttonTheme {
    return _action.buttonTheme ?? _theme.buttonTheme;
  }

  PieButtonTheme get _buttonThemeHovered {
    return _action.buttonThemeHovered ?? _theme.buttonThemeHovered;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.menuActive) {
      visible = false;
    } else if (widget.menuActive && !visible) {
      visible = true;
      _controller.forward(from: 0);
    }

    final button = Container(
      decoration: (widget.hovered
          ? _buttonThemeHovered.decoration
          : _buttonTheme.decoration) ??
          BoxDecoration(
            shape: BoxShape.circle,
            color: widget.hovered
                ? _buttonThemeHovered.backgroundColor
                : _buttonTheme.backgroundColor,
          ),
      child: Center(
        child: Padding(
          padding: _action.padding,
          child: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: widget.hovered
                    ? _buttonThemeHovered.iconColor
                    : _buttonTheme.iconColor,
                size: _theme.iconSize,
              ),
            ),
            child: _action.builder?.call(widget.hovered) ??
                _action.child!,
          ),
        ),
      ),
    );

    return OverflowBox(
      maxHeight: _theme.buttonSize * 2,
      maxWidth: _theme.buttonSize * 2,
      child: AnimatedScale(
        scale: widget.hovered ? 1.2 : 1,
        duration: widget.hoverDuration,
        curve: Curves.ease,
        child: Transform.scale(
          scale: _animation.value,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: widget.hoverDuration,
                curve: Curves.ease,
                top: widget.hovered
                    ? _theme.buttonSize / 2 - (widget.center ? 0 :
                        sin(widget.angle) * _theme.hoverDisplacement)
                    : _theme.buttonSize / 2,
                right: widget.hovered
                    ? _theme.buttonSize / 2 - (widget.center ? 0 :
                        cos(widget.angle) * _theme.hoverDisplacement)
                    : _theme.buttonSize / 2,
                child: _theme.showTooltipCircle ? Container(
                  height: _theme.buttonSize,
                  width: _theme.buttonSize,
                  decoration: (widget.hovered
                      ? _buttonThemeHovered.tooltipDecoration
                      : _buttonTheme.tooltipDecoration) ??
                      BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.hovered
                            ? _buttonThemeHovered.tooltipBackgroundColor
                            : _buttonTheme.tooltipBackgroundColor,
                      ),
                  child: Center(
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: button,
                        ),
                        Center(
                          child: CircularText(
                              radius: _theme.buttonSize - 12,
                              position: CircularTextPosition.inside,
                              children: [
                                TextItem(
                                  text: Text(widget.action.tooltip,
                                      style: _theme.tooltipStyle ?? TextStyle(fontSize: 16)),
                                  space: 16,
                                  startAngle: -90,
                                  startAngleAlignment: StartAngleAlignment.center,
                                  direction: CircularTextDirection.clockwise,
                                )
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                ) : button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

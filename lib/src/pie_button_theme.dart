import 'package:flutter/widgets.dart';
import 'package:pie_menu/src/pie_button.dart';

/// Defines the appearance of the circular buttons.
class PieButtonTheme {
  const PieButtonTheme({
    required this.backgroundColor,
    this.tooltipBackgroundColor,
    required this.iconColor,
    this.decoration,
    this.tooltipDecoration
  });

  /// Background color of [PieButton].
  final Color? backgroundColor;

  /// Background color of [PieButton] around tooltip.
  final Color? tooltipBackgroundColor;

  /// Icon color of [PieButton].
  final Color? iconColor;

  /// Container decoration of [PieButton].
  ///
  /// Note that a custom decoration ignores [backgroundColor].
  final Decoration? decoration;

  /// Container tooltip decoration of [PieButton].
  ///
  /// Note that a custom decoration ignores [tooltipBackgroundColor].
  final Decoration? tooltipDecoration;
}

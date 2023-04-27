import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:pie_menu/src/pie_button.dart';
import 'package:pie_menu/src/pie_canvas_provider.dart';

/// Defines the behavior and the appearance
/// of [PieCanvas] and [PieMenu] widgets.
class PieTheme {
  /// Creates a [PieTheme] to configure [PieMenu]s.
  const PieTheme({
    this.bouncingMenu = true,
    this.animateChild = true,
    this.dismissHint,
    this.dismissHintPadding = const EdgeInsets.all(16),
    this.dismissHintAlignment = Alignment.bottomLeft,
    this.dismissHintStyle,
    this.brightness = Brightness.light,
    this.overlayColor,
    this.pointerColor,
    this.buttonTheme = const PieButtonTheme(
      backgroundColor: Colors.blue,
      iconColor: Colors.white,
    ),
    this.buttonThemeHovered = const PieButtonTheme(
      backgroundColor: Colors.lime,
      iconColor: Colors.black,
    ),
    this.iconSize,
    this.distance = 96,
    this.angleOffset = 0,
    this.buttonSize = 56,
    this.pointerSize = 42,
    this.tooltipPadding = const EdgeInsets.symmetric(horizontal: 32),
    this.tooltipStyle,
    this.showTooltip = true,
    this.showTooltipCircle = true,
    this.pieBounceDuration = const Duration(seconds: 1),
    this.menuBounceDuration = const Duration(milliseconds: 120),
    this.menuBounceDistance = 24,
    this.menuBounceCurve = Curves.decelerate,
    this.menuBounceReverseCurve,
    this.fadeDuration = const Duration(milliseconds: 250),
    this.hoverDuration = const Duration(milliseconds: 250),
    this.delayDuration = const Duration(milliseconds: 350),
  });

  final bool bouncingMenu;

  /// Whether to animate the menu child
  final bool animateChild;

  /// Text to display when menu shown, telling use how to dismiss the menu
  final String? dismissHint;

  /// Padding value of the [dismissHint] at the edges of [PieCanvas].
  final EdgeInsets dismissHintPadding;

  /// Alignment of the [dismissHint] relative to the [PieCanvas].
  final Alignment dismissHintAlignment;

  /// Style of the [dismissHint] text.
  final TextStyle? dismissHintStyle;

  /// How the background and tooltip texts should be displayed
  /// if they are not specified explicitly.
  final Brightness brightness;

  /// Preferably a translucent color for [PieCanvas] to display
  /// under the menu child, and on top of the other widgets.
  final Color? overlayColor;

  /// Color of the widget displayed in the center of [PieMenu].
  final Color? pointerColor;

  /// Theme of [PieButton].
  final PieButtonTheme buttonTheme;

  /// Theme of [PieButton] when it is hovered.
  final PieButtonTheme buttonThemeHovered;

  /// Size of the icon to be displayed on the [PieButton].
  final double? iconSize;

  /// Distance between the [PieButton] and the center of [PieMenu].
  final double distance;

  /// Angle offset of the first [PieButton] displayed.
  final double angleOffset;

  /// Size of [PieButton] circle.
  final double buttonSize;

  /// Size of the widget displayed in the center of [PieMenu].
  final double pointerSize;

  /// Padding value of the tooltip at the edges of [PieCanvas].
  final EdgeInsets tooltipPadding;

  /// Style of the tooltip text.
  final TextStyle? tooltipStyle;

  /// Whether to show the tooltip
  final bool showTooltip;

  /// Whether to show the tooltip in the circle around the button
  final bool showTooltipCircle;

  /// Duration of [PieButton] bounce animation.
  final Duration pieBounceDuration;

  /// Duration of [PieMenu] bounce animation.
  final Duration menuBounceDuration;

  /// Distance of [PieMenu] bounce animation.
  final double menuBounceDistance;

  /// Curve for the menu bounce animation.
  final Curve menuBounceCurve;

  /// Reverse curve for the menu bounce animation.
  final Curve? menuBounceReverseCurve;

  /// Duration of [PieMenu] fade animation.
  final Duration fadeDuration;

  /// Duration of [PieButton] hover animation.
  final Duration hoverDuration;

  /// Long press duration for [PieMenu] to display.
  ///
  /// Can be set to [Duration.zero] to display the menu immediately on tap.
  final Duration delayDuration;

  /// Displacement distance of [PieButton]s when hovered.
  double get hoverDisplacement => buttonSize / 8;

  /// Returns the [PieTheme] defined in the closest [PieCanvas].
  static PieTheme of(BuildContext context) {
    return PieCanvasProvider.of(context).theme;
  }

  /// Creates a copy of this theme but with the
  /// given fields replaced with the new values.
  PieTheme copyWith({
    bool? bouncingMenu,
    Brightness? brightness,
    Color? overlayColor,
    Color? pointerColor,
    PieButtonTheme? buttonTheme,
    PieButtonTheme? buttonThemeHovered,
    double? iconSize,
    double? distance,
    double? angleOffset,
    double? buttonSize,
    double? pointerSize,
    bool? showTooltip,
    bool? showTooltipCircle,
    EdgeInsets? tooltipPadding,
    TextStyle? tooltipStyle,
    Duration? pieBounceDuration,
    Duration? menuBounceDuration,
    double? menuBounceDistance,
    Curve? menuBounceCurve,
    Curve? menuBounceReverseCurve,
    Duration? fadeDuration,
    Duration? hoverDuration,
    Duration? delayDuration,
  }) {
    return PieTheme(
      bouncingMenu: bouncingMenu ?? this.bouncingMenu,
      brightness: brightness ?? this.brightness,
      overlayColor: overlayColor ?? this.overlayColor,
      pointerColor: pointerColor ?? this.pointerColor,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      buttonThemeHovered: buttonThemeHovered ?? this.buttonThemeHovered,
      iconSize: iconSize ?? this.iconSize,
      distance: distance ?? this.distance,
      angleOffset: angleOffset ?? this.angleOffset,
      buttonSize: buttonSize ?? this.buttonSize,
      pointerSize: pointerSize ?? this.pointerSize,
      showTooltip: showTooltip ?? this.showTooltip,
      showTooltipCircle: showTooltipCircle ?? this.showTooltipCircle,
      tooltipPadding: tooltipPadding ?? this.tooltipPadding,
      tooltipStyle: tooltipStyle ?? this.tooltipStyle,
      pieBounceDuration: pieBounceDuration ?? this.pieBounceDuration,
      menuBounceDuration: menuBounceDuration ?? this.menuBounceDuration,
      menuBounceDistance: menuBounceDistance ?? this.menuBounceDistance,
      menuBounceCurve: menuBounceCurve ?? this.menuBounceCurve,
      menuBounceReverseCurve:
          menuBounceReverseCurve ?? this.menuBounceReverseCurve,
      fadeDuration: fadeDuration ?? this.fadeDuration,
      hoverDuration: hoverDuration ?? this.hoverDuration,
      delayDuration: delayDuration ?? this.delayDuration,
    );
  }
}

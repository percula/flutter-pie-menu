import 'package:flutter/material.dart';
import 'package:pie_menu/src/pie_action.dart';
import 'package:pie_menu/src/pie_canvas_provider.dart';
import 'package:pie_menu/src/pie_menu.dart';
import 'package:pie_menu/src/pie_menu_controller.dart';
import 'package:pie_menu/src/pie_theme.dart';

/// A widget that displays hierarchical pie menus.
///
/// [MultiPieMenu] presents a primary set of actions. When an action with
/// [PieAction.subActions] is selected, it automatically transitions to show
/// those sub-actions centered at the selected button's position.
///
/// Example:
/// ```dart
/// MultiPieMenu(
///   theme: PieTheme(...),
///   child: myWidget,
///   center: centerAction,
///   actions: [
///     // Actions without subActions work normally
///     PieAction(tooltip: 'Copy', onSelect: () => copy(), child: copyIcon),
///
///     // Actions WITH subActions transition to a secondary menu
///     PieAction(
///       tooltip: 'Plant',
///       child: plantIcon,
///       onSelect: () {}, // Called when sub-action menu opens (or ignored)
///       subActions: [
///         PieAction(tooltip: 'Info', onSelect: () => showInfo(), ...),
///         PieAction(tooltip: 'Remove', onSelect: () => remove(), ...),
///       ],
///       subCenter: PieAction(tooltip: 'Details', ...),
///     ),
///   ],
/// )
/// ```
class MultiPieMenu extends StatefulWidget {
  const MultiPieMenu({
    super.key,
    this.theme,
    this.actions = const [],
    this.center,
    this.scale,
    this.onToggle,
    this.onTap,
    required this.child,
  });

  /// Theme to use for this menu, overrides [PieCanvas] theme.
  final PieTheme? theme;

  /// Actions to display as buttons on the pie menu.
  ///
  /// Actions with [PieAction.subActions] will trigger a submenu
  /// when selected instead of calling [PieAction.onSelect].
  final List<PieAction> actions;

  /// Action to display at the center of the menu (optional).
  final PieAction? center;

  /// Scale of the pie menu.
  final ValueNotifier<double>? scale;

  /// Callback triggered when the menu opens or closes.
  ///
  /// Note: This is called when the entire multi-level menu opens/closes,
  /// not during transitions between primary and sub menus.
  final Function(bool active)? onToggle;

  /// Callback to determine if the menu should open on tap.
  ///
  /// Return false to prevent the menu from opening.
  final bool Function()? onTap;

  /// Widget to display as the menu trigger.
  final Widget child;

  @override
  State<MultiPieMenu> createState() => _MultiPieMenuState();
}

class _MultiPieMenuState extends State<MultiPieMenu> {
  /// Whether we're currently showing a submenu.
  bool _showingSubMenu = false;

  /// Position where the submenu should be centered.
  Offset? _subMenuPosition;

  /// The sub-actions to display in the submenu.
  List<PieAction>? _currentSubActions;

  /// The center action for the submenu.
  PieAction? _currentSubCenter;

  /// Controller for programmatic menu control.
  final _controller = PieMenuController();

  /// Flag indicating a submenu open is pending after the primary menu closes.
  bool _pendingSubMenuOpen = false;

  /// Whether this is the first menu open (to properly fire onToggle).
  bool _menuWasActive = false;

  /// Wraps primary actions to intercept those with subActions.
  List<PieAction> _wrapPrimaryActions() {
    return widget.actions.asMap().entries.map((entry) {
      final index = entry.key;
      final action = entry.value;

      if (action.subActions != null && action.subActions!.isNotEmpty) {
        // Wrap this action to transition to submenu on select
        if (action.builder != null) {
          return PieAction.builder(
            tooltip: action.tooltip,
            padding: action.padding,
            buttonTheme: action.buttonTheme,
            buttonThemeHovered: action.buttonThemeHovered,
            enabled: action.enabled,
            builder: action.builder!,
            onSelect: () => _handlePrimaryActionWithSubActions(index, action),
          );
        } else {
          return PieAction(
            tooltip: action.tooltip,
            padding: action.padding,
            buttonTheme: action.buttonTheme,
            buttonThemeHovered: action.buttonThemeHovered,
            enabled: action.enabled,
            child: action.child!,
            onSelect: () => _handlePrimaryActionWithSubActions(index, action),
          );
        }
      }
      return action;
    }).toList();
  }

  /// Handles selection of a primary action that has sub-actions.
  void _handlePrimaryActionWithSubActions(int index, PieAction action) {
    // Get position while menu is still active
    final canvasProvider = PieCanvasProvider.of(context);
    final canvas = canvasProvider.canvasKey.currentState;
    if (canvas == null) return;

    final position = canvas.getActionGlobalPosition(index);

    // Save state for submenu
    _subMenuPosition = position;
    _currentSubActions = action.subActions;
    _currentSubCenter = action.subCenter;
    _pendingSubMenuOpen = true;
    _showingSubMenu = true;
  }

  /// Handles the menu toggle callback.
  void _handleMenuToggle(bool active) {
    if (active) {
      _menuWasActive = true;
      // Only fire onToggle when menu first opens (not submenu transition)
      if (!_showingSubMenu) {
        widget.onToggle?.call(true);
      }
    } else {
      if (_pendingSubMenuOpen) {
        // Primary menu closed, need to open submenu
        _pendingSubMenuOpen = false;
        // Rebuild with submenu actions and open at saved position
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _subMenuPosition != null) {
            _controller.open(offset: _subMenuPosition);
          }
        });
      } else if (_menuWasActive) {
        // Menu fully closed (either primary or submenu)
        _menuWasActive = false;
        // Reset submenu state
        setState(() {
          _showingSubMenu = false;
          _subMenuPosition = null;
          _currentSubActions = null;
          _currentSubCenter = null;
        });
        // Fire onToggle when menu fully closes
        widget.onToggle?.call(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine which actions and center to show
    final actions = _showingSubMenu && _currentSubActions != null
        ? _currentSubActions!
        : _wrapPrimaryActions();
    final center = _showingSubMenu ? _currentSubCenter : widget.center;

    return PieMenu(
      controller: _controller,
      theme: widget.theme,
      actions: actions,
      center: center,
      scale: widget.scale,
      onToggle: _handleMenuToggle,
      onTap: widget.onTap,
      child: widget.child,
    );
  }
}

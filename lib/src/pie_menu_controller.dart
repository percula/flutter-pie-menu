import 'package:flutter/material.dart';

/// Controller for programmatic control of a [PieMenu].
///
/// Attach this controller to a [PieMenu] to enable programmatic
/// opening and closing of the menu.
class PieMenuController extends ChangeNotifier {
  PieMenuStateAccessor? _stateAccessor;

  /// Whether a PieMenu is currently attached to this controller.
  bool get isAttached => _stateAccessor != null;

  /// Whether the menu is currently open.
  bool get isOpen => _stateAccessor?.isMenuActive ?? false;

  /// Open the menu programmatically.
  ///
  /// [offset] is optional - if not provided, opens at the center of the widget.
  /// Returns false if no menu is attached or menu is already open.
  bool open({Offset? offset}) {
    if (_stateAccessor == null) return false;
    return _stateAccessor!.openMenu(offset: offset);
  }

  /// Close the menu programmatically.
  void close() {
    _stateAccessor?.closeMenu();
  }

  /// Called by PieMenuState to register itself with this controller.
  void attach(PieMenuStateAccessor accessor) {
    _stateAccessor = accessor;
  }

  /// Called by PieMenuState when it's disposed.
  void detach() {
    _stateAccessor = null;
  }
}

/// Interface for PieMenuState to implement.
/// This allows the controller to interact with the state without tight coupling.
abstract class PieMenuStateAccessor {
  bool get isMenuActive;
  bool openMenu({Offset? offset});
  void closeMenu();
}

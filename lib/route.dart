import 'package:flutter/widgets.dart';

/// Used to push a `MaterialSnackbar` in the Navigator.
class SnackbarRoute extends OverlayRoute {
  /// The entry that should be pushed.
  final OverlayEntry entry;

  /// Used to push a `MaterialSnackbar`.
  ///
  /// The MaterialSnackbarMessenger will call `Navigator.pop()`
  /// again when it wasn't accessed from the snackbar
  /// (e.g. when you press a back button).
  SnackbarRoute(this.entry);

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [entry];
  }
}

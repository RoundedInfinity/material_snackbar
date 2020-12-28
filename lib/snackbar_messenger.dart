import 'package:flutter/material.dart';
import 'snackbar.dart';

/// For displaying material snackbars.
///  Equivalent of the `ScaffoldMessenger`.
///
/// To display a material snackbar,
/// obtain the [MaterialSnackbarMessengerState] of the current [BuildContext]
/// by using [MaterialSnackBarMessenger.of].
/// Then use the functions of the
/// [MaterialSnackbarMessengerState] to display snackbars.
///
/// The `OverlayEntrys` used for the `MaterialSnackbars`
/// are stored in [snackbarQuere].
/// You should not change this list manually.
///
/// Here is an example for a button that will display a material snackbar:
/// ```dart
/// ElevatedButton(
///   child: Text('Show material snackbar'),
///   onPressed: () {
///     MaterialSnackBarMessenger.of(context).showSnackBar(
///       snackbar: MaterialSnackbar(
///         content: Text('Deleted 142 important documents'),
///       ),
///     );
///   },
/// ),
/// ```

class MaterialSnackBarMessenger {
  /// The `OverlayEntrys` used for the `MaterialSnackbars` are
  ///  stored in this List.
  ///  You should not change this list manually.
  static List<OverlayEntry> snackbarQueue = [];

  /// Passes the [BuildContext] to the [MaterialSnackBarMessengerState].
  static MaterialSnackBarMessengerState of(BuildContext context) =>
      MaterialSnackBarMessengerState(context);
}

/// Constructed with [MaterialSnackBarMessenger.of] to manage snackbars.
class MaterialSnackBarMessengerState {
  /// [BuildContext] used for getting `Overlay.of(context)`.
  final BuildContext context;

  /// This Object can be used to display material snackbars.
  /// Those are shown with an overlay.
  ///
  /// Typically obtained via [MaterialSnackbarMessenger.of].
  ///
  /// See also:
  ///
  /// - [MaterialSnackBarMessenger]
  /// - [MaterialSnackBarMessenger.of(context).showSnackBar()]
  ///
  MaterialSnackBarMessengerState(this.context);

  /// Display a [MaterialSnackbar] using the [newest material design.](https://material.io/components/snackbars#full-screen-dialog).
  ///
  /// [snackbar],[padding] and [alignment] can’t be null.
  ///
  /// If a [MaterialSnackbar] is already displayed,
  /// this [snackbar] gets added to the `snackbarQueue`
  /// and will be displayed when it is the only snackbar left in the queue.
  ///
  /// Here are some examples:
  /// ```dart
  /// // Just shows a material snackbar.
  /// MaterialSnackBarMessenger.of(context).showSnackBar(
  ///   snackbar: MaterialSnackbar(
  ///     content: Text('Deleted 142 important documents'),
  /// );
  /// // This shows a snackbar in the bottom center with more spaceing.
  /// MaterialSnackBarMessenger.of(context).showSnackBar(
  ///   alignment: Alignment.bottomCenter,
  ///   padding: EdgeInsets.all(30),
  ///   snackbar: MaterialSnackbar(
  ///     content: Text('Deleted 142 important documents'),
  ///   ),
  /// );
  ///
  /// ```
  void showSnackBar({
    @required MaterialSnackbar snackbar,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20.0),
    Alignment alignment = Alignment.bottomRight,
  }) {
    assert(alignment != null);
    assert(padding != null);
    assert(snackbar != null);

    OverlayEntry _overlay;

    void _onDismiss() {
      if (_overlay != null) _overlay.remove();
      MaterialSnackBarMessenger.snackbarQueue.remove(_overlay);
      _queueSnackbars();
    }

    _overlay = OverlayEntry(
      builder: (context) {
        return Align(
          key: UniqueKey(),
          alignment: alignment,
          child: Padding(
            padding: padding,
            child: Builder(
              builder: (context) => Container(
                constraints: BoxConstraints(maxHeight: 68, minWidth: 344),
                child: snackbar.withCustomCallback(callback: _onDismiss),
              ),
            ),
          ),
        );
      },
    );

    MaterialSnackBarMessenger.snackbarQueue.add(_overlay);
    if (MaterialSnackBarMessenger.snackbarQueue.length == 1) {
      Overlay.of(context).insert(MaterialSnackBarMessenger.snackbarQueue.first);
    }
  }

  void _queueSnackbars() {
    if (MaterialSnackBarMessenger.snackbarQueue.isNotEmpty) {
      Overlay.of(context).insert(MaterialSnackBarMessenger.snackbarQueue.first);
    }
  }

  /// A faster way to display a material snackbar.
  ///
  ///  It displays a [MaterialSnackbar] with a default [Text] and
  /// a [TextButton] as a [action].
  ///
  /// [content] can't be `null`.
  ///
  /// Example:
  /// ```
  ///MaterialSnackBarMessenger.of(context).snack(
  ///  'I am speed',
  ///  actionText: 'REPLY',
  ///  onAction: () => print('Speeeed'),
  ///);
  /// ```
  void snack(String content, {String actionText, VoidCallback onAction}) {
    showSnackBar(
      snackbar: MaterialSnackbar(
        content: Text(content),
        action: onAction != null
            ? TextButton(
                child: Text(actionText),
                onPressed: onAction ?? () {},
              )
            : null,
      ),
    );
  }
}

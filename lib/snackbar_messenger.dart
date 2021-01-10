import 'package:flutter/material.dart';

import 'route.dart';
import 'snackbar.dart';

// ignore: avoid_classes_with_only_static_members
/// For displaying material snackbars.
/// Equivalent of the `ScaffoldMessenger`.
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
  /// stored in this List.
  /// You should not change this list manually.
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
  /// [snackbar] and [padding] can’t be null.
  ///
  /// [alignment] defaults to `Aligment.bottomCenter` on android and iOS
  ///  and `Aligment.bottomLeft` on desktop.
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
  ///
  /// This uses the `Navigator.of(context)` and adds a `Route`
  /// to display the snackbar.
  ///
  /// ### Dismissing the snackbar
  ///
  /// To dismiss the snackbar use
  /// the close function of the [actionBuilder].
  /// __Never__ use `Navigator.of(context).pop()`.
  ///
  /// See also:
  /// - [MaterialSnackBarMessenger.of(context).snack]
  /// - [MaterialSnackbar]
  /// - [SnackbarRoute]
  void showSnackBar({
    @required MaterialSnackbar snackbar,
    EdgeInsetsGeometry padding = const EdgeInsets.all(20.0),
    Alignment alignment,
  }) {
    assert(padding != null);
    assert(snackbar != null);

    OverlayEntry _entry;
    var isMobile = Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.android;

    alignment ??= isMobile ? Alignment.bottomCenter : Alignment.bottomLeft;

    void _onDismiss() {
      if (MaterialSnackBarMessenger.snackbarQueue.isNotEmpty &&
          _entry != null) {
        MaterialSnackBarMessenger.snackbarQueue.remove(_entry);
      }
      //MaterialSnackBarMessenger.snackbarQueue.remove(_entry);

      _queueSnackbars();
    }

    _entry = OverlayEntry(
      builder: (context) {
        return Align(
          key: UniqueKey(),
          alignment: alignment,
          child: Padding(
            padding: padding,
            child: Builder(
              builder: (context) => snackbar.withCustomCallback(
                callback: _onDismiss,
              ),
            ),
          ),
        );
      },
    );

    MaterialSnackBarMessenger.snackbarQueue.add(_entry);
    if (MaterialSnackBarMessenger.snackbarQueue.length == 1) _pushSnackbar();
  }

  void _queueSnackbars() {
    if (MaterialSnackBarMessenger.snackbarQueue.isNotEmpty) _pushSnackbar();
  }

  Future<void> _pushSnackbar() async {
    var wasDismissed = await Navigator.maybeOf(context)
        .push(SnackbarRoute(MaterialSnackBarMessenger.snackbarQueue.first));
    if (wasDismissed == null) {
      Navigator.of(context).maybePop();
      emptyQueue();
    }
  }

  /// A faster way to display a material snackbar.
  ///
  ///  It displays a [MaterialSnackbar] with a default [Text] and
  /// a [TextButton] as an [action].
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
  void snack(
    String content, {
    String actionText,
    VoidCallback onAction,
    bool actionDismissesSnack = true,
  }) {
    showSnackBar(
      snackbar: MaterialSnackbar(
        content: Text(content),
        theme: Theme.of(context).snackBarTheme,
        actionBuilder: (context, close) => onAction != null
            ? TextButton(
                child: Text(actionText),
                onPressed: () {
                  onAction();
                  close();
                },
              )
            : null,
      ),
    );
  }

  /// Empty all snackbars in the snackbar Queue.
  ///
  /// When a snackbar is currently displayed, it won't be affected.
  void emptyQueue() {
    MaterialSnackBarMessenger.snackbarQueue = [];
  }
}

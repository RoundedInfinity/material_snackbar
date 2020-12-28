import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A Widget that follows the [newest material snackbar design.](https://material.io/components/snackbars#full-screen-dialog). To display this snackbar use the `MaterialSnackBarMessenger`.
///
/// See also:
/// - [MaterialSnackBarMessenger]
/// - [MaterialSnackBarMessenger.of(context).showSnackBar()]
/// - [MaterialSnackbar()]
class MaterialSnackbar extends StatefulWidget {
  /// The `Widget` located in this [MaterialSnackbar].
  ///
  /// Can't be `null`.
  @required
  final Widget content;

  /// The [action] located on the right.
  ///
  /// Typically a `TextButton`.
  final Widget action;

  /// The time this snackbar stays on the screen.
  ///  Should be about 2 to 10 seconds.
  ///
  /// Can't be `null`.
  final Duration duration;

  /// The `Duration` this snackbar needs to fade in.
  final Duration enterDuration;

  /// The `Duration` this snackbar needs to fade out.
  final Duration exitDuration;

  /// The `Curve` this snackbar uses to fade in.
  final Curve enterCurve;

  /// The `Curve` this snackbar uses to fade out.
  final Curve exitCurve;

  /// Called after the snackbar was dismissed.
  final VoidCallback onDismiss;

  /// The [SnackBarThemeData] to apply to this widget.
  final SnackBarThemeData theme;

  /// A Widget that follows the [newest material snackbar design.](https://material.io/components/snackbars#full-screen-dialog). To display this snackbar use the `MaterialSnackBarMessenger`.
  ///
  /// The time this snackbar stays is determend by the [duration].
  ///
  /// The [content] widget, typically a `Text` widget,
  ///  is located in the snackbar.
  ///
  /// _Only_ [theme],[action] and [onDismiss] _can_ be null.
  ///
  /// This [MaterialAppbar] fades in and out using the `FadeScale` effect.
  ///  When `accessibleNavigation` is `true` no animation will play.
  ///
  /// You can use the [theme] to customize the design.
  ///
  /// Here are some examples:
  ///
  /// ```dart
  /// // Shows a MaterialSnackbar with an undo button.
  /// MaterialSnackBarMessenger.of(context).showSnackBar(
  ///   alignment: Alignment.bottomLeft,
  ///   snackbar: MaterialSnackbar(
  ///     content: Text('Deleted 142 important documents'),
  ///     action: TextButton(
  ///       child: Text('UNDO'),
  ///       onPressed: () {
  ///         print('yee');
  ///       },
  ///     ),
  ///   ),
  /// );
  ///
  /// // Customize the fade in and out durations and curves.
  /// MaterialSnackBarMessenger.of(context).showSnackBar(
  ///   alignment: Alignment.bottomLeft,
  ///   snackbar: MaterialSnackbar(
  ///     enterDuration: Duration(milliseconds: 400),
  ///     exitDuration: Duration(milliseconds: 200),
  ///     enterCurve: Curves.bounceOut,
  ///     exitCurve: Curves.easeIn,
  ///     content: Text('Deleted 142 important documents'),
  ///     action: TextButton(
  ///       child: Text('UNDO'),
  ///       onPressed: () {},
  ///     ),
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  ///
  /// - [MaterialSnackBarMessenger]
  /// - [MaterialSnackBarMessenger.of(context).showSnackBar()]
  const MaterialSnackbar({
    Key key,
    this.content,
    this.action,
    this.duration = const Duration(seconds: 2),
    this.onDismiss,
    this.enterDuration = const Duration(milliseconds: 150),
    this.exitDuration = const Duration(milliseconds: 75),
    this.enterCurve = Curves.easeOut,
    this.exitCurve = Curves.linear,
    this.theme,
  })  : assert(content != null),
        assert(duration != null),
        assert(enterDuration != null),
        assert(exitDuration != null),
        assert(enterCurve != null),
        assert(exitCurve != null),
        super(key: key);
  @override
  _MaterialSnackbarState createState() => _MaterialSnackbarState();

  /// Copies this snackbar and add a callback before [onDismiss] is called.
  MaterialSnackbar withCustomCallback({
    VoidCallback callback,
  }) {
    return MaterialSnackbar(
      content: content,
      action: action,
      duration: duration,
      enterCurve: enterCurve,
      enterDuration: enterDuration,
      exitCurve: exitCurve,
      exitDuration: exitDuration,
      theme: theme,
      onDismiss: () {
        if (callback != null) callback();
        if (onDismiss != null) onDismiss();
      },
    );
  }
}

class _MaterialSnackbarState extends State<MaterialSnackbar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.enterDuration,
      reverseDuration: widget.exitDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future<void> _showAndHideSnackbar() async {
    await _controller.forward();
    await Future.delayed(widget.duration);
    await hideSnackbar();
  }

  Future<void> hideSnackbar() async {
    if (_controller.isCompleted) await _controller.reverse().orCancel;

    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    var snackBarTheme = widget.theme ?? Theme.of(context).snackBarTheme;
    var theme = Theme.of(context).brightness == Brightness.dark
        ? ThemeData.light()
        : ThemeData.dark();

    var shape = snackBarTheme.shape ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));
    var elevation = snackBarTheme.elevation ?? 12;

    _showAndHideSnackbar();

    var _snackbar = Theme(
      data: theme,
      child: Material(
        shape: shape,
        elevation: elevation,
        color: snackBarTheme.backgroundColor ?? null,
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: widget.content,
              ),
              if (widget.action != null)
                TextButtonTheme(
                  data: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                  child: widget.action,
                ),
            ],
          ),
        ),
      ),
    );

    return MediaQuery.of(context).accessibleNavigation ?? false
        ? _snackbar
        : FadeScaleTransition(
            child: _snackbar,
            animation: CurvedAnimation(
              parent: _controller,
              curve: _controller.status == AnimationStatus.forward
                  ? widget.enterCurve
                  : widget.exitCurve,
            ),
          );
  }
}

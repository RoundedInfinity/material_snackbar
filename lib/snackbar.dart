import 'package:flutter/material.dart';

import 'package:material_snackbar/snackbar_messenger.dart';
import 'package:material_snackbar/transition.dart';

///Builder for material snackbars with the ability to dismiss the snackbar.
typedef CloseActionBuilder = Widget? Function(
    BuildContext context, VoidCallback close);

/// A Widget that follows the [newest material snackbar design.](https://material.io/components/snackbars#full-screen-dialog). To display this snackbar use the `MaterialSnackBarMessenger`.
///
/// See also:
/// - [MaterialSnackBarMessenger]
/// - [MaterialSnackBarMessenger.of(context).showSnackBar()]
/// - [MaterialSnackbar()]
class MaterialSnackbar extends StatefulWidget {
  /// The [action] located on the right,
  /// but with the ability to dismiss the snackbar by
  /// calling `close` from the builder.
  ///
  /// When [action] has a value, it will be displayed instead of this.
  final CloseActionBuilder? actionBuilder;

  /// The `Widget` located in this [MaterialSnackbar].
  ///
  /// Can't be `null`.
  @required
  final Widget content;

  /// The [action] located on the right.
  ///
  /// Typically a `TextButton`.
  final Widget? action;

  /// The time this snackbar stays on the screen.
  /// Should be about 2 to 10 seconds according to the material design studies.
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

  /// Called __after__ the snackbar was dismissed.
  final VoidCallback? onDismiss;

  /// The [SnackBarThemeData] to apply to this widget.
  final SnackBarThemeData? theme;

  final Widget Function(
          BuildContext context, Animation<double> animation, Widget snackbar)?
      transitionBuilder;

  /// A Widget that follows the [newest material snackbar design.](https://material.io/components/snackbars#full-screen-dialog). To display this snackbar use the `MaterialSnackBarMessenger`.
  ///
  /// The time this snackbar stays on the screen is determend by the [duration].
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
    Key? key,
    required this.content,
    this.actionBuilder,
    this.action,
    this.duration = const Duration(seconds: 2),
    this.onDismiss,
    this.enterDuration = const Duration(milliseconds: 250),
    this.exitDuration = const Duration(milliseconds: 100),
    this.enterCurve = Curves.linear,
    this.exitCurve = Curves.linear,
    this.theme,
    this.transitionBuilder,
  }) : super(key: key);

  @override
  _MaterialSnackbarState createState() => _MaterialSnackbarState();

  /// Copy this snackbar and add a callback before [onDismiss] is called.
  MaterialSnackbar withCustomCallback({
    VoidCallback? callback,
    GlobalKey<_MaterialSnackbarState>? state,
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
      actionBuilder: actionBuilder,
      onDismiss: () {
        if (callback != null) callback();
        if (onDismiss != null) onDismiss!();
      },
    );
  }
}

class _MaterialSnackbarState extends State<MaterialSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    // set snackBarVisible to true after build has executed.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => MaterialSnackBarMessenger.snackBarVisible = true,
    );

    _controller = AnimationController(
      vsync: this,
      duration: widget.enterDuration,
      reverseDuration: widget.exitDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    MaterialSnackBarMessenger.snackBarVisible = false;

    super.dispose();
  }

  void pop() {
    Navigator.of(context).pop(true);
  }

  Future<void> _showAndHideSnackbar() async {
    await _controller.forward();
    await Future.delayed(widget.duration);
    await hideSnackbar();
  }

  /// Hide this snackbar and with a fade out animation.
  Future<void> hideSnackbar() async {
    if (_controller.isCompleted && mounted) {
      await _controller.reverse();
    }
    if (mounted) {
      MaterialSnackBarMessenger.snackBarVisible = false;
      pop();
      widget.onDismiss!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final snackBarTheme = widget.theme ?? Theme.of(context).snackBarTheme;
    final theme = Theme.of(context).brightness == Brightness.dark
        ? ThemeData.light()
        : ThemeData.dark();
    final isMobile = theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.android;
    final shape = snackBarTheme.shape ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));
    final elevation = snackBarTheme.elevation ?? 12;

    final maxHeight = isMobile ? 144.0 : 168.0;

    //init function
    _showAndHideSnackbar();

    final _snackbar = Container(
      constraints: BoxConstraints(maxHeight: maxHeight, minWidth: 344),
      child: LayoutBuilder(
        builder: (context, constraints) => Theme(
          data: theme,
          child: Material(
            shape: shape,
            elevation: elevation,
            color: snackBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: constraints.maxWidth - 32),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    child: DefaultTextStyle(
                      style: snackBarTheme.contentTextStyle ??
                          theme.textTheme.bodyMedium!,
                      maxLines: isMobile ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                      child: widget.content,
                    ),
                  ),
                  if (widget.actionBuilder != null || widget.action != null)
                    TextButtonTheme(
                      data: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                      ),
                      child: widget.action ??
                          widget.actionBuilder!(
                            context,
                            hideSnackbar,
                          )!,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Don't use an animation if accessible navigation is activated.

    final animation = CurvedAnimation(
        parent: _controller,
        curve: _controller.status == AnimationStatus.forward
            ? widget.enterCurve
            : widget.exitCurve);

    final transition = widget.transitionBuilder != null
        ? widget.transitionBuilder!(context, animation, _snackbar)
        : defaultTransitionBuilder(
            context,
            _controller,
            _snackbar,
          );

    return MediaQuery.of(context).accessibleNavigation ||
            MaterialSnackBarMessenger.snackBarVisible
        ? _snackbar
        : transition;
  }

  Widget defaultTransitionBuilder(
      BuildContext context, Animation<double> animation, Widget snackbar) {
    return Material3ScaleTransition(animation: animation, child: snackbar);
  }
}

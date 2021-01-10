# Material snackbar

A flutter plugin for displaying snackbars with the newest material design on desktop and mobile.

[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart)  [![CodeFactor](https://www.codefactor.io/repository/github/roundedinfinity/material_snackbar/badge?s=89a59680d2dfcd0b3d2cfe477dcc64f04eea2ee9)](https://www.codefactor.io/repository/github/roundedinfinity/material_snackbar)

## Features

- [Material design (with material motion)](https://material.io/components/snackbars).
- Designed for **desktop** and **mobile.**
- **Snackbar queue** for stacking snackbars.

![showcase](https://i.imgur.com/JQMQRdQ.gif)

## Usage

First, add the `material_snackbar` package to your [pubspec dependencies](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

To import  `material_snackbar`:

```dart
import 'package:material_snackbar/material_snackbar.dart';
```

For displaying a material snackbar you need to obtain the [MaterialSnackbarMessengerState] of the current [BuildContext] by using [MaterialSnackBarMessenger.of].

### Material snackbar

Here is an example how to display a simple snackbar.

```dart
MaterialSnackBarMessenger.of(context).showSnackBar(
  snackbar: MaterialSnackbar(
    content: Text('Deleted 142 important documents'),
  ),
);
```

Use  `actionBuilder` to add an action button that can dismiss the snackbar.

```dart
MaterialSnackBarMessenger.of(context).showSnackBar(
  snackbar: MaterialSnackbar(
    content: Text('Deleted 142 important documents.'),
    actionBuilder: (context, close) => TextButton(
      child: Text('DISMISS'),
      onPressed: close,
    ),
  ),
);
```

### Snackbar queue

When you show multiple snackbars they are not displayed all at one time. They are added to the _snackbar queue_  and are displayed individually after the previously shown snackbar.

![snackbar queue](https://i.imgur.com/BfrED6E.gif)


To empty the _snackbar queue_ use:

```dart
MaterialSnackBarMessenger.of(context).emptyQueue();
```

### Faster ⚡

When you just need a normal snackbar you can use `snack()` to save time.

```dart
 MaterialSnackBarMessenger.of(context).snack(
   'I am speed',
   actionText: 'REPLY',
   onAction: () => print('Speeeed'),
 );
```

For more examples see the example tab ➡

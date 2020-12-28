import 'package:flutter/material.dart';

import 'package:material_snackbar/material_snackbar.dart';
import 'package:material_snackbar/snackbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Show material snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      snackbar: MaterialSnackbar(
                        content: Text('Deleted 142 important documents'),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Show centered material snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(30),
                      snackbar: MaterialSnackbar(
                        content: Text('Deleted 142 important documents'),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Show  material snackbar with action'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomLeft,
                      snackbar: MaterialSnackbar(
                        content: Text('Deleted 142 important documents'),
                        action: TextButton(
                          child: Text('UNDO'),
                          onPressed: () {
                            print('yee');
                          },
                        ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text(
                      'Show  material snackbar with custom enter and exit'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomLeft,
                      snackbar: MaterialSnackbar(
                        enterDuration: Duration(milliseconds: 400),
                        exitDuration: Duration(milliseconds: 200),
                        enterCurve: Curves.bounceOut,
                        exitCurve: Curves.easeIn,
                        content: Text('Deleted 142 important documents'),
                        action: TextButton(
                          child: Text('UNDO'),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Show  a long material snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomLeft,
                      snackbar: MaterialSnackbar(
                        duration: Duration(seconds: 6),
                        content: Text(
                          'Before we start, however, keep in mind that although fun and learning are the primary goals of all enrichment center activities, serious injuries may occur.',
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                ),
                TextButton(
                  child: Text('Show snack'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.topLeft,
                      snackbar: MaterialSnackbar(
                        content: Text('UI Quality'),
                        enterCurve: Curves.bounceOut,
                        action: TextButton(
                          child: Text('RETRY'),
                          onPressed: () {},
                        ),
                        duration: Duration(seconds: 4),
                        theme: SnackBarThemeData(backgroundColor: Colors.amber),
                      ),
                    );
                  },
                ),
                TextButton(
                  child: Text('Show snack (the fast way)'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).snack(
                      'I am speed',
                      actionText: 'RETRY',
                      onAction: () => print('Speeeed'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

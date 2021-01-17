import 'package:flutter/material.dart';

import 'package:material_snackbar/material_snackbar.dart';

import 'more.dart';

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
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Snackbar example app'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Snackbar without much fuss
                ElevatedButton(
                  child: Text('material snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      snackbar: MaterialSnackbar(
                        content: Text('Deleted 142 important documents.'),
                      ),
                    );
                  },
                ), //With custom alignment.
                ElevatedButton(
                  child: Text('Centered material snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(30),
                      snackbar: MaterialSnackbar(
                        content: Text('Deleted 142 important documents.'),
                      ),
                    );
                  },
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    // With action.
                    ElevatedButton(
                      child: Text('Material snackbar with action'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).showSnackBar(
                          snackbar: MaterialSnackbar(
                            content: Text('Deleted 142 important documents.'),
                            action: TextButton(
                              child: Text('UNDO'),
                              onPressed: () {},
                            ),
                          ),
                        );
                      },
                    ),
                    //You will use this more often.
                    ElevatedButton(
                      child: Text('Material snackbar with dismissing action'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).showSnackBar(
                          snackbar: MaterialSnackbar(
                            content: Text('Deleted 142 important documents.'),
                            actionBuilder: (context, close) => TextButton(
                              child: Text('DISMISS'),
                              onPressed: close,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Snackbar quere 1'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).showSnackBar(
                          snackbar: MaterialSnackbar(
                            duration: Duration(seconds: 1),
                            content: Text('Hey I just met you,'),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('2'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).showSnackBar(
                          snackbar: MaterialSnackbar(
                            duration: Duration(seconds: 1),
                            content: Text('and this is crazy.'),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('and 3'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).showSnackBar(
                          snackbar: MaterialSnackbar(
                            duration: Duration(seconds: 1),
                            content: Text('But here\'s my number, '),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('and 3'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).showSnackBar(
                          snackbar: MaterialSnackbar(
                            duration: Duration(seconds: 1),
                            content: Text('so call me maybe'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  child: Text(
                    'Material snackbar with custom enter and exit',
                  ),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomLeft,
                      snackbar: MaterialSnackbar(
                        enterDuration: Duration(milliseconds: 800),
                        exitDuration: Duration(milliseconds: 200),
                        enterCurve: Curves.bounceOut,
                        exitCurve: Curves.easeIn,
                        content: Text('Deleted 142 important documents.'),
                        action: TextButton(
                          child: Text('UNDO'),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),
                //THis text splits in two lines when on mobile.
                ElevatedButton(
                  child: Text('Long material snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.bottomLeft,
                      snackbar: MaterialSnackbar(
                        // A longer duration so you can read the text before it disappears.
                        duration: Duration(seconds: 6),
                        content: Text(
                          'Before we start, however, keep in mind that although fun and learning are the primary goals of all enrichment center activities, serious injuries may occur.',
                        ),
                      ),
                    );
                  },
                ),

                ElevatedButton(
                  child: Text('VERY customized snackbar'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).showSnackBar(
                      alignment: Alignment.topLeft,
                      snackbar: MaterialSnackbar(
                        content: Text('UI Quality is important for your app'),
                        enterCurve: Curves.bounceOut,
                        enterDuration: Duration(seconds: 1),
                        action: TextButton(
                          child: Text('RETRY'),
                          onPressed: () {},
                        ),
                        duration: Duration(seconds: 4),
                        theme: SnackBarThemeData(
                            backgroundColor: Colors.yellowAccent),
                      ),
                    );
                  },
                ),
                // If you don't want to customize the SnackBar, you can remove some boilerplate code.
                ElevatedButton(
                  child: Text('snack (the fast way)'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).snack(
                      'I\'m burnin\' through the sky, yeah',
                      actionText: 'RETRY',
                      onAction: () => print('Speeeed'),
                    );
                  },
                ),

                // Use the snackbarTheme to customize the SnackBar.
                Theme(
                  data: ThemeData(
                    snackBarTheme:
                        SnackBarThemeData(backgroundColor: Colors.yellow),
                  ),
                  child: Builder(
                    builder: (context) => ElevatedButton(
                      child: Text('use a theme'),
                      onPressed: () {
                        MaterialSnackBarMessenger.of(context).snack(
                          'That\'s why they call me Mister Fahrenheit.',
                          actionText: 'RETRY',
                          onAction: () => print('Speeeed'),
                        );
                      },
                    ),
                  ),
                ),
                // Removes all snackbar in the snackbar queue.
                ElevatedButton(
                  child: Text('Empty queue'),
                  onPressed: () {
                    MaterialSnackBarMessenger.of(context).emptyQueue();
                  },
                ),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MorePage(),
                    ),
                  ),
                  icon: Icon(Icons.arrow_forward_outlined),
                  label: Text('More examples'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

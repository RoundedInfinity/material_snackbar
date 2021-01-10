import 'package:flutter/material.dart';
import 'package:material_snackbar/material_snackbar.dart';

// This is used for experimenting.
class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(title: Text('More examples')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  setState(() {});
                },
                child: Text('Yeee'),
              ),
              ElevatedButton(
                onPressed: () async {
                  MaterialSnackBarMessenger.of(context).showSnackBar(
                    snackbar: MaterialSnackbar(
                      onDismiss: () {},
                      content: Text('Deleted 142 important documents.'),
                      actionBuilder: (context, close) => TextButton(
                        child: Text('DISMISS'),
                        onPressed: close,
                      ),
                    ),
                  );
                },
                child: Text('Yeee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

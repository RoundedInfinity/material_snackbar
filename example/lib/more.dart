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
              Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    MaterialSnackBarMessenger.of(context).snack('yee');
                  },
                  child: Text('Yeee'),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.work_outline), label: 'Work'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
          ],
        ),
      ),
    );
  }
}

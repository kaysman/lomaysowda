import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unexpected error occured :('),
            SizedBox(height: 20.0),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              icon: Icon(Icons.home, size: 40.0),
            ),
          ],
        ),
      ),
    );
  }
}

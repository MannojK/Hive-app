import 'package:flutter/material.dart';
import 'colour.dart'; // Import the color data

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var color in containerColors.take(3))
              Container(
                width: 100,
                height: 100,
                color: color,
                margin: EdgeInsets.all(10.0),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Go back to the main page
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

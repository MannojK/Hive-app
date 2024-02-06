import 'package:flutter/material.dart';
import 'colour.dart';
import 'page2.dart'; // Import the color data

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NextPage(),
                ));
              },
              child: Text('Go to Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}

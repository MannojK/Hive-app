import 'package:flutter/material.dart';

class Experiment extends StatelessWidget {
   final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];
   Experiment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          title: Text('Sequential Colors Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var color in colors)
                Container(
                  width: 100,
                  height: 100,
                  color: color,
                  margin: EdgeInsets.all(10.0),
                ),
            ],
          ),
        ),
    
    
    );
  }
}
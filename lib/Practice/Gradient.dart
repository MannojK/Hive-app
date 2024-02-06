
import 'package:flutter/material.dart';
import 'package:hive_app/Practice/homepage.dart';

class GradientFAB extends StatelessWidget {
  // HomePage  homes = HomePage();
  var a = HomePage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade300,
              Colors.purple.shade500,
              Colors.purple.shade600,
              Colors.purple.shade800,
              Colors.deepPurple
            ], // Define your gradient colors
            begin: Alignment.topRight, // Adjust the gradient start point
            end: Alignment.bottomLeft, // Adjust the gradient end point
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent,
              blurRadius: 34,
            )
          ]),
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor:
            Colors.transparent, // Set background color to transparent
      ),
    );
  }
}


class ability{
  helloworld(){
   print('helloworld');
  }
}
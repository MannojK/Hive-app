import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Animation'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: Duration(seconds: 1), // Adjust the duration as needed
          curve: Curves.easeInOut,
          width: isExpanded ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 2,
          height: isExpanded ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height / 2,
          color: Colors.blue,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              TextField( decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
                  ),
                ),
                ),
            ],
          )
        ),
      ),
    );
  }
}

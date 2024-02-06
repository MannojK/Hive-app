import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_app/Example/pract.dart';
import 'package:hive_app/Mine/pages/create_home.dart';
import 'package:hive_app/Mine/create_page.dart';
import 'package:hive_app/Mine/gridtext.dart';
import 'package:hive_app/Mine/pages/experiment.dart';
import 'package:hive_app/Practice/homepage.dart';
import 'package:hive_app/Routing/page1.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Example/Home.dart';
import 'Routing/animate.dart';

void main()async{
  // initalize hive 

  await Hive.initFlutter();
  await Hive.openBox('shopping_box');
  await Hive.openBox('myBox');
  await Hive.openBox('notes');
  await Hive.openBox('notesbox'); // being used 
  await Hive.openBox('example');
  WidgetsFlutterBinding.ensureInitialized();

   // Than we setup preferred orientations,
  // and only after it finished we run our app
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) => runApp(MyApp()));
      runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
     home:Home(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

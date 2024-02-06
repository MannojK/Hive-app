import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/Mine/gridtext.dart';
import 'package:hive_app/Mine/pages/note_page.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../home.dart';
import '../models/note.dart';

class create_Home extends StatefulWidget {
  const create_Home({super.key});

  @override
  State<create_Home> createState() => _create_HomeState();
}

class _create_HomeState extends State<create_Home> {
  // ****   NOTES BOX INITIALIZED
  final notesbox = Hive.box('notes');
  List<Notes> _items = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

// ***** INIT STATE
  @override
  void initState() {
    super.initState();
    _items = sampleNotes;
  }

// ***** ADD METHOD
  Future<void> _createItem(Notes) async {
    await notesbox.add(Notes(
        title: _titleController,
        content: _bodyController,
        dateTime: DateFormat('EEE MMM d, yyyy h:mm a')));
  }

// ***** REFRESH ITEMS 
Notes _refreshItems(int key){
  final item = notesbox.get(key);
  return Notes(title: _titleController.text, content: _bodyController.text, dateTime: DateTime(2018,9,7,17));
}
  // ***** PUT METHOD
  Future<void> _updateItem(int itemkey, Notes) async {
    await notesbox.put(
        itemkey,
        Notes(
            title: _titleController,
            content: _bodyController,
            dateTime: DateFormat('EEE MMM d, yyyy h:mm a')));
  }

  // **** DELETE METHOD
  Future<void> _deleteItem(int itemkey) async {
    await notesbox.delete(itemkey);
  }

  Color randomColors() {
    Random random = Random();

    var cindex = random.nextInt(backgroundColors.length);
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 75,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10),
          child: Text(
            'NOTES',
            style: GoogleFonts.leagueGothic(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 8, 0),
        child: Stack(
          children: [
            const SizedBox(
              height: 30,
            ),
            //  const  SizedBox(
            //     height: 50,
            //     child: gridText()),
            // gridText(),
            NoteText(),
          ],
        ),
      ),
      floatingActionButton: GradientFAB(),
    );
  }

  Expanded NoteText() {
    return Expanded(
      child: ListView.builder(
          itemCount: _items.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final data = _items[index];
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Card(
                margin: EdgeInsets.all(5),
                color: randomColors(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      data.title,
                      style: TextStyle(fontSize: 19),
                    ),
                    subtitle: Text(data.content),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class GradientFAB extends StatefulWidget {
  @override
  State<GradientFAB> createState() => _GradientFABState();
}

class _GradientFABState extends State<GradientFAB> {
  @override
  Widget build(BuildContext context) {
     
    return Container(
    width: 56.0,
    height: 56.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade100,
            Colors.purple.shade200,
            Colors.purple.shade300,
            Colors.purple.shade800,
            Colors.deepPurple
          ], // Define your gradient colors
          begin: Alignment.topRight, // Adjust the gradient start point
          end: Alignment.bottomLeft, // Adjust the gradient end point
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent,
            blurRadius: 14,
          )
        ]),
    child: FloatingActionButton(
      onPressed: ()  async {
final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const NotePage(),
          ),
        );

        if (result != null) {
          setState(() {
            sampleNotes.add(Notes(
                title: result[0],
                content: result[1],
                dateTime: DateTime.now()));
            var _items = sampleNotes;
          });
        }
      },
      child: Icon(Icons.add),
      backgroundColor:
          Colors.transparent, // Set background color to transparent
    ),
  );
  }
}

/*
LIST OF FONTS 
pacifico
milkshake
gooddog
adaptive_icon_foreground:'#ffffff'

List of tasks 
1. Sequence of colors in a list 
2. Animation page 
3. reload option  
*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/Mine/create_page.dart';
import 'package:hive_app/Mine/models/note.dart';
import 'package:intl/intl.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../constants/colors.dart';

class gridText extends StatefulWidget {
  const gridText({super.key});

  @override
  State<gridText> createState() => _gridTextState();
}

class _gridTextState extends State<gridText> {
  List<Notes> _items = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

// ***** INIT STATE
  @override
  void initState() {
    super.initState();
    _items = sampleNotes;
  }

  // ****   NOTES BOX INITIALIZED

  final notesbox = Hive.box('notes');

// ***** ADD METHOD
  Future<void> _createItem(Notes) async {
    await notesbox.add(Notes(title: _titleController, content: _bodyController, dateTime:  DateFormat('EEE MMM d, yyyy h:mm a')));
  }
  // ***** PUT METHOD 
  Future<void> _updateItem(int itemkey ,Notes) async{
    await notesbox.put(itemkey, Notes( title: _titleController, content: _bodyController, dateTime: DateFormat('EEE MMM d, yyyy h:mm a')
    )

    );
  }
  // **** DELETE METHOD 
  Future<void> _deleteItem (int itemkey) async{
    await notesbox.delete(itemkey);
  }

  Color randomColors() {
    Random random = Random();

    var cindex = random.nextInt(backgroundColors.length);
    return backgroundColors[random.nextInt(backgroundColors.length)];

//tempcol is random color
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return slsd();
  }

  Expanded slsd() {
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
/*
 return StaggeredGridView.count(
      staggeredTiles: _cardTile,
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: List.generate(12, (index) {
        return GestureDetector(
          onTap: () {
            // scale(),
            Navigator.push(
              context,
              ScaleRoute(page: page_two()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: randomColors(),
              borderRadius: BorderRadiusDirectional.circular(19),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notesbox.get(1),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    notesbox.get(2),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    notesbox.get(3),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    notesbox.get(4),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
*/

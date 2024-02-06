import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_app/constants/colors.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'Gradient.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // *** Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

// **** Random Colors
  Color RandomColors() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

// **** BOX
  final _notesBox = Hive.box('notesbox');

  // ******  REFRESH METHOD
  void _refreshItems() {
    final data = _notesBox.keys.map((key) {
      final item = _notesBox.get(key);
      return {
        'key': key,
        'title': item['title'],
        'description': item['description'],
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  // ******            ADD METHOD

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _notesBox.add(newItem);
    _refreshItems();
    print('amount data is ${_notesBox.length}');
  }

  // ******            PUT OR UPDATE  METHOD
  Future<void> _updateItem(int itemkey, Map<String, dynamic> item) async {
    await _notesBox.put(itemkey, item);
    _refreshItems();
  }

  // *****            DELETE METHOD

  Future<void> _deleteItem(int itemkey) async {
    await _notesBox.delete(itemkey);
    _refreshItems();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An Item has been deleted')));
  }
// ***** BOTTOM FORM

  void _showForm(BuildContext ctx, int? itemkey) async {
    if (itemkey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemkey);
      _titleController.text = existingItem['title'];
      _descriptionController.text = existingItem['description'];
    }
    showModalBottomSheet(
        backgroundColor: Colors.black,
        barrierColor: Colors.black,
        context: ctx,
        builder: (_) => Container(
              // color: Colors.black,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border:
                      Border.all(color: Colors.tealAccent.shade400, width: 5),
                  borderRadius: BorderRadius.circular(40)),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                top: 15,
                left: 15,
                right: 15,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // ****               TEXT FIELDS 
                    TextField(
                      controller: _titleController,
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Colors.grey.shade600,
                
                          fontSize: 30),),
                      style: TextStyle(color: Colors.white,fontSize: 25),
                      enableSuggestions: true,
                      // maxLines: 3,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _descriptionController,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                            hintText: 'body',
                            hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: 20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                            
                      
                    // *****  CREATE  ITEM
                            
                    Center(
                      child: ElevatedButton(
                      
                          onPressed: () async {
                            // Clear the text fields
                            if (itemkey == null) {
                              _createItem({
                                "title": _titleController.text,
                                "description": _descriptionController.text,
                              }
                              );
                            }
                    // *****  UPDATE ITEM
                            if (itemkey != null) {
                              _updateItem(itemkey, {
                                'title': _titleController.text.trim(),
                                'description': _descriptionController.text.trim(),
                              });
                            }
                            // cleara the text fields
                            _titleController.text = '';
                            _descriptionController.text = '';
                    
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                          ),
                          child: Text(itemkey == null ? 'Create New' : 'Update')),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, null);
        },
        backgroundColor: Colors.transparent,
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade100,
                  Colors.purple.shade300,
                  Colors.purple.shade500,
                  Colors.purple.shade700,
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
          child: Icon(Icons.add),
        ),
      ),
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
        padding: const EdgeInsets.fromLTRB(5, 0.5 * kToolbarHeight, 10, 10),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final currentItem = _items[index];
            return GestureDetector(
              onTap: () {
                _showForm(context, currentItem['key']);
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  // shadowColor: const Color.fromARGB(255, 230, 36, 22),
                  // shape: BeveledRectangleBorder(),.
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  
                  color: RandomColors(),
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      // **** TITLE TEXT 
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(currentItem['title'].toString()),
                      ), // here is the error
                            // **** DESCRITPION  TEXT 
              
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentItem['description'].toString(),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // IconButton(
                          //     onPressed: () {
                          //       _showForm(context, currentItem['key']);
                          //     },
                          //     icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                _deleteItem(currentItem['key']);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// class GradientFAB extends StatefulWidget {
//   final method;
//   const GradientFAB({super.key, required this.method});
//   @override
//   State<GradientFAB> createState() => _GradientFABState();
// }

// class _GradientFABState extends State<GradientFAB> {
//   HomePage  homes = HomePage();
  
//   @override
//   void initState(){
//     super.initState();
    
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 56.0,
//       height: 56.0,
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: LinearGradient(
//             colors: [
//               Colors.purple.shade100,
//               Colors.purple.shade200,
//               Colors.purple.shade300,
//               Colors.purple.shade800,
//               Colors.deepPurple
//             ], // Define your gradient colors
//             begin: Alignment.topRight, // Adjust the gradient start point
//             end: Alignment.bottomLeft, // Adjust the gradient end point
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purpleAccent,
//               blurRadius: 34,
//             )
//           ]),
//       child: FloatingActionButton(
//         onPressed: () async {
          
//         },
//         child: Icon(Icons.add),
//         backgroundColor:
//             Colors.transparent, // Set background color to transparent
//       ),
//     );
//   }
// }

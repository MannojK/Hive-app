import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final shopbox = Hive.box('example');

  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();

  List<Map<String, dynamic>> _items = [];
  // ***** Add Method
  void addItem(Map<String, dynamic> item) async {
    await shopbox.add(item);
    refershItems();
    // _items.add({'name': 'words'});
  }
  // ***** Update Method

  void updateItem(int itemkey, Map<String, dynamic> item) async {
    await shopbox.put(itemkey, item);
    refershItems();
  }

  // ***** Delete Method
  void deleteItem(int itemkey) async {
    await shopbox.delete(itemkey);
    refershItems();
  }

  // ***** Update Method
  void refershItems() {
    final data = shopbox.keys.map((key) {
      final item = shopbox.get(key);
      return {
        'key': key,
        'title': item['title'],
        'body': item['body'],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
    });
  }

  showModalForm(BuildContext ctx, int? itemkey) async {
       if(itemkey != null){
        final existingItem = 
        _items.firstWhere((element) => element['key'] == itemkey);
        _title.text = existingItem['title'];
        _body.text = existingItem['body'];
       }
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
              top: 15,
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _title,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _body,
                  decoration: const InputDecoration(hintText: 'Body'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () {
                      if (itemkey == null) {
                        addItem({
                          'title': _title.text,
                          'body': _body.text,
                        });
                      }
                      if (itemkey != null) {
                        updateItem(itemkey, {
                          'title': _title.text.trim(),
                          'body': _body.text.trim(),
                        });
                      }
                      _title.text = '';
                      _body.text = '';
                      Navigator.of(context).pop();
                    },
                    child:
                        Text(itemkey == null ? 'Create Item ' : 'Update item',style: TextStyle(color: Colors.white),)),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // addmethod(item);
    print(_items.length);
    refershItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final currentItem = _items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.lightBlue.shade600,
                  elevation: 10,
                  child: ListTile(
                    title: Text(
                      currentItem['title'].toString(),
                    ),
                    subtitle: Text(
                      currentItem['body'].toString(),
                    ),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          onPressed: () {
                            showModalForm(context, currentItem['key']);

                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            deleteItem(currentItem['key']);
                          },
                          icon: Icon(Icons.delete)),
                    ]),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showModalForm(context, null);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

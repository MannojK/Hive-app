import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Pract extends StatefulWidget {
  const Pract({super.key});

  @override
  State<Pract> createState() => _PractState();
}

class _PractState extends State<Pract> {
  final _practice = Hive.box('example');
  List<Map<String, dynamic>> _items = [];

  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  // **** Add method
  Future<void> _addItem(Map<String, dynamic> item) async {
    await _practice.add(item);
    _refreshItems();
  }

  // **** put method
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _practice.put(itemKey, item);
    _refreshItems();
  }

  // **** update method
  void _refreshItems() {
    final data = _practice.keys.map((key) {
      final item = _practice.get(key);
      return {
        'key': key,
        'title': item['title'],  // This is the value associated with the key 'name'. In Dart, item is assumed to be a map (based on the usage in the previous lines), and it is accessing the value associated with the key 'name' from this map.
        'body': item['body'],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
    });
  }

  // **** delete method
  void _deleteItem(int itemKey) async {
    await _practice.delete(itemKey);
    _refreshItems();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  void _showForm(BuildContext ctx, int? itemkey) async {
    if (itemkey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemkey);
      _title.text = existingItem['name'];
      _body.text = existingItem['quantity'];
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _title,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _body,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'Quantity'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //  **** Create item

                  ElevatedButton(
                      onPressed: () async {
                        if (itemkey == null) {
                          _addItem({
                            'title': _title.text,
                            'body': _body.text,
                          });
                        }
                        if (itemkey != null) {
                          _updateItem(itemkey, {
                            'title': _title.text.trim(),
                            'body': _body.text.trim(),
                          });
                        }

                        _title.text = '';
                        _body.text = '';
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          itemkey == null ? 'Create New ' : 'Update Item')),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, null);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: ((context, index) {
          final currentItem = _items[index];

          return Card(
            color: Colors.orange.shade100,
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              title: Text(currentItem['title'].toString()),
              subtitle: Text(currentItem['body'].toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        _showForm(context, currentItem['key']);
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        _deleteItem(currentItem['key']);
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/*



return {'key': key, 'name': item['name'], 'quantity': item['quantity']};
The expression 'name': item['name'] is creating a key-value pair in a Dart map. Let's break it down:

'name': This is the key in the map. It means that you are associating a value with the key 'name'.

item['name']: This is the value associated with the key 'name'. In Dart, item is assumed to be a map (based on the usage in the previous lines), and it is accessing the value associated with the key 'name' from this map.

So, in summary, 'name': item['name'] is adding an entry to the map being created. The key is 'name', and the value is obtained from the 'name' 
*/
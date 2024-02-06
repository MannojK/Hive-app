import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// import 'package:hive_data';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

  final _shoppingBox = Hive.box('shopping_box');

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

// ***** REFRESH ITEMS
  void _refreshItems() {
    final data = _shoppingBox.keys.map((key) {
      final item = _shoppingBox.get(key);
      return {'key': key, 'name': item['name'], 'quantity': item['quantity']};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
      // we use 'reversed to sort items in order from the latest to the oldest
    });
  }

// Create new item

// ******            ADD METHOD

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _shoppingBox.add(newItem); // 0 , 1, 2,
    _refreshItems();
    print('amount data is ${_shoppingBox.length}');
  }
// update the UI

// ******           PUT OR UPDATE  METHOD

  Future<void> _updateItem(int itemkey, Map<String, dynamic> item) async {
    await _shoppingBox.put(itemkey, item); // 0 , 1, 2,
    _refreshItems();
    print('amount data is ${_shoppingBox.length}');
  }
// delete item

// ******           DELETE METHOD

  Future<void> _deleteItem(int itemkey) async {
    await _shoppingBox.delete(itemkey); // 0 , 1, 2,
    _refreshItems();
    // print('amount data is ${_shoppingBox.length}');

    // Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  // ***** bottom form
  void _showForm(BuildContext ctx, int? itemkey) async {
    if (itemkey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemkey);
      _nameController.text = existingItem['name'];
      _quantityController.text = existingItem['quantity'];
    }
    showModalBottomSheet(
        context: ctx,
        builder: (_) => Container(
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
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'Quantity'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // *****  CREATE  ITEM

                  ElevatedButton(
                      onPressed: () async {
                        // Clear the text fields
                        if (itemkey == null) {
                          _createItem({
                            "name": _nameController.text,
                            "quantity": _quantityController.text,
                          });
                        }
// *****  UPDATE ITEM
                        if (itemkey != null) {
                          _updateItem(itemkey, {
                            'name': _nameController.text.trim(),
                            'quantity': _quantityController.text.trim(),
                          });
                        }
                        // cleara the text fields
                        _nameController.text = '';
                        _quantityController.text = '';

                        Navigator.of(context).pop();
                      },
                      child: Text(itemkey == null ? 'Create New' : 'Update')),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ));
  }

// ******   ui part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, null);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 1 * kToolbarHeight, 5, 10),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final currentItem = _items[index];
            return Card(
              color: Colors.orange.shade100,
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                title: Text(currentItem['name']),
                subtitle: Text(currentItem['quantity'].toString()),
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
          },
        ),
      ),
    );
  }
}
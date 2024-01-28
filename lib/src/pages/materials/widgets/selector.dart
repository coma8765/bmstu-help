import 'package:flutter/material.dart';

abstract class AbstractItem {
  String get id;
  String get title;
}

class Item {
  Item({required this.id, required this.title});

  final String id;
  final String title;
}

typedef SelectorCallback = void Function(String id);

class Selector extends StatelessWidget {
  const Selector({super.key, required this.callback, required this.items});

  final SelectorCallback callback;
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      prototypeItem: ListTile(
        title: Text(items.first.title),
      ),
      itemBuilder: (BuildContext context, int index) => Card(
        child: ListTile(
          onTap: () => callback(items[index].id),
          title: Text(items[index].title),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}

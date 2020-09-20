import 'package:flutter/material.dart';

class ListElement extends StatelessWidget {
  final int id;
  final String name;
  final Function detail;

  ListElement(this.id, this.name, this.detail);

  @override
  Widget build(BuildContext context) {
    String capitalize(String _text) {
      return "${_text[0].toUpperCase()}${_text.substring(1)}";
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        onTap: detail,
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              ('#' + id.toString()),
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
        title: Text(
          capitalize(name),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}

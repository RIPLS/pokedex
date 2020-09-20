//Paquetes
import 'package:flutter/material.dart';

class ConfirmModal extends StatelessWidget {
  final BuildContext ctx;
  final Function function;
  ConfirmModal(this.ctx, this.function);

  @override
  Widget build(BuildContext ctx) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text('Are you sure you want to log out?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Sure'),
          onPressed: () {
            function();
            //Close Dialog
            Navigator.of(ctx).pop();
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            //Close Dialong
            Navigator.of(ctx).pop();
          },
        )
      ],
    );
  }
}

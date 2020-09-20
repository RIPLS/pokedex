import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.adjust,
            size: 85,
            color: Colors.black,
          ),
          Divider(
            thickness: 5,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

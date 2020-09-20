import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function buttonFunction;

  ButtonWidget(
      {Key key,
      @required this.buttonColor,
      @required this.buttonFunction,
      @required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        splashColor: Colors.blueAccent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        color: buttonColor,
        child: Container(
          width: 100,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button,
          ),
        ),
        onPressed: buttonFunction,
      ),
    );
  }
}

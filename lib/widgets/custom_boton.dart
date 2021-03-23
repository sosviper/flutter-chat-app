import 'package:flutter/material.dart';


class CustomBoton extends StatelessWidget {

  final String text;
  final Function onPressed;
  final Color color;

  const CustomBoton({
    Key key, 
    @required this.text, 
    @required this.onPressed, 
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: this.color,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text( this.text, style: TextStyle( color: Colors.white, fontSize: 17 ),),
        ),
      ),
      onPressed: this.onPressed
    );
  }
}
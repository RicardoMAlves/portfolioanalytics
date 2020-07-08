import 'package:flutter/material.dart';
import 'customitemdrawertile.dart';

class CustomDrawer extends StatefulWidget {

  final String _textHeaderDrawer;
  final int _typeItemDrawer;

  CustomDrawer(this._textHeaderDrawer, this._typeItemDrawer);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {

    final _backGroundColor = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );

    final _textHeader = Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
      height: 170.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            left: 0.0,
            child: Text(
              widget._textHeaderDrawer,
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hello, Ricardo. Please select one of them >",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _backGroundColor,
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              _textHeader,
              Divider(),
              CustomItemDrawerTile(widget._typeItemDrawer),
            ],
          ),
        ],
      ),
    );
  }
}

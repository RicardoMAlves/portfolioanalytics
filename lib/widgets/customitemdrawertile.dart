import 'package:flutter/material.dart';

class CustomItemDrawerTile extends StatelessWidget {

  final int _typeItemDrawer;

  final List<String> _itemDrawer = ["Daily Cash", "FIDC Life Time", "About"];

  final List<IconData> _itemIconDataDrawer = [Icons.attach_money, Icons.date_range, Icons.list];

  CustomItemDrawerTile(this._typeItemDrawer);

  @override
  Widget build(BuildContext context) {

    if (_typeItemDrawer > 3)
      return Text("Ops! Option Item Drawer Error (> 3).");

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _itemDrawer.length,
      itemBuilder: (BuildContext context, int index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            child: Container(
              height: 60.0,
              child: Row(
                children: <Widget>[
                  Icon(
                    _itemIconDataDrawer[index],
                    size: 25.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    _itemDrawer[index],
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              if (_itemDrawer[index] == "Daily Cash")
                Navigator.pushNamed(context, "/dailyCashKpis");
              if (_itemDrawer[index] == "FIDC Life Time")
                Navigator.pushNamed(context, "/lifetimeKpis");
            },
          ),
        );
      },
    );

  }
}

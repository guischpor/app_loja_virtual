import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  //const DrawerTile({Key key}) : super(key: key);

  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 60.0,
            child: Row(
              children: <Widget>[
                Icon(icon, size: 32.0, color: Colors.black),
                SizedBox(
                  width: 32.0,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

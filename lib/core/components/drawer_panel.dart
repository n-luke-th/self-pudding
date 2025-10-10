import 'package:flutter/material.dart';
import 'package:pudding/core/utils/routing.dart';

class DrawerPanel extends StatelessWidget {
  const DrawerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(50),
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      elevation: 32,
      child: ListView(
        padding: EdgeInsets.zero, // Remove default padding
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle tap for Item 1
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle tap for Item 2
            },
          ),
          ListTile(
            title: IconButton.filled(
              onPressed: () => Routing.pushToDevLogPage(context),
              icon: const Icon(Icons.logo_dev_rounded, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

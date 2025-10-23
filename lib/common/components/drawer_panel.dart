import 'package:flutter/material.dart';
import 'package:pudding/common/components/app_info_cont.dart';
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/navigation/routing.dart';

// TODO: complete this

/// a drawer component
class DrawerPanel extends StatelessWidget {
  const DrawerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: Parts.defaultBorderRadius),
      width: MediaQuery.sizeOf(context).width * 0.7,
      elevation: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            margin: Parts.zeroEdgeInsets,
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Expanded(
            child: GridView(
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              padding: Parts.zeroEdgeInsets,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: SizingScale.tiny.value,
                mainAxisExtent: MediaQuery.sizeOf(context).height * 0.11,
              ),
              children: [
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
                    onPressed: () => Routing.pushToDevLogPage(),
                    icon: const Icon(
                      Icons.logo_dev_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppInfoCont(
            containerDecoration: BoxDecoration(
              borderRadius: Parts.defaultBorderRadius,
            ),
          ),
        ],
      ),
    );
  }
}

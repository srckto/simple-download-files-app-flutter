import 'package:flutter/material.dart';

import 'package:download_files_example/view/layout/layout_controller.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  LayoutController controller = LayoutController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: IndexedStack(
            children: controller.items.map((e) => e.screen).toList(),
            index: controller.index,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          currentIndex: controller.index,
          backgroundColor: Colors.white,
          onTap: (int index) {
            setState(() {
              controller.onChange(index);
            });
          },
          selectedItemColor: Colors.amber,
          selectedFontSize: 12,
          items: controller.items
              .map(
                (element) => BottomNavigationBarItem(
                  icon: Icon(element.icon),
                  label: element.name,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

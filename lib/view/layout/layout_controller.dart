import 'package:download_files_example/view/files/files_screen.dart';
import 'package:download_files_example/view/home/home_screen_with_pagination.dart';
import 'package:flutter/material.dart';

class _LayoutItem {
  String name;
  Widget screen;
  IconData icon;

  _LayoutItem({
    required this.name,
    required this.screen,
    required this.icon,
  });
}

class LayoutController {
  late List<_LayoutItem> items;
  late int index;

  LayoutController() {
    items = [
      _LayoutItem(name: "Home", screen: HomeScreenWithPagination(), icon: Icons.home),
      _LayoutItem(name: "My Files", screen: FilesScreen(), icon: Icons.insert_drive_file),
    ];
    index = 0;
  }

  void onChange(int newIndex) {
    index = newIndex;
  }
}

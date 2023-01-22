import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UIProvider>(context);
    final currentIndex = uiprovider.slectedMenuOpt;

    return BottomNavigationBar(
        onTap: (int i) => uiprovider.slectedMenuOpt = i,
        elevation: 0,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ]);
  }
}

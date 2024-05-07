import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/room/f_room.dart';
import 'package:flutter/material.dart';

enum TabItem {
  roomFirst(Icons.looks_one, "1청사", RoomFragment()),
  roomSecond(Icons.looks_two, "2청사", RoomFragment());

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon}) : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated ? Vx.theme10 : Vx.gray300,
        ),
        label: tabName);
  }
}

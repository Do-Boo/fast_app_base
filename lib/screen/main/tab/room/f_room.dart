import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/w_reservation_app_bar.dart';
import 'package:fast_app_base/test.dart';
import 'package:flutter/material.dart';

class RoomFragment extends StatefulWidget {
  const RoomFragment({super.key});

  @override
  State<RoomFragment> createState() => _RoomFragmentState();
}

class _RoomFragmentState extends State<RoomFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Vx.theme10,
      child: const Stack(
        children: [
          SearchWidget(),
          ReservationAppBar(),
        ],
      ),
    );
  }
}

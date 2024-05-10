import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_model.dart';
import 'package:flutter/material.dart';

class ReservationAppBar extends StatefulWidget {
  const ReservationAppBar({super.key});

  @override
  State<ReservationAppBar> createState() => _ReservationAppBarState();
}

class _ReservationAppBarState extends State<ReservationAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Vx.theme10,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
        child: Column(
          children: [
            Row(
              children: [
                const Text("events",
                    style: TextStyle(
                      fontFamily: "NotoSansKR-Bold",
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromARGB(255, 237, 107, 98),
                    )),
                emptyExpanded,
                SearchButton(icon: Icons.search, onPressed: () => {}),
                width10,
                RoundButton(icon: Icons.notifications, onPressed: () => print("asd1f")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

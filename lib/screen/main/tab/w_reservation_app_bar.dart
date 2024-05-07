import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

class ReservationAppBar extends StatefulWidget {
  const ReservationAppBar({super.key});

  @override
  State<ReservationAppBar> createState() => _ReservationAppBarState();
}

class _ReservationAppBarState extends State<ReservationAppBar> {
  bool _showRedDot = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      color: Vx.theme10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Tap(
                  onTap: () => setState(() => _showRedDot = !_showRedDot),
                  child: Stack(
                    children: [
                      Icon((_showRedDot ? Icons.bedtime_outlined : Icons.bedtime), color: Vx.gray500, size: 30),
                    ],
                  ),
                ),
                emptyExpanded,
                Tap(
                  onTap: () => setState(() => _showRedDot = !_showRedDot),
                  child: Stack(
                    children: [
                      const Icon(Icons.notifications, color: Vx.gray500, size: 30),
                      if (_showRedDot)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container().box.roundedFull.color(Colors.red).size(6, 6).make(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     const Text("2024. 05. 02.(목)", style: TextStyle(fontSize: 21, color: Vx.gray500)),
            //     emptyExpanded,
            //     Tap(
            //       onTap: () => setState(() => _showRedDot = !_showRedDot),
            //       child: Stack(
            //         children: [
            //           Icon((_showRedDot ? Icons.bedtime_outlined : Icons.bedtime), color: Vx.gray500, size: 30),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

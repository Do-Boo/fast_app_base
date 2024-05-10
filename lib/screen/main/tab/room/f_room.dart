import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/util/mysql/mysql_query.dart';
import 'package:fast_app_base/common/util/provider_util.dart';
import 'package:fast_app_base/common/widget/w_calendar.dart';
import 'package:fast_app_base/screen/main/tab/w_reservation_app_bar.dart';
import 'package:fast_app_base/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomFragment extends StatefulWidget {
  const RoomFragment({super.key});

  @override
  State<RoomFragment> createState() => _RoomFragmentState();
}

class _RoomFragmentState extends State<RoomFragment> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<ReservationAppBarLineProvider>(context, listen: false).setReservationAppbarLine(false);
      Provider.of<SearchResultProvider>(context, listen: false).setSearchResult(searchList("", DateTime.now()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          // Provider.of<ReservationAppBarLineProvider>(context, listen: false).setReservationAppbarLine(true);
        }
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            Provider.of<ReservationAppBarLineProvider>(context, listen: false).setReservationAppbarLine(true);
          } else if (scrollNotification is ScrollEndNotification) {
            Provider.of<ReservationAppBarLineProvider>(context, listen: false).setReservationAppbarLine(false);
          }
          return true;
        },
        child: Container(
          color: Vx.theme10,
          child: const Stack(
            children: [
              SearchWidget(),
              WeekCalendar(),
              ReservationAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}

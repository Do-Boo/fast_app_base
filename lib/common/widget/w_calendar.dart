import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/util/mysql/mysql_query.dart';
import 'package:fast_app_base/common/util/provider_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key});

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 72),
      height: 140,
      decoration: BoxDecoration(
        color: Vx.white,
        boxShadow: [
          BoxShadow(
            color: Provider.of<ReservationAppBarLineProvider>(context).reservationAppbarLine ? Colors.grey.withOpacity(0.2) : Colors.transparent,
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        locale: 'en_US',
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        headerVisible: false,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: const TextStyle().copyWith(color: Colors.black),
          weekendStyle: const TextStyle().copyWith(color: Colors.red),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: const TextStyle().copyWith(color: Colors.red),
          holidayTextStyle: const TextStyle().copyWith(color: Colors.blue),
          selectedTextStyle: const TextStyle().copyWith(color: Colors.black),
          todayTextStyle: const TextStyle().copyWith(color: Colors.black),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: Vx.gray200,
              width: 1,
            ),
          ),
          todayDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 237, 107, 98),
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) async {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          Provider.of<SelectedDayProvider>(context, listen: false).setSelectedDay(selectedDay);
          Provider.of<SearchTextProvider>(context, listen: false).setSearchText("");
          Provider.of<SearchResultProvider>(context, listen: false).setSearchResult(searchList(context));
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        onFormatChanged: (format) {
          // setState(() {
          //   _calendarFormat = format;
          // });
        },
      ),
    );
  }
}

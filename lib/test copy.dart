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
        color: Vx.theme10,
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
          // Add async keyword
          setState(() {
            _selectedDay = selectedDay;
            Provider.of<SelectedDayProvider>(context, listen: false).setSelectedDay(selectedDay);
            Provider.of<SearchTextProvider>(context, listen: false).setSearchText(Provider.of<SearchTextProvider>(context, listen: false).searchText);
            _focusedDay = focusedDay;
          });

          // Call searchList asynchronously
          var searchResult = await searchList(Provider.of<SearchTextProvider>(context, listen: false).searchText, selectedDay);

          // Update SearchResultProvider state with the result
          Provider.of<SearchResultProvider>(context, listen: false).setSearchResult(searchResult);
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

import "package:mysql1/mysql1.dart";

Future<List<Map>>? searchList(String keyword, DateTime selectedDay) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: "doboo.tplinkdns.com",
    port: 3306,
    user: "user",
    password: "2B@Dinterface",
    db: "mydb",
  ));

  var results = await conn.query("SELECT * FROM report WHERE 회의실 LIKE ?", ["%$keyword%"]);
  // var results = await conn.query(
  //     "SELECT *, Date_format(사용날짜, '%Y-%m-%d') as 날짜,(abs(TIMESTAMPDIFF(minute, 사용날짜, now())) < 60) and 신청여부 = '승인' as 시간 FROM report left join status on report.id = status.id left join tel on report.id = tel.id where 회의실 LIKE '%' and 회의실 LIKE '%' and replace(회의명, ' ', '') LIKE ? and 신청여부 LIKE '승인' and ((Date_format(사용날짜, '%H') > 12) + 1) <> ? and 사용날짜 between ? and ? order by 날짜 desc, sort, 사용날짜",
  //     ["%$keyword%"]);
  await conn.close();

  List<Map> data = [];
  for (var row in results) {
    data.add({
      "roomName": row[0],
      "useDate": row[1],
      "description": row[2],
      "departmentName": row[3],
      "applicant": row[4],
      "apply": row[5],
      "useTime": row[6],
      "sortNumber": row[7],
    });
  }

  return data;
}
import 'package:flutter/material.dart';

class SearchTextProvider with ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }
}

class ReservationAppBarLineProvider with ChangeNotifier {
  bool _reservationAppbarLine = true;

  bool get reservationAppbarLine => _reservationAppbarLine;

  void setReservationAppbarLine(bool bool) {
    _reservationAppbarLine = bool;
    notifyListeners();
  }
}

class SelectedDayProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }
}

class SearchResultProvider with ChangeNotifier {
  Future<List<Map>>? _searchResult;

  Future<List<Map>>? get searchResult => _searchResult;

  void setSearchResult(Future<List<Map>>? value) {
    _searchResult = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주간 달력'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
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
          selectedTextStyle: const TextStyle().copyWith(color: Colors.blue),
          selectedDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(100, 221, 221, 221),
          ),
          todayDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(100, 221, 221, 221),
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
            _selectedDay = selectedDay;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
      ),
    );
  }
}

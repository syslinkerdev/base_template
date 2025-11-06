import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalX extends StatefulWidget {
  final Function(DateTime selectedDay) onDaySelected;
  final DateTime firstDay;
  final DateTime? lastDay;
  const TableCalX(
      {super.key,
      required this.onDaySelected,
      required this.firstDay,
      this.lastDay});

  @override
  State<TableCalX> createState() => _TableCalXState();
}

class _TableCalXState extends State<TableCalX> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: widget.firstDay,
      lastDay: widget.lastDay ?? DFU.nextDay(),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDaySelected(selectedDay);
      },
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
              color: appColors.cS(context).surfaceTint, shape: BoxShape.circle),
          todayDecoration: const BoxDecoration(),
          todayTextStyle: TextStyle(color: appColors.ms.black80(context)),
          defaultDecoration: const BoxDecoration(),
          defaultTextStyle: TextStyle(color: appColors.ms.black80(context)),
          outsideDecoration: const BoxDecoration(),
          outsideTextStyle: TextStyle(
              color: appColors.ms.black80(context).withValues(alpha: 0.8)),
          weekendDecoration: const BoxDecoration(),
          weekendTextStyle: TextStyle(color: appColors.ms.black80(context)),
          disabledTextStyle: TextStyle(
              color: appColors.ms.black80(context).withValues(alpha: 0.4))),
    );
  }
}

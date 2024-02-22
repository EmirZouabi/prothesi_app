import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointementPage extends StatefulWidget {
  const AppointementPage({Key? key}) : super(key: key);

  @override
  State<AppointementPage> createState() => _AppointementPageState();
}

class _AppointementPageState extends State<AppointementPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  TextEditingController _eventDescriptionController = TextEditingController();

  Map<DateTime, List<String>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Event calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2024),
            lastDay: DateTime(2040),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showAddEventDialog(context);
            },
            child: Text('Add Event'),
          ),
          SizedBox(height: 20),
          if (_selectedDate != null && _events.containsKey(_selectedDate!))
            Column(
              children: _events[_selectedDate!]!
                  .asMap()
                  .entries
                  .map(
                    (entry) => ListTile(
                  title: Text(entry.value),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteEvent(entry.key);
                    },
                  ),
                ),
              )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Future<void> _showAddEventDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: TextField(
            controller: _eventDescriptionController,
            decoration: InputDecoration(labelText: 'Event Description'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addEvent();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent() {
    if (_selectedDate != null) {
      setState(() {
        final eventDescription = _eventDescriptionController.text;
        if (_events.containsKey(_selectedDate!)) {
          _events[_selectedDate!]!.add(eventDescription);
        } else {
          _events[_selectedDate!] = [eventDescription];
        }
        _eventDescriptionController.clear();
      });
    }
  }

  void _deleteEvent(int index) {
    if (_selectedDate != null) {
      setState(() {
        _events[_selectedDate!]!.removeAt(index);
      });
    }
  }
}

void main() {
  runApp(MaterialApp(home: AppointementPage()));
}

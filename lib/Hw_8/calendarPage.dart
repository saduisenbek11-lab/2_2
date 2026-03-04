import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarpage extends StatefulWidget {
  const Calendarpage({super.key});

  @override
  State<Calendarpage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<Calendarpage> {
  DateTime _selectedDay = DateTime.now();
  DateTime __focusedDay = DateTime.now();
  final Map<DateTime, List<String>> _events = {};
  List<String> _getEventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _events[key] ?? [];
  }

  void _addEvent() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Новые события"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Название события"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final key = DateTime(
                  _selectedDay.year,
                  _selectedDay.month,
                  _selectedDay.day,
                );
                setState(() {
                  _events.putIfAbsent(key, () => []);
                  _events[key]!.add(controller.text);
                });
              }
              Navigator.pop(context);
            },
            child: Text("Добавить"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDay);
    return Scaffold(
      appBar: AppBar(
        title: Text("Каледарь"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: _addEvent,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
            focusedDay: __focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                __focusedDay = focusedDay;
              });
            },

            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Выбранно: "
            "${_selectedDay.day}.${_selectedDay.month}.${_selectedDay.year}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          Expanded(
            child: events.isEmpty
                ? Center(child: Text("Событий нет "))
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (_, index) => Card(
                      child: ListTile(
                        leading: Icon(Icons.event),
                        title: Text(events[index]),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

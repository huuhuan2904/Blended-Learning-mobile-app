import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/userPreferences/current_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';

import '../../api_connection/api_connection.dart';

class Timetable extends StatefulWidget {
  const Timetable({super.key});

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  Map<DateTime, List<Map<String, String>>> events = {};
  final CalendarWeekController _controller = CalendarWeekController();
  DateTime? selectedDate;
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final response = await http.post(
      Uri.parse(API.timetable),
      body: {
        "studentId": _currentUser.user.id.toString(),
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      // sắp xếp mảng theo lesson_id
      data.sort((a, b) =>
          int.parse(a['lesson_id']).compareTo(int.parse(b['lesson_id'])));

      setState(() {
        for (var event in data) {
          DateTime startDate = DateTime.parse(event['start_date']);
          DateTime endDate = DateTime.parse(event['end_date']);
          int dayOfWeek = int.parse(event['day']);

          for (DateTime date = startDate;
              date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
              date = date.add(Duration(days: 1))) {
            //lấy từng ngày trong khoảng start đến end và lấy thứ của từng ngày đó so sánh với dayOfWeek
            if (date.weekday == dayOfWeek) {
              DateTime normalizedDate =
                  DateTime(date.year, date.month, date.day);
              if (events.containsKey(normalizedDate)) {
                events[normalizedDate]!.add({
                  'lesson_name': event['lesson_name'],
                  'start_time': event['start_time'],
                  'end_time': event['end_time'],
                  'teacher_name': event['teacher_name'],
                  'subject_name': event['subject_name'],
                  'status': event['status']
                });
              } else {
                events[normalizedDate] = [
                  {
                    'lesson_name': event['lesson_name'],
                    'start_time': event['start_time'],
                    'end_time': event['end_time'],
                    'teacher_name': event['teacher_name'],
                    'subject_name': event['subject_name'],
                    'status': event['status']
                  }
                ];
              }
            }
          }
        }

        //lấy tiết học hôm nay
        DateTime today = DateTime.now();
        DateTime normalizedToday = DateTime(today.year, today.month, today.day);
        if (events.containsKey(normalizedToday)) {
          selectedDate = normalizedToday;
        }
      });
      print(events);
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch học'),
        backgroundColor: const Color.fromARGB(255, 71, 96, 241),
      ),
      body: Column(
        children: [
          CalendarWeek(
            controller: _controller,
            height: 100,
            showMonth: true,
            minDate: DateTime.now().add(Duration(days: -365)),
            maxDate: DateTime.now().add(Duration(days: 365)),
            onDatePressed: (DateTime datetime) {
              DateTime normalizedDate =
                  DateTime(datetime.year, datetime.month, datetime.day);
              setState(() {
                selectedDate = normalizedDate;
              });
            },
            monthViewBuilder: (DateTime time) => Align(
              alignment: FractionalOffset.center,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMM().format(time),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            decorations: events.keys.map((date) {
              return DecorationItem(
                date: date,
                decoration: const Icon(
                  Icons.event,
                  color: Colors.red,
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: selectedDate == null || !events.containsKey(selectedDate)
                ? const Center(child: Text('Không có tiết học hôm nay'))
                : ListView(
                    children: events[selectedDate]!.map((event) {
                      DateTime startTime =
                          DateFormat("HH:mm:ss").parse(event['start_time']!);
                      String formattedStartTime =
                          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}'; //nếu k chỉnh thì 9:05 -> 9:5
                      DateTime endTime =
                          DateFormat("HH:mm:ss").parse(event['end_time']!);
                      String formattedEndTime =
                          '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
                      return Card(
                        child: ListTile(
                          leading: Text(event['lesson_name']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          title: Text('${event['lesson_name']} (GV. ${event['teacher_name']})',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.access_time_filled),
                              const SizedBox(width: 6),
                              Text('$formattedStartTime - $formattedEndTime'),
                            ],
                          ),
                          trailing: event['status'] == '0'
                              ? const Text('Trực tiếp',
                                  style: TextStyle(color: Colors.blue))
                              : const Text('Trực tuyến',
                                  style: TextStyle(color: Colors.green)),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Appointment {
  final String name;
  final String place;
  final DateTime bookingTime;

  Appointment(
      {required this.name, required this.place, required this.bookingTime});
}

class AppointmentSchedulePage extends StatefulWidget {
  const AppointmentSchedulePage({Key? key}) : super(key: key);

  @override
  _AppointmentSchedulePageState createState() =>
      _AppointmentSchedulePageState();
}

class _AppointmentSchedulePageState extends State<AppointmentSchedulePage> {
  final List<Appointment> appointments = [
    Appointment(
        name: 'Lượng Nguyễn',
        place: '717A Xô viết Nghệ Tĩnh, P.25, Bình Thạnh',
        bookingTime: DateTime.now()),
    Appointment(
        name: 'Việt Ngok',
        place: '29B Trần Đình Trọng, Phường 4, Quận 4',
        bookingTime: DateTime.now().add(Duration(days: 2))),
    Appointment(
        name: 'Huấn Hoa Hòe',
        place: '555 Điện Biên Phủ,P.26, Quận Bình Thạnh',
        bookingTime: DateTime.now().add(Duration(days: 4))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Upcoming Appointments',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  var listTile = ListTile(
                    isThreeLine: true,
                    title: Text(appointment.name),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(appointment.place),
                        Text(DateFormat('EEE, MMM d, h:mm a')
                            .format(appointment.bookingTime)),
                      ],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Appointment details for ${appointment.name}.')));
                    },
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm Acceptance'),
                              content: Text(
                                  'Do you want to accept the appointment for ${appointment.name}?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Appointment accepted.')));
                                  },
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Accept'),
                    ),
                  );
                  return Card(
                    child: listTile,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

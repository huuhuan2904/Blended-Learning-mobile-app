import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';
import '../userPreferences/current_user.dart';

class AppointmentSchedule extends StatefulWidget {
  const AppointmentSchedule({super.key});

  @override
  State<AppointmentSchedule> createState() => _AppointmentScheduleState();
}

Widget getStatus(String status) {
  if (status.toString() == '0') {
    return const Text('Chưa khám',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
  } else {
    return const Text('Đã khám',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
  }
}

Widget appointmentDetails(String name, String email, String specialty,
    String phone, String date, String time, String note) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        children: [
          const Text('Thông tin lịch khám',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          const SizedBox(height: 20),
          const Text(
            'Bác sĩ',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 400,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.purple)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Tên: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(name, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Số điện thoại: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(phone, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Email: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(email, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Khám: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(specialty, style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.purple)),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Ngày khám:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  date,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.purple)),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Giờ khám:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  time,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            width: 400,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.green)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ghi chú: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Wrap(
                      children: [
                        Text(note, style: const TextStyle(fontSize: 20))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _AppointmentScheduleState extends State<AppointmentSchedule> {
  Future getAppointment() async {
    var response = await http.get(Uri.parse(API.viewAppointment));
    return json.decode(response.body);
  }

  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Lịch khám',
        ),
        backgroundColor: const Color.fromARGB(255, 80, 213, 175),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getAppointment(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List appointmentList = snapshot.data
                  .where((element) => element['userEmail']
                      .toString()
                      .contains(_currentUser.user.email))
                  .toList();
              if (appointmentList.isEmpty) {
                return const Center(
                  child: Text(
                    'Không tìm thấy dữ liệu:(',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                    itemCount: appointmentList.length,
                    itemBuilder: (context, index) {
                      List list = appointmentList;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png'),
                              child: Text('')),
                          title: Text(
                            'BS. ${list[index]['doctorName']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Ngày khám: ${list[index]['appointmentDate']}'),
                              Text(
                                  'Giờ khám: ${list[index]['appointmentTime']}'),
                            ],
                          ),
                          trailing: getStatus(list[index]['status']),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  const Color.fromARGB(255, 244, 242, 242),
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.all(15),
                                  child: appointmentDetails(
                                      list[index]['doctorName'],
                                      list[index]['doctorEmail'],
                                      list[index]['doctorSpecialty'],
                                      list[index]['doctorPhone'],
                                      list[index]['appointmentDate'],
                                      list[index]['appointmentTime'],
                                      list[index]['note']),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

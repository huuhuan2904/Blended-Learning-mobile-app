import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../doctorPreferences/current_doctor.dart';

class BodyOverviewScreenD extends StatefulWidget {
  const BodyOverviewScreenD({super.key});

  @override
  State<BodyOverviewScreenD> createState() => _BodyOverviewScreenDState();
}

class _BodyOverviewScreenDState extends State<BodyOverviewScreenD> {
  Future getAppointment() async {
    var response = await http.get(Uri.parse(API.viewAppointment));
    return json.decode(response.body);
  }

  Widget appointmentDetails(String name, String email, String phone,
      String address, String date, String time, String note) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            const Text('Thông tin lịch khám',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 20),
            const Text(
              'Bệnh nhân',
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
                      Row(
                        children: [
                          const Text('Địa chỉ: ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Expanded(
                              child: Text(address,
                                  style: const TextStyle(fontSize: 20))),
                        ],
                      ),
                      const SizedBox(height: 5),
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

  Future<void> check(BuildContext context, String id) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Lưu ý", style: TextStyle(color: Colors.black)),
        content: const Text(
          "Bạn có chắc chắn người này đã đến khám?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              child: const Text(
                "Hủy",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await http.post(
                Uri.parse(API.editStatusAppointment),
                body: {
                  "id": id,
                  "status": '1',
                },
              );
              Navigator.of(ctx).pop();
            },
            child: Container(
              child: const Text(
                "Có",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CurrentDoctor _currentDoctor = Get.put(CurrentDoctor());
    bool status;
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Chào'),
                      Row(
                        children: [
                          Text(
                            _currentDoctor.doctor.doctorName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.waving_hand_sharp,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png'),
                    child: Text(''))
              ],
            ),
          ),
        ),
        const Text(
          'Danh sách lịch khám',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: FutureBuilder(
              future: getAppointment(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List appointmentList = snapshot.data
                      .where((element) => element['doctorEmail']
                          .toString()
                          .contains(_currentDoctor.doctor.email))
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
                          if (list[index]['status'] == '0') {
                            status = false;
                          } else {
                            status = true;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Card(
                              elevation: 5,
                              shadowColor: status ? Colors.green : Colors.red,
                              child: SwitchListTile(
                                  isThreeLine: true,
                                  title: Text(
                                    'Anh(chị): ${list[index]['userName']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  secondary: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: const Color.fromARGB(
                                            255, 244, 242, 242),
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: EdgeInsets.all(15),
                                            child: appointmentDetails(
                                                list[index]['userName'],
                                                list[index]['userEmail'],
                                                list[index]['userPhone'],
                                                list[index]['userAddress'],
                                                list[index]['appointmentDate'],
                                                list[index]['appointmentTime'],
                                                list[index]['note']),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  value: status,
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ngày khám: ${list[index]['appointmentDate']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Giờ khám: ${list[index]['appointmentTime']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  inactiveThumbColor: Colors.red,
                                  activeTrackColor: Colors.green[200],
                                  activeColor: Colors.green,
                                  inactiveTrackColor: Colors.red[200],
                                  activeThumbImage: const NetworkImage(
                                      'https://banner2.cleanpng.com/20180314/bse/kisspng-check-mark-tick-clip-art-green-tick-mark-5aa8e456cec986.968665711521017942847.jpg'),
                                  inactiveThumbImage: const NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5fQIkdrwnhcB5bkqZGamz8c06NWJEbn5iXg&usqp=CAU'),
                                  onChanged: (value) {
                                    check(context, list[index]['id']);
                                    setState(() {
                                      status = value;
                                    });
                                  }),
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
        ),
      ],
    );
  }
}

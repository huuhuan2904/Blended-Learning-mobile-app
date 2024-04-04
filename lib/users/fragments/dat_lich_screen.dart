import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/dat_lich_details_screen.dart';
import 'package:flutter_application_1/users/fragments/doctor_details.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';

class DatLichScreen extends StatefulWidget {
  const DatLichScreen({super.key});

  @override
  State<DatLichScreen> createState() => _DatLichScreenState();
}

class _DatLichScreenState extends State<DatLichScreen> {
  Future getDoctorList() async {
    var response = await http.get(Uri.parse(API.doctorList));
    return json.decode(response.body);
  }

  final TextEditingController _searchController = TextEditingController();
  String _search = '';
  void _onSearchChanged(String value) {
    setState(() {
      _search = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ĐẶT LỊCH',
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 80, 213, 175),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 80, 213, 175),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 20, top: 20),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  iconColor: const Color.fromARGB(255, 80, 213, 175),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 80, 213, 175))),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Tên chuyên khoa ',
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getDoctorList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    final List searchDoctors = snapshot.data
                        .where((element) => element['specialty']
                            .toString()
                            .toLowerCase()
                            .contains(_search.toLowerCase()))
                        .toList();
                    if (searchDoctors.isEmpty) {
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
                          itemCount: searchDoctors.length,
                          itemBuilder: (context, index) {
                            List list = searchDoctors;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 80, 213, 175),
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png'),
                                    child: Text('')),
                                title: Text(
                                  'BS. ${list[index]['doctorName']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    'Chuyên khoa: ${list[index]['specialty']}'),
                                trailing: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 80, 213, 175)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DatLichDetailsScreen(
                                                    list[index]['doctorName'],
                                                    list[index]['email'],
                                                    list[index]['specialty'],
                                                    list[index]['phoneNum'],
                                                    list[index]['price'],
                                                  )));
                                    },
                                    child: const Text(
                                      'Đặt lịch',
                                      style: TextStyle(fontSize: 18),
                                    )),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: const Color.fromARGB(
                                          255, 244, 242, 242),
                                      builder: (_) {
                                        return DoctorDetails(
                                            list[index]['doctorName'],
                                            list[index]['expNum'],
                                            list[index]['specialty'],
                                            list[index]['gender'],
                                            list[index]['phoneNum'],
                                            list[index]['price']);
                                      });
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
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/users/fragments/hoan_tat_dat_lich_screen.dart';

import '../userPreferences/current_user.dart';

class DatLichDetailsScreen extends StatefulWidget {
  final String doctorName;
  final String doctorEmail;
  final String specialty;
  final String phoneNum;
  final String price;
  DatLichDetailsScreen(this.doctorName, this.doctorEmail, this.specialty,
      this.phoneNum, this.price);

  @override
  State<DatLichDetailsScreen> createState() => _DatLichDetailsState();
}

class _DatLichDetailsState extends State<DatLichDetailsScreen> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String _currentAddress = '';

  void _presentDataPicker() {
    showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color.fromARGB(255, 80, 213,
                        175), // header background color// body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 7)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color.fromARGB(255, 80, 213,
                        175), // header background color// body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialTime: TimeOfDay.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedTime = value;
      });
    });
  }

  appointment() async {
    await http.post(
      Uri.parse(API.appointment),
      body: {
        'userName': _currentUser.user.userName,
        'userEmail': _currentUser.user.email,
        'userPhone': _currentUser.user.phoneNum,
        'userAddress': userAddressController.text,
        'doctorName': widget.doctorName,
        'doctorEmail': widget.doctorEmail,
        'doctorSpecialty': widget.specialty,
        'doctorPhone': widget.phoneNum,
        'appointmentDate':
            DateFormat('dd/MM/yyyy').format(_selectedDate).toString(),
        'appointmentTime': _selectedTime.format(context).toString(),
        'status': '0',
        'note': noteController.text,
      },
    );
  }

  @override
  void initState() {
    userAddressController.text = _currentUser.user.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Thời gian khám'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 80, 213, 175),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, right: 15, bottom: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Text(
            //       'Ngày khám: ${DateFormat.yMd().format(_selectedDate)}',
            //       style: const TextStyle(fontSize: 27),
            //     ),
            //     Container(
            //       color: Colors.green,
            //       child: IconButton(
            //           onPressed: _presentDataPicker,
            //           icon: const Icon(Icons.edit)),
            //     )
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(
                        text: DateFormat('dd/MM/yyyy')
                            .format(_selectedDate)
                            .toString()),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.edit_calendar_rounded),
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                ),
                IconButton(
                    onPressed: _presentDataPicker,
                    icon: const Icon(Icons.edit)),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: TextEditingController(
                        text: _selectedTime.format(context).toString()),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.watch_later),
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                ),
                IconButton(
                    onPressed: _presentTimePicker,
                    icon: const Icon(Icons.edit)),
              ],
            ),
            // Text(
            //   'Giờ khám: ${_selectedTime.format(context).toString()}',
            //   style: const TextStyle(fontSize: 27),
            // ),
            // TextButton(
            //     onPressed: _presentTimePicker,
            //     child: const Text(
            //       'Chọn giờ khám',
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 25,
            //           color: Color.fromARGB(255, 37, 183, 141)),
            //     )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: userAddressController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
                hintText: 'Địa chỉ',
              ),
              validator: (val) =>
                  val!.isEmpty ? 'Vui lòng điền thông tin' : null,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: noteController,
              minLines: 7,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                labelText: 'Ghi chú...',
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 180,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 37, 183, 141)),
                        backgroundColor:
                            const Color.fromARGB(255, 37, 183, 141),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HoanTatDatLichScreen(
                              widget.doctorName,
                              widget.phoneNum,
                              _selectedDate,
                              _selectedTime,
                              widget.price)));
                      appointment();
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

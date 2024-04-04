import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/appointment_schedule.dart';
import 'package:flutter_application_1/users/fragments/overview_app_screen.dart';
import 'package:intl/intl.dart';

class HoanTatDatLichScreen extends StatefulWidget {
  final String doctorName;
  final String doctorPhone;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String price;
  HoanTatDatLichScreen(this.doctorName, this.doctorPhone, this.selectedDate,
      this.selectedTime, this.price);

  @override
  State<HoanTatDatLichScreen> createState() => _HoanTatDatLichScreenState();
}

Widget _buildListTile(Icon leading, String title, String trailing) {
  return ListTile(
    leading: leading,
    title: Text(title),
    trailing:
        Text(trailing, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

class _HoanTatDatLichScreenState extends State<HoanTatDatLichScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Icon(
            Icons.check_circle,
            size: 200,
            color: Colors.green,
          ),
          const Text(
            'Đặt lịch thành công',
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildListTile(
                        const Icon(
                          Icons.person,
                        ),
                        'Bác sĩ',
                        widget.doctorName),
                    _buildListTile(const Icon(Icons.phone), 'Số điện thoại',
                        widget.doctorPhone),
                    _buildListTile(
                        const Icon(Icons.calendar_today),
                        'Ngày khám',
                        DateFormat('dd/MM/yyyy')
                            .format(widget.selectedDate)
                            .toString()),
                    _buildListTile(const Icon(Icons.watch_later), 'Giờ khám',
                        widget.selectedTime.format(context).toString()),
                    _buildListTile(const Icon(Icons.wallet), 'Giá tiền',
                        '${widget.price} VND'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 201, 242, 202),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (contex) => OverViewAppScreen()));
                  },
                  child: const Text(
                    'Về trang chủ',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AppointmentSchedule()));
                  },
                  child: const Text(
                    'Xem lịch hẹn',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

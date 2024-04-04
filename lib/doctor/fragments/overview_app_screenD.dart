import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/doctorPreferences/current_doctor.dart';
import 'package:flutter_application_1/doctor/fragments/profile_doctor.dart';
import 'package:get/get.dart';
import '../../users/quanlydangnhap/login_screen.dart';
import '../doctorPreferences/doctor_preferences.dart';
import 'body_overview_screen.dart';

class OverViewAppScreenD extends StatelessWidget {
  final CurrentDoctor _currentDoctor = Get.put(CurrentDoctor());
  final CurrentDoctor _rememberCurrentDoctor = Get.put(CurrentDoctor());
  Widget buildBodyDrawerD(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  signOutDoctor() async {
    var resultRespone = await Get.dialog(AlertDialog(
      title: const Text(
        "Đăng xuất",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      content: const Text("Bạn chắc chắn muốn đăng xuất?"),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Hủy",
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        TextButton(
            onPressed: () {
              Get.back(result: "LoggedOut");
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.black,
              ),
            ))
      ],
    ));
    if (resultRespone == "LoggedOut") {
      // remove the userdata from phone local storage
      RememberDoctorPrefs.removeDoctorInfo().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentDoctor(),
        initState: (currentState) {
          _rememberCurrentDoctor.getDoctorInfo();
        },
        builder: (CurrentDoctor controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Trang chủ'),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    height: 250,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 60,
                            backgroundImage: NetworkImage(
                                'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png'),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 17.0,
                                  color: Color(0xFF404040),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          _currentDoctor.doctor.doctorName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(_currentDoctor.doctor.email,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                      title: const Text(
                        'Hồ sơ cá nhân',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileDoctor()))),
                  const Divider(),
                  buildBodyDrawerD(Icons.settings_outlined, 'Cài đặt'),
                  const Divider(),
                  buildBodyDrawerD(Icons.delete_outline, 'Xóa tài khoản'),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      size: 40,
                    ),
                    title: const Text(
                      'Đăng xuất',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => signOutDoctor(),
                  ),
                ],
              ),
            ),
            body: BodyOverviewScreenD(),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Trang chủ'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today), label: 'Lịch khám'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications), label: 'Thông báo'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Cài đặt'),
                ]),
          );
        });
  }
}

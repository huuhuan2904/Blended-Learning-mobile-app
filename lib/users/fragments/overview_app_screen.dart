import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/profile_fragment_screen.dart';
import 'package:flutter_application_1/users/quanlydangnhap/login_screen.dart';
import 'package:flutter_application_1/users/userPreferences/current_user.dart';
import 'package:flutter_application_1/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';
import 'body_overview_screen.dart';

class OverViewAppScreen extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreens = [
    BodyOverviewScreen(),
    BodyOverviewScreen(),
    BodyOverviewScreen(),
    BodyOverviewScreen(),
  ];

  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Trang chủ",
    },
    {
      "active_icon": Icons.calendar_today,
      "non_active_icon": Icons.calendar_today_outlined,
      "label": "Lịch khám",
    },
    {
      "active_icon": Icons.notifications,
      "non_active_icon": Icons.notifications_outlined,
      "label": "Thông báo",
    },
    {
      "active_icon": Icons.settings,
      "non_active_icon": Icons.settings_outlined,
      "label": "Cài đặt",
    },
  ];
  final RxInt _indexNumber = 0.obs;

  signOutUser() async {
    var resultRespone = await Get.dialog(AlertDialog(
      title: const Text(
        "Đăng xuất",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      content: const Text("Đăng xuất để lưu thay đổi"),
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
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  Widget buildBodyDrawer(IconData icon, String title) {
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (CurrentUser controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 71, 96, 241),
            title: const Text('Trang chủ'),
            // actions: <Widget>[
            //   IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            // ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  height: 240,
                  padding: const EdgeInsets.only(top: 50),
                  color: const Color.fromARGB(255, 71, 96, 241),
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                              _currentUser.user.gender == 'Nam'
                                  ? 'images/avatar_male.webp'
                                  : 'images/avatar_female.webp'),
                          child: const Align(
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
                        _currentUser.user.lastName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(_currentUser.user.firstName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Profilefragmentsscreen())),
                ),
                const Divider(),
                buildBodyDrawer(Icons.settings_outlined, 'Cài đặt'),
                const Divider(),
                buildBodyDrawer(Icons.delete_outline, 'Xóa tài khoản'),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    size: 40,
                  ),
                  title: const Text(
                    'Đăng xuất',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => signOutUser(),
                ),
              ],
            ),
          ),

          body: SafeArea(
            child: Obx(() => _fragmentScreens[_indexNumber.value]),
          ),

          // body:  BodyOverviewScreen(),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: const Color.fromARGB(255, 71, 96, 241),
              unselectedItemColor: Colors.black,
              items: List.generate(4, (index) {
                var navBtnProperty = _navigationButtonProperties[index];
                return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"]);
              }),
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //     type: BottomNavigationBarType.fixed,
          //     items: const [
          //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.calendar_today), label: 'Lịch khám'),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.notifications), label: 'Thông báo'),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.settings), label: 'Cài đặt'

          //           ),
          //     ]),
        );
      },
    );
  }
}

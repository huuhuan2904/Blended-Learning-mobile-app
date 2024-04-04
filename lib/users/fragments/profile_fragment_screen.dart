import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/share/styleTextFormField.dart';
import 'package:flutter_application_1/users/userPreferences/current_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../quanlydangnhap/login_screen.dart';
import '../userPreferences/user_preferences.dart';

class Profilefragmentsscreen extends StatefulWidget {
  @override
  State<Profilefragmentsscreen> createState() => _ProfilefragmentsscreenState();
}

class _ProfilefragmentsscreenState extends State<Profilefragmentsscreen> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? name;
  String? email;
  String? phone;

  EditData() async {
    var response = await http.post(
      Uri.parse(API.editProfile),
      body: {
        "ID": _currentUser.user.id.toString(),
        "userName": nameController.text,
        "Email": emailController.text,
        "PhoneNum": phoneController.text,
        "address": addressController.text,
      },
    );
    print(response.body);
  }

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

  @override
  void initState() {
    nameController.text = _currentUser.user.userName;
    emailController.text = _currentUser.user.email;
    phoneController.text = _currentUser.user.phoneNum;
    addressController.text = _currentUser.user.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: const Color.fromARGB(255, 53, 192, 153),
      ),
      body: Center(
          child: ListView(
        children: [
          const Center(
              child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(
                'https://img6.thuthuatphanmem.vn/uploads/2022/11/18/anh-avatar-don-gian-cho-nu_081757692.jpg'),
          )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Họ tên',
                          prefixIcon: const Icon(Icons.person)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Số điện thoại',
                          prefixIcon: const Icon(Icons.phone)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {
                          phone = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Địa chỉ',
                          prefixIcon: const Icon(Icons.home)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 53, 192, 153)),
                        onPressed: () {
                          print(_currentUser.user.id);
                          if (_formKey.currentState!.validate()) {
                            EditData();
                            signOutUser();
                          }
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Text(
                            'Lưu',
                            style: TextStyle(fontSize: 25),
                          ),
                        ))
                  ],
                )),
          )
        ],
      )),
    );
  }
}

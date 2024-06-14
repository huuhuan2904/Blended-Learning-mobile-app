import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../api_connection/api_connection.dart';
import '../../share/styleTextFormField.dart';
import 'package:http/http.dart' as http;

import '../userPreferences/current_user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? oldPassword;
  String? confirmOldPassword;
  String? newPassword;
  final _formKey = GlobalKey<FormState>();
  final CurrentUser _currentUser = Get.put(CurrentUser());
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  EditData() async {
    var response = await http.post(
      Uri.parse(API.editProfile),
      body: {
        "id": _currentUser.user.id.toString(),
        "oldPassword": confirmOldPassword,
        "newPassword": newPasswordController.text,
      },
    );
    if (response.statusCode == 200) {
      var resBodyOfLogin = response.body;
      if (resBodyOfLogin == '1') {
        Fluttertoast.showToast(msg: "Thay đổi thành công");
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.of(context).pop();
        });
      } else {
        Fluttertoast.showToast(msg: "Mật khẩu không chính xác");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
        backgroundColor: const Color.fromARGB(255, 71, 96, 241),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: oldPasswordController,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Mật khẩu cũ',
                        labelText: "Mật khẩu cũ",
                        prefixIcon: const Icon(Icons.lock)),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Vui lòng không để trống' : null,
                    onChanged: (val) {
                      setState(() {
                        oldPassword = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Xác nhận mật khẩu cũ',
                        labelText: "Xác nhận mật khẩu",
                        prefixIcon: const Icon(Icons.lock)),
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Vui lòng không để trống';
                      } else if (val != oldPassword) {
                        return 'Mật khẩu cũ không khớp';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        confirmOldPassword = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Mật khẩu mới',
                        labelText: "Mật khẩu mới",
                        prefixIcon: const Icon(Icons.lock)),
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Vui lòng không để trống';
                      } else if (val.length <= 6) {
                        return 'Mật khẩu phải hơn 6 ký tự';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        newPassword = val;
                      });
                    },
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 71, 96, 241)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          EditData();
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

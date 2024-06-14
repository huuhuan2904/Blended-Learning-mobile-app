import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/share/styleTextFormField.dart';
import 'package:flutter_application_1/users/fragments/edit_profile.dart';
import 'package:flutter_application_1/users/userPreferences/current_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Profilefragmentsscreen extends StatefulWidget {
  @override
  State<Profilefragmentsscreen> createState() => _ProfilefragmentsscreenState();
}

class _ProfilefragmentsscreenState extends State<Profilefragmentsscreen> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? resetPassword;
  bool isReadOnly = true;

  // EditData() async {
  //   var response = await http.post(
  //     Uri.parse(API.editProfile),
  //     body: {
  //       "ID": _currentUser.user.id.toString(),
  //       "userName": nameController.text,
  //       "Email": emailController.text,
  //       "PhoneNum": phoneController.text,
  //       "address": addressController.text,
  //     },
  //   );
  //   print(response.body);
  // }

  @override
  void initState() {
    nameController.text =
        _currentUser.user.lastName + _currentUser.user.firstName;
    dobController.text = _currentUser.user.dob;
    genderController.text = _currentUser.user.gender;
    addressController.text = _currentUser.user.address;
    phoneController.text = _currentUser.user.phone;
    nationController.text = _currentUser.user.nation;
    emailController.text = _currentUser.user.email;
    passwordController.text = _currentUser.user.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: Color.fromARGB(255, 71, 96, 241),
      ),
      body: Center(
          child: ListView(
        children: [
          Center(
              child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(genderController.text == 'Nam'
                ? 'images/avatar_male.webp'
                : 'images/avatar_female.webp'),
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
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: dobController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Sinh ngày',
                          prefixIcon: const Icon(Icons.cake)),
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: genderController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Giới tính',
                          prefixIcon: Icon(genderController.text == 'Nam'
                              ? Icons.male
                              : Icons.female)),
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {});
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
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Mật khẩu',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                isReadOnly = !isReadOnly;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                              });
                            },
                          )),
                      obscureText: true,
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {
                          resetPassword = val;
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
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                      onChanged: (val) {
                        setState(() {});
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
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: nationController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Dân tộc',
                          prefixIcon: const Icon(Icons.place)),
                      readOnly: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor:
                    //             const Color.fromARGB(255, 126, 144, 245)),
                    //     onPressed: () {
                    //       print(_currentUser.user.id);
                    //       if (_formKey.currentState!.validate()) {
                    //         // EditData();
                    //       }
                    //     },
                    //     child: const Padding(
                    //       padding:
                    //           EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    //       child: Text(
                    //         'Lưu',
                    //         style: TextStyle(fontSize: 25),
                    //       ),
                    //     ))
                  ],
                )),
          )
        ],
      )),
    );
  }
}

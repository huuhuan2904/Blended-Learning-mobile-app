import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/overview_app_screen.dart';
import 'package:flutter_application_1/users/model/user.dart';
import 'package:flutter_application_1/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../api_connection/api_connection.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var accountController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "Email": accountController.text.trim(),
          "Password": passwordController.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "Đăng nhập thành công");
          setState(() {
            accountController.clear();
            passwordController.clear();
          });

          User userInfo = User.fromJson(resBodyOfLogin["studentData"]);

          //Save user info to local storage using Shared Preferences
          await RememberUserPrefs.storeUserInfo(userInfo);

          Future.delayed(const Duration(milliseconds: 2000), () {
            Get.to(OverViewAppScreen());
          });
        } else {
          Fluttertoast.showToast(
              msg:
                  "Tài khoản hoặc mật khẩu không chính xác.\n Vui lòng thử lại!");
        }
      }
    } catch (errorMsg) {
      print("Error ::" + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //login screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 320,
                    child: Image.asset(
                      "images/eduLogoNoName.png",
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 126, 144, 245),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, -3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                            child: Column(
                              children: [
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: accountController,
                                        validator: (val) => val == ""
                                            ? "Vui lòng điền tài khoản"
                                            : null,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.black,
                                          ),
                                          hintText: "Email....",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white60,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 18,
                                      ),

                                      //password
                                      Obx(
                                        () => TextFormField(
                                          controller: passwordController,
                                          obscureText: isObsecure.value,
                                          validator: (val) => val == ""
                                              ? "Vui lòng điền mật khẩu"
                                              : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.key,
                                              color: Colors.black,
                                            ),
                                            suffixIcon:
                                                Obx(() => GestureDetector(
                                                      onTap: () {
                                                        isObsecure.value =
                                                            !isObsecure.value;
                                                      },
                                                      child: Icon(
                                                        isObsecure.value
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                            hintText: "Mật khẩu....",
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 6,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 40,
                                      ),

                                      Material(
                                        color: const Color.fromARGB(
                                            255, 38, 66, 194),
                                        child: InkWell(
                                          onTap: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              loginUserNow();
                                            }
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal: 40,
                                            ),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text.rich(
                    TextSpan(
                      text: 'Đăng nhập không được? ',
                      style: TextStyle(fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Xem hướng dẫn tại đây',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        // can add more TextSpans here...
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

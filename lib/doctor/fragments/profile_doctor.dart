import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../../api_connection/api_connection.dart';
import '../../share/styleTextFormField.dart';
import '../../users/quanlydangnhap/login_screen.dart';
import '../doctorPreferences/current_doctor.dart';
import 'package:http/http.dart' as http;

import '../doctorPreferences/doctor_preferences.dart';

class ProfileDoctor extends StatefulWidget {
  const ProfileDoctor({super.key});

  @override
  State<ProfileDoctor> createState() => _ProfileDoctorState();
}

class _ProfileDoctorState extends State<ProfileDoctor> {
  final CurrentDoctor _currentDoctor = Get.put(CurrentDoctor());
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  var priceController =
      MoneyMaskedTextController(precision: 3, decimalSeparator: '.');
  String? _currentGender;
  String? _currentExp;
  List<String> genders = [
    "Nam",
    "Nu",
    "Khac",
  ];
  List<String> yearsOfExp = [
    "Duoi 1 nam",
    "Tren 1 nam",
    "Tren 2 nam",
    "Tren 3 nam",
    "Tren 4 nam",
    "Tren 5 nam",
  ];

  EditData() async {
    var response = await http.post(
      Uri.parse(API.editProfileDoctor),
      body: {
        "ID": _currentDoctor.doctor.id.toString(),
        "doctorName": nameController.text,
        "email": emailController.text,
        "phoneNum": phoneController.text,
        "expNum": _currentExp,
        "specialty": specialtyController.text,
        "gender": _currentGender,
        "price": priceController.text,
      },
    );
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
      RememberDoctorPrefs.removeDoctorInfo().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  @override
  void initState() {
    nameController.text = _currentDoctor.doctor.doctorName;
    emailController.text = _currentDoctor.doctor.email;
    phoneController.text = _currentDoctor.doctor.phoneNum;
    specialtyController.text = _currentDoctor.doctor.specialty;
    priceController.text = _currentDoctor.doctor.price;
    _currentGender = _currentDoctor.doctor.gender;
    _currentExp = _currentDoctor.doctor.expNum;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
      ),
      body: Center(
          child: ListView(
        children: [
          const Center(
              child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(
                'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png'),
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      value: _currentGender,
                      decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.transgender),
                          label: const Text('Giới tính')),
                      items: genders.map((itemone) {
                        return DropdownMenuItem(
                          value: itemone,
                          child: Text(itemone),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentGender = val!),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: specialtyController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Chuyên khoa',
                          prefixIcon: const Icon(Icons.work)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      value: _currentExp!.isNotEmpty ? _currentExp : null,
                      decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.pending_actions),
                          label: const Text('Số kinh nghiệm')),
                      items: yearsOfExp.map((itemone) {
                        return DropdownMenuItem(
                          value: itemone,
                          child: Text(itemone),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentExp = val!),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      decoration: textInputDecoration.copyWith(
                          suffixText: 'VND',
                          hintText: 'Giá khám',
                          prefixIcon: const Icon(Icons.payment)),
                      validator: (value) =>
                          value!.isEmpty ? 'Vui lòng không để trống' : null,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
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

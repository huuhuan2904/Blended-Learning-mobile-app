import 'dart:convert';
import 'package:flutter_application_1/doctor/modelDoctor/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberDoctorPrefs {
  static Future<void> storeDoctorInfo(Doctor doctorInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String doctorJsonData = jsonEncode(doctorInfo.toJson());
    await preferences.setString("currentDoctor", doctorJsonData);
  }

  //get-read user infor
  static Future<Doctor?> readDoctorInfo() async {
    Doctor? currentDoctorInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? doctorInfor = preferences.getString("currentDoctor");
    if (doctorInfor != null) {
      Map<String, dynamic> doctorrDataMap = jsonDecode(doctorInfor);
      currentDoctorInfo = Doctor.fromJson(doctorrDataMap);
    }
    return currentDoctorInfo;
  }

  //logout
  static Future<void> removeDoctorInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentDoctor");
  }
}

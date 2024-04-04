import 'package:flutter_application_1/doctor/doctorPreferences/doctor_preferences.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../modelDoctor/doctor.dart';

class CurrentDoctor extends GetxController {
  final Rx<Doctor> _currentDoctor =
      Doctor(0, '', '', '', '', '', '', '', '', '').obs;
  Doctor get doctor => _currentDoctor.value;

  getDoctorInfo() async {
    Doctor? getDoctorInfoFromLocalStorage =
        await RememberDoctorPrefs.readDoctorInfo();
    _currentDoctor.value = getDoctorInfoFromLocalStorage!;
  }
}

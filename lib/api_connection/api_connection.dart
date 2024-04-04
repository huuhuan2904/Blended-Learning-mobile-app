class API {
  static const hostConnect = "http://192.168.0.106/api_doctorship";
  static const hostConnectUser = "$hostConnect/user";

  //user
  static const validateuserName = "$hostConnect/user/validate_name.php";
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
  static const editProfile = "$hostConnect/user/edit_profile.php";
  static const doctorList = "$hostConnect/user/viewDoctor.php";
  static const appointment = "$hostConnect/user/appointment.php";
  static const viewAppointment = "$hostConnect/user/viewAppointment.php";
  //doctor
  static const logind = "$hostConnect/doctor/logind.php";
  static const validateDoctorName = "$hostConnect/doctor/validate_name.php";
  static const signUpDoctor = "$hostConnect/doctor/signupDoctor.php";
  static const editProfileDoctor = "$hostConnect/doctor/edit_profileDoctor.php";
  static const editStatusAppointment =
      "$hostConnect/doctor/edit_status_appointment.php";
}

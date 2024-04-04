import 'dart:convert';

import 'package:flutter_application_1/users/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs{
  //save-remember user infor
  static Future<void> storeUserInfo(User userInfo) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }
  //get-read user infor 
  static Future<User?> readUserInfo() async{
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfor = preferences.getString("currentUser");
    if(userInfor != null){
      Map<String, dynamic> userDataMap = jsonDecode(userInfor);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }
  //logout
  static Future<void> removeUserInfo() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
class User {
  int id;
  String userName;
  String useraccount;
  String userpassword;
  String phoneNum;
  String email;
  String address;
  User(
    this.id,
    this.userName,
    this.useraccount,
    this.userpassword,
    this.phoneNum,
    this.email,
    this.address,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json["ID"]),
        json["userName"],
        json["Useraccount"],
        json["Userpassword"],
        json["PhoneNum"],
        json["Email"],
        json["address"],
      );

  Map<String, dynamic> toJson() => {
        'ID': id.toString(),
        'userName': userName,
        'Useraccount': useraccount,
        'Userpassword': userpassword,
        'PhoneNum': phoneNum,
        'Email': email,
        'address': address,
      };
}

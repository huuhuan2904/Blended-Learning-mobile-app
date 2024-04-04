class Doctor {
  int id;
  String doctorName;
  String doctoraccount;
  String doctorpassword;
  String phoneNum;
  String email;
  String gender;
  String expNum;
  String specialty;
  String price;
  Doctor(
      this.id,
      this.doctorName,
      this.doctoraccount,
      this.doctorpassword,
      this.phoneNum,
      this.email,
      this.gender,
      this.expNum,
      this.specialty,
      this.price);

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        int.parse(json["ID"]),
        json["doctorName"],
        json["userAcount"],
        json["userPassword"],
        json["phoneNum"],
        json["email"],
        json["gender"],
        json["expNum"],
        json["specialty"],
        json["price"],
      );

  Map<String, dynamic> toJson() => {
        'ID': id.toString(),
        'doctorName': doctorName,
        'userAcount': doctoraccount,
        'userPassword': doctorpassword,
        'phoneNum': phoneNum,
        'email': email,
        'gender': gender,
        'expNum': expNum,
        'specialty': specialty,
        'price': price,
      };
}

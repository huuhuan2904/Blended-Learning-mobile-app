class User {
  int id;
  String lastName;
  String firstName;
  String dob;
  String gender;
  String address;
  String phone;
  String nation;
  String email;
  String password;
  User(this.id, this.lastName, this.firstName, this.dob, this.gender,
      this.address, this.phone, this.nation, this.email, this.password);

  factory User.fromJson(Map<String, dynamic> json) => User(
      int.parse(json["id"]),
      json["last_name"],
      json["first_name"],
      json["dob"],
      json["gender"],
      json["address"],
      json["phone"],
      json["nation"],
      json["email"],
      json["password"]);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'last_name': lastName,
        'first_name': firstName,
        'dob': dob,
        'gender': gender,
        'address': address,
        'phone': phone,
        'nation': nation,
        'email': email,
        'password': password
      };
}

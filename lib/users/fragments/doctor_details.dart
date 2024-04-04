import 'package:flutter/material.dart';

class DoctorDetails extends StatefulWidget {
  final String name;
  final String expNum;
  final String specialty;
  final String gender;
  final String phone;
  final String price;
  DoctorDetails(this.name, this.expNum, this.specialty, this.gender, this.phone,
      this.price);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

Widget _buildExpDoctor(String title, IconData icon) {
  return ListTile(
    leading: Icon(
      icon,
      color: const Color.fromARGB(255, 80, 213, 175),
    ),
    title: Text(title),
  );
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://www.nicepng.com/png/detail/867-8678512_doctor-icon-physician.png'),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 40, 185, 144),
                      )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text('Bs ${widget.name} (${widget.gender})',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ),
                      Text(widget.specialty,
                          style: const TextStyle(fontSize: 17)),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 17, right: 17, top: 7),
                        child: Text(
                          'Bác sĩ ${widget.name} có nhiều năm kinh nghiệm hoạt động trong lĩnh vực thăm khám và điều trị các bệnh lý tim mạch. Ngoài việc khám – chữa bệnh thì bác sĩ còn tham gia nghiên cứu khoa học với hơn 265 đề tài, tất cả đã được công bố trên tạp chí khoa học trong và ngoài nước.',
                          style: const TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Liên hệ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(widget.phone)
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Kinh nghiệm:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Text('${widget.expNum} năm'),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Giá khám:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    Text('${widget.price} VND'),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.work,
                              color: Color.fromARGB(255, 34, 192, 147),
                            ),
                            Text(
                              '  Kinh nghiệm',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 34, 192, 147),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Giảng viên chính - Trưởng Bộ môn Xương khớp - Đại học Y Dược Huế',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Trưởng phòng khám Sức khỏe tim mạch - Bệnh viện trường đại học Y Dược Huế',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Phó trưởng phòng khám Sức khỏe tim mạch - Bệnh viện Trung Ương Huế',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          '2005: Chứng chỉ đào tạo chuyên môn Xương khớp tại Sydney, Australia',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.cast_for_education,
                              color: Color.fromARGB(255, 34, 192, 147),
                            ),
                            Text(
                              '  Học vấn',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 34, 192, 147),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Giảng viên chính - Trưởng Bộ môn Xương khớp - Đại học Y Dược Huế',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Trưởng phòng khám Sức khỏe tim mạch - Bệnh viện trường đại học Y Dược Huế',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Phó trưởng phòng khám Sức khỏe tim mạch - Bệnh viện Trung Ương Huế',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          '2005: Chứng chỉ đào tạo chuyên môn Xương khớp tại Sydney, Australia',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

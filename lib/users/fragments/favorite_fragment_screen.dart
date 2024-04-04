// import 'package:flutter/material.dart';

// class Favoritesfragmentsscreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: Center(
//         child: Text(
//           "Lich kham trong "
//         )
//         ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'doctor_details.dart';

class Favoritesfragmentsscreen extends StatefulWidget {
  // final DateTime timechosen;

  // LichKhamScreen(this.timechosen);

  @override
  State<Favoritesfragmentsscreen> createState() => _LichKhamScreenState();
}

class _LichKhamScreenState extends State<Favoritesfragmentsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            color: Color.fromARGB(255, 139, 198, 141),
            height: 300,
            width: double.infinity,
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Ngày: 22/05/2023',
                  style: Theme.of(context).textTheme.headline6,
                )),
                Card(
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.person),
                          Text('Phạm Hòn Việt  (84+)0123456789')
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.place),
                          Expanded(
                            child: Text(
                                '35 Nguyễn Đình Chiêu, Lê Đại Hành, Hai Bà Trưng, Hà Nội'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        isThreeLine: true,
                        leading: const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://cdn.cpdonline.co.uk/wp-content/uploads/2021/07/28125941/Doctors-CPD-couses.png'),
                            child: Text('')),
                        title: const Text(
                          'BS. Nguyễn Văn A',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Chuyên khoa: tim mạch, xương khớp'),
                            Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: Row(
                                    children: const [
                                      Icon(
                                        Icons.work_outlined,
                                        color: Colors.green,
                                      ),
                                      Text(' 3 năm  '),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(' 5.0')
                                    ],
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     ElevatedButton.icon(
                      //         style: ElevatedButton.styleFrom(
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(50)),
                      //             minimumSize: Size(150, 45)),
                      //         onPressed: () {
                      //           showModalBottomSheet(
                      //               context: context,
                      //               backgroundColor: const Color.fromARGB(
                      //                   255, 244, 242, 242),
                      //               builder: (_) {
                      //                 return DoctorDetails();
                      //               });
                      //         },
                      //         icon: const Icon(Icons.search),
                      //         label: const Text(
                      //           'Chi tiết',
                      //           style: TextStyle(fontSize: 18),
                      //         )),
                      //     const SizedBox(
                      //       width: 33,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

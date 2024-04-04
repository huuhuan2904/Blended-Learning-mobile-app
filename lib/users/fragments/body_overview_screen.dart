import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/dat_lich_screen.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../userPreferences/current_user.dart';
import 'appointment_schedule.dart';

class BodyOverviewScreen extends StatefulWidget {
  const BodyOverviewScreen({super.key});

  @override
  State<BodyOverviewScreen> createState() => _BodyOverviewScreenState();
}

class _BodyOverviewScreenState extends State<BodyOverviewScreen> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
//test
  Widget getData(String userData) {
    return Row(
      children: [
        Text(
          '${userData} ',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.waving_hand_sharp,
          color: Colors.yellow,
        ),
      ],
    );
  }

//test
  Widget buildServiceGridview(BuildContext context, String title, IconData icon,
      Function() tapHandler) {
    return InkWell(
      onTap: tapHandler,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 200, 239, 229),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: Color.fromARGB(255, 23, 144, 110),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 23, 144, 110),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex = 0;
  final List<String> imagesList = [
    'images/ad3.png',
    'images/ad2.png',
    'images/ad3.png',
    'images/ad2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Chào'),
                    getData(_currentUser.user.userName),
                  ],
                ),
                const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://img6.thuthuatphanmem.vn/uploads/2022/11/18/anh-avatar-don-gian-cho-nu_081757692.jpg'),
                    child: Text(''))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 230,
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              autoPlay: true,
            ),
            items: imagesList
                .map(
                  (item) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: imagesList.length,
          effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Color.fromARGB(255, 80, 213, 175)),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: GridView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                buildServiceGridview(
                    context, 'Đặt lịch', Icons.medical_services_outlined, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
                buildServiceGridview(context, 'Lịch khám', Icons.event, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AppointmentSchedule()));
                }),
                buildServiceGridview(
                    context, 'Thuốc', Icons.catching_pokemon_outlined, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
                buildServiceGridview(
                    context, 'Hỗ trợ', Icons.support_agent_outlined, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
              ]),
        )
      ],
    );
  }
}

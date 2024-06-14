import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/users/fragments/profile_fragment_screen.dart';
import 'package:flutter_application_1/users/fragments/timetable.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../userPreferences/current_user.dart';

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

  Widget buildServiceGridview(BuildContext context, String title, IconData icon,
      Function() tapHandler) {
    return InkWell(
      onTap: tapHandler,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 129, 146, 240),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex = 0;
  final List<String> imagesList = [
    'images/slider1.png',
    'images/slider2.png',
    'images/news2.png',
    'images/ad2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                      getData(_currentUser.user.firstName),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      _currentUser.user.gender == 'Nam'
                          ? 'images/avatar_male.webp'
                          : 'images/avatar_female.webp',
                    ),
                    child: Text(''),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: GridView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                buildServiceGridview(
                    context, 'Thời khóa biểu', Icons.calendar_month_sharp, () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Timetable(),
                    ),
                  );
                }),
                buildServiceGridview(
                    context, 'Bài tập', Icons.home_work_rounded, () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profilefragmentsscreen(),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: 230,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
                          child: Container(
                            width: 280,
                            height: 280,
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: imagesList.length,
            effect: const WormEffect(
              dotWidth: 7,
              dotHeight: 7,
              activeDotColor: Color.fromARGB(255, 71, 96, 241),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tin tức',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ))
              ],
            ),
          ),
          ListTile(
            leading: Container(
              width: 100,
              height: 100,
              child: Image.asset('images/news1.png', fit: BoxFit.cover),
            ),
            title: const Text(
              'Trường đón tiếp và làm việc cùng Airbus Defence and Space',
            ),
            subtitle: const Text('1 ngày trước'),
          ),
          ListTile(
            leading: Container(
              width: 100,
              height: 100,
              child: Image.asset('images/news2.png', fit: BoxFit.cover),
            ),
            title: const Text(
              'Trường đón tiếp và làm việc cùng Airbus Defence and Space',
            ),
            subtitle: const Text('2 ngày trước'),
          ),
          const Divider(),
          ListTile(
            leading: Container(
              width: 100,
              height: 100,
              child: Image.asset('images/ad2.png', fit: BoxFit.cover),
            ),
            title: const Text(
              'Trường phát động phong trào phòng chống dịch bệnh',
            ),
            subtitle: const Text('3 ngày trước'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

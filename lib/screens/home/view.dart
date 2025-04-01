import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/screens/home/controller.dart';
import 'package:sample/screens/home/views/category.dart';
import 'package:sample/screens/home/views/drink.dart';
import 'package:sample/utils.dart';
import 'package:sample/widgets/common_bottom_bar.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      // endDrawer: _getDrawer(),
      appBar: _getAppBar(),
      body: RefreshIndicator(
          onRefresh: () async => controller.onInit(), child: _getBody()),
      // bottomNavigationBar: const CommonBottomBar(),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(controller.getUserProfile()),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.getUserName(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // InkWell(
        //   onTap: () {
        //     _scaffoldKey.currentState?.openEndDrawer();
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        //     child: Image.asset('assets/image-12.png'),
        //   ),
        // ),
      ],
    );
  }

  Widget _getDrawer() {
    return Drawer(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset('assets/drawer-bg.png').image,
              fit: BoxFit.cover,
            ),
            color: hexToColor("#EFD9CB"),
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed('user_profile');
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  Image.asset('assets/drawer.png').image,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: hexToColor("#C58346"),
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.camera_enhance_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sabrina Aryan',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: hexToColor("#C58346"),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _getDrawerItem(
                      'Dashboard', Icons.home, () => Get.toNamed('/home')),
                  Divider(),
                  _getDrawerItem('Favourite', Icons.favorite,
                      () => Get.toNamed('/favorites')),
                  Divider(),
                  _getDrawerItem('Ingredient', Icons.notes,
                      () => Get.toNamed('/ingredients')),
                  Divider(),
                  _getDrawerItem('Notifications', Icons.settings,
                      () => Get.toNamed('/home')),
                  Divider(),
                  _getDrawerItem(
                      'Settings', Icons.home, () => Get.toNamed('/questionnare')),
                  Divider(),
                  _getDrawerItem(
                      'Logout', Icons.logout, () => Get.toNamed('/home'),
                      isSelected: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 10),
                    child:
                        Image.asset('assets/logo.png', width: 120, height: 120),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _getDrawerItem(String title, IconData icon, Function() onClick,
      {bool isSelected = false}) {
    var textColor = isSelected ? Colors.white : Colors.black;
    var iconColor = isSelected ? Colors.white : hexToColor("#C58346");
    var containerColor =
        isSelected ? hexToColor("#C58346") : Colors.transparent;
    return Container(
      color: containerColor,
      child: ListTile(
        selected: isSelected,
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
        ),
        onTap: onClick,
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: hexToColor("#EFD9CB"),
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME TO',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'MA CABANE EN VILLE',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'DRINK CATEGORIES',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return DrinkCategory(
                            title: category.name, emoji: category.url);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     buildDrinkCategory('MARGARITA', 'cat-1'),
                  //     buildDrinkCategory('GIMLET', 'cat-2'),
                  //     buildDrinkCategory('MANHATTAN', 'cat-3'),
                  //   ],
                  // )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'OUR DRINKS',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: controller.drinks.length,
              itemBuilder: (context, index) {
                var drink = controller.drinks[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed('/detail', arguments: {
                      'id': drink.id.toString(),
                      'name': drink.name
                    });
                  },
                  child: DrinkCard(
                   drink: drink
                  ),
                );
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
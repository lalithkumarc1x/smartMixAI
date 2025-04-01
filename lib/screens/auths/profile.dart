import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/screens/favorite/controller.dart';
import 'package:sample/services/base.controller.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class ProfileScreen extends GetView<BaseController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/bg.png', // Replace with your image asset
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black
                .withValues(alpha: .3), // Dark overlay for better contrast
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                // getAppBar("Profile", canGoBack: false),
                Stack(
                  children: [
                    GetBuilder<BaseController>(
                      id: "image",
                      builder: (controller) => CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            NetworkImage(controller.getUserProfile()),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            await controller.updateProfile(image);
                          }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: hexToColor("#C58346"),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.camera_enhance_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
                Text(controller.getUserName(),
                    style: CustomTextStyle.text_600(
                      fontSize: 28,
                    )),
                SizedBox(
                  height: 40,
                ),

                // Divider(),
                // _getDrawerItem('Favourite', Icons.favorite,
                //     () => Get.toNamed('/favorites')),
                // Divider(),
                // _getDrawerItem(
                //     'Ingredient', Icons.notes, () => Get.toNamed('/home')),
                // Divider(),
                _getDrawerItem('Notifications', Icons.notifications,
                    () => Get.toNamed('/notification')),
                // Divider(),
                _getDrawerItem(
                    'Preference', Icons.settings,
                    () => Get.toNamed('/preference')),
                // Divider(),
                _getDrawerItem(
                    'Logout', Icons.logout, () async {
                  controller.logout();
                  Get.offAllNamed('/login');
                },
                    isSelected: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDrawerItem(String title, IconData icon, Function() onClick,
      {bool isSelected = false}) {
    var textColor = Colors.white;
    var iconColor = Colors.white;
    var containerColor = Colors.transparent;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: hexToColor("#C58346"),
      ),
      // color: containerColor,
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
}

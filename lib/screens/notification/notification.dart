import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/screens/favorite/controller.dart';
import 'package:sample/screens/notification/controller.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100),
              child: ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.white.withOpacity(0.8),
                    child: ListTile(
                      leading: Icon(Icons.notifications, color: Colors.black),
                      title: Text(
                        notification['title'] ?? "title",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(notification['message'] ?? "message"),
                      trailing: Text(
                        notification['time'] ?? "time",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      onTap: () {
                        // Handle notification tap
                      },
                    ),
                  );
                },
              )),
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

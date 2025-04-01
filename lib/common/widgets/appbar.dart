import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/styles.dart';

Widget getAppBar(String? title, {canGoBack = true}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        if (canGoBack)
        InkWell(
            onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back),
          ),
        ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: CustomTextStyle.text_600()),
          )
      ],
    ),
  );
}

Widget getVerticalDivider(Color? color, {double height = 20}) {
  return SizedBox(
    height: height,
    child: VerticalDivider(
      color: color,
    ),
  );
}

Widget getButton(String label, Color bgColor, Color textColor,
    {bool fullWidth = false, double height = 50, double width = 150}) {
  return SizedBox(
    // width: width,
    height: 21,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 9),
      ),
    ),
  );
}

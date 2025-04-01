import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/widgets/appbar.dart';
import 'package:sample/screens/favorite/controller.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class FavoritesScreen extends GetView<FavoriteController> {
  const FavoritesScreen({super.key});

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
                getAppBar("", canGoBack: false),
                SizedBox(
                  height: 40,
                ),
                _getTopContainer(),
                SizedBox(
                  height: 40,
                ),

                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: controller.favorites.length,
                //   itemBuilder: (context, index) {
                //     var favorite = controller.favorites[index];
                //     return _getIndividualCard(favorite.url, favorite.name);
                //   },
                // ),
                // GetBuilder<FavoriteController>(
                //   id: "listsss",
                //   builder: (controller) {
                //     return ListView.builder(
                //       key: Key("lists"),
                //       shrinkWrap: true,
                //       itemCount: controller.favorites.length,
                //       itemBuilder: (context, index) {
                //         var favorite = controller.favorites[index];
                //         return _getIndividualCard(favorite.url, favorite.name);
                //       },
                //     );
                //   },
                // )
                _getIndividualCard("vodka", "VODKA"),
                _getIndividualCard("cognac", "COGNAC"),
                _getIndividualCard("gin", "GIN"),
                _getIndividualCard("mezcel", "MEZCEL"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTopContainer() {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hexToColor("#C58346"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "FAVORITES",
            style: CustomTextStyle.text_600(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _getIndividualCard(String imageName, String name) {
    return Container(
      key: Key(name),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/$imageName.png',
                  height: 80,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      name,
                      style: CustomTextStyle.text_600(fontSize: 24),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Icon(
                          Icons.favorite,
                          color: hexToColor("#D6253F"),
                          size: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2),
                      child: CircleAvatar(
                        backgroundColor: hexToColor("#C58346"),
                        radius: 15,
                        child: Icon(
                          Icons.thumb_down_sharp,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor,
      {bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {},
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ReadMoreText({super.key, required this.text, this.maxLength = 90});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool shouldTruncate = widget.text.length > widget.maxLength;
    String displayText = (shouldTruncate && !isExpanded)
        ? '${widget.text.substring(0, widget.maxLength)}...'
        : widget.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: TextStyle(fontSize: 9),
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (shouldTruncate) // Show 'Read more' only if truncation is needed
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read less' : 'Read more',
              style: const TextStyle(color: Colors.blue, fontSize: 9),
            ),
          ),
      ],
    );
  }
}

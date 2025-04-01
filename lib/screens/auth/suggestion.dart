import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sample/common/widgets/appbar.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen>
    with TickerProviderStateMixin {
  // final List<Map<String, String>> cocktails = [
  final ScrollController _scrollController = ScrollController();
  double _currentIndex = 0;
  final List<String> cocktails = ["Mojito", "Mijito", "Daiquiri", "Margarita"];
  final data1_data = [
    [0.8, 0.9, 0.3, 0.4, 0.6],
    [0.9, 0.7, 0.2, 0.3, 0.5],
    [0.8, 0.9, 0.3, 0.4, 0.6],
    [0.9, 0.7, 0.2, 0.3, 0.5],
  ];
  final data2_data = [
    [0.9, 0.7, 0.2, 0.3, 0.5],
    [0.8, 0.9, 0.3, 0.4, 0.6],
    [0.9, 0.7, 0.2, 0.3, 0.5],
    [0.8, 0.9, 0.3, 0.4, 0.6],
  ];

  int _index = 0;

  late TabController _tabController;

  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset /
          200; // Adjust based on item width + spacing
      setState(() {
        _currentIndex = offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.fill,
          ),
          Column(
            children: [
               SizedBox(height: 40,),
              getAppBar("Here your suggestion", canGoBack: false),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                decoration: BoxDecoration(
                    color: hexToColor("#EBCCB9"),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: hexToColor("#C58346"))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                            _tabController.animateTo(0);
                          });
                        },
                        child: Container(
                          height: 40,
                          // margin: EdgeInsets.symmetric(horizontal: 4),
                          // padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: _selectedIndex == 0
                                ? hexToColor("#C58346")
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "COCKTAILS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: _selectedIndex == 0
                                    ? Colors.black
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                            _tabController.animateTo(1);
                          });
                        },
                        child: Container(
                          height: 40,
                          // margin: EdgeInsets.symmetric(horizontal: 4),
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: _selectedIndex == 1
                                ? hexToColor("#C58346")
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "SHOOTERS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: _selectedIndex == 1
                                    ? Colors.black
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCocktailGrid(),
                    _buildCocktailGrid(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCocktailGrid() {
    return Column(
      children: [
        // Drinks Grid
        Container(
          height: 300,
          padding: EdgeInsets.all(8),
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.6),
            itemCount: 4,
            onPageChanged: (index) {
              setState(() {
                _index = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: PageController(viewportFraction: 0.6),
                builder: (context, child) {
                  double scale = 1.0;
                  // double difference = (_currentIndex - index).abs();

                  if (_index == index) {
                    scale = 1.1;
                  } else {
                    scale = 0.9; // Smaller size for items outside focus
                  }

                  return Center(
                    child: Transform.scale(
                      scale: scale,
                      child: _buildDrinkCard(),
                    ),
                  );
                },
              );
            },
          ),
        ),

        SizedBox(height: 80,),
        // Radar Chart
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: SizedBox(height: 250, width: 250, child: 
          Stack(
            children: [
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 20,
                              decoration: BoxDecoration(color: hexToColor("#A29D9A"),
                              borderRadius: BorderRadius.circular(2)),
                            ),
                            SizedBox(width: 5,),
                            Text("Your Profile",
                             style: CustomTextStyle.text_600(fontSize: 12),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 20,
                              decoration: BoxDecoration(color: hexToColor("#C58346"),
                              borderRadius: BorderRadius.circular(2)),
                            ),
                            SizedBox(width: 5,),
                            Text("Mojito",
                            style: CustomTextStyle.text_600(fontSize: 12),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
                  RadarChartWidget(
                    data1: data1_data[_index],
                    data2: data2_data[_index],
                  ),
            ],
          )),
        ),
        SizedBox(height: 10,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     CircleAvatar(backgroundColor: hexToColor("#CBAE9B"),radius: 8,),
        //     SizedBox(width: 4,),
        //     CircleAvatar(backgroundColor: hexToColor("#C58346"),radius: 8,),
        //     SizedBox(width: 4,),
        //     CircleAvatar(backgroundColor: hexToColor("#CBAE9B"),radius: 8,)
        //   ],
        // )
      ],
    );
  }

  Widget _buildDrinkCard() {
    return Container(
      height: 250,
      width: 180,
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white)),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MOJITO',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // rixh text with readmore color as white
          RichText(
            text: TextSpan(
              text: 'Lorem Ipsum is simply and typesetting ',
              style: TextStyle(fontSize: 12, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Read More',
                  style: TextStyle(color: hexToColor("#C58346")),
                ),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              'assets/image-7.png', // Placeholder for drink image
              height: 100,
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: hexToColor("#C58346"),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'SEE MORE',
              style: TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class RadarChartWidget extends StatelessWidget {
  final List<double> data1;
  final List<double> data2;
  const RadarChartWidget({super.key, required this.data1, required this.data2});

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        radarBackgroundColor: hexToColor("#EBCCB9"),
        // radarShape: RadarShape.circle,
        titleTextStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        tickCount: 4,
        gridBorderData:
            BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
        getTitle: (index, angle) {
          const titles = ["ACID", "SUGAR", "CREAMY", "SPICY", "AMER"];
          return RadarChartTitle(text: titles[index]);
        },
        tickBorderData: BorderSide(color: hexToColor("#D08151"),
        width: .3,
        style: BorderStyle.solid),
        dataSets: [
          RadarDataSet(
            entryRadius: 2,
            fillColor: hexToColor("#C58346").withValues(alpha: .5),
            borderColor: hexToColor("#D08151"),
            borderWidth: 1,
            dataEntries: data1.map((e) => RadarEntry(value: e)).toList(),
            // [

            //   RadarEntry(value: 0.8),
            //   RadarEntry(value: 0.9),
            //   RadarEntry(value: 0.3),
            //   RadarEntry(value: 0.4),
            //   RadarEntry(value: 0.6),
            // ],
          ),
          RadarDataSet(
            fillColor: hexToColor("#A29D9A").withValues(alpha: .4),
            borderColor: hexToColor("#A29D9A"),
            dataEntries: data1.map((e) => RadarEntry(value: e)).toList(),
            // [
            //   RadarEntry(value: 0.9),
            //   RadarEntry(value: 0.7),
            //   RadarEntry(value: 0.2),
            //   RadarEntry(value: 0.3),
            //   RadarEntry(value: 0.5),
            // ],
          ),
        ],
      ),
    );
  }
}

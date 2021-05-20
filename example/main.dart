import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked_bar_chart/stacked_bar_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: StackedBarGraph(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StackedBarGraph extends StatefulWidget {
  StackedBarGraph({Key? key}) : super(key: key);

  @override
  _StackedBarGraphState createState() => _StackedBarGraphState();
}

class _StackedBarGraphState extends State<StackedBarGraph> {
  int randomNumber = Random().nextInt(2);

  List<Color> colors = [
    Color(0xff4d504d),
    Color(0xff6b79a6),
    Color(0xffd6dcd6),
    Color(0xff779b73),
    Color(0xffa9dda5),
    Color(0xff9aaced),
  ];

  @override
  void initState() {
    super.initState();
    colors.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stacked Rounded Rectangle Graph"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Graph(
            GraphData(
              "ThePension",
              [
                GraphBar(
                  DateTime(2020, 01),
                  [
                    GraphBarSection(100, color: colors[randomNumber]),
                    GraphBarSection(900, color: colors[randomNumber + 1]),
                    GraphBarSection(0, color: colors[randomNumber + 2]),
                    GraphBarSection(0, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 2),
                  [
                    GraphBarSection(50, color: colors[randomNumber]), //second
                    GraphBarSection(501,
                        color: colors[randomNumber + 1]), //first
                    GraphBarSection(-100, color: colors[randomNumber + 2]),
                    GraphBarSection(-700, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 3),
                  [
                    GraphBarSection(150, color: colors[randomNumber]),
                    GraphBarSection(800.22, color: colors[randomNumber + 1]),
                    GraphBarSection(-150, color: colors[randomNumber + 2]),
                    GraphBarSection(-550, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 4),
                  [
                    GraphBarSection(750, color: colors[randomNumber]),
                    GraphBarSection(45, color: colors[randomNumber + 1]),
                    GraphBarSection(-50, color: colors[randomNumber + 2]),
                    GraphBarSection(-570, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 5),
                  [
                    GraphBarSection(200, color: colors[randomNumber]),
                    GraphBarSection(670, color: colors[randomNumber + 1]),
                    GraphBarSection(-400, color: colors[randomNumber + 2]),
                    GraphBarSection(-50, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 6),
                  [
                    GraphBarSection(200, color: colors[randomNumber]),
                    GraphBarSection(307, color: colors[randomNumber + 1]),
                    GraphBarSection(-309, color: colors[randomNumber + 2]),
                    GraphBarSection(-90, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 7),
                  [
                    GraphBarSection(200, color: colors[randomNumber]),
                    GraphBarSection(350, color: colors[randomNumber + 1]),
                    GraphBarSection(-170, color: colors[randomNumber + 2]),
                    GraphBarSection(-500, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 8),
                  [
                    GraphBarSection(200, color: colors[randomNumber]),
                    GraphBarSection(300, color: colors[randomNumber + 1]),
                    GraphBarSection(-300, color: colors[randomNumber + 2]),
                    GraphBarSection(-500, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 9),
                  [
                    GraphBarSection(200, color: colors[randomNumber]),
                    GraphBarSection(390, color: colors[randomNumber + 1]),
                    GraphBarSection(-1000, color: colors[randomNumber + 2]),
                    GraphBarSection(-0, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 10),
                  [
                    GraphBarSection(60, color: colors[randomNumber]),
                    GraphBarSection(700, color: colors[randomNumber + 1]),
                    GraphBarSection(-100, color: colors[randomNumber + 2]),
                    GraphBarSection(-500, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 11),
                  [
                    GraphBarSection(200, color: colors[randomNumber]),
                    GraphBarSection(470, color: colors[randomNumber + 1]),
                    GraphBarSection(-700, color: colors[randomNumber + 2]),
                    GraphBarSection(-320, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  DateTime(2020, 12),
                  [
                    GraphBarSection(500, color: colors[randomNumber]),
                    GraphBarSection(500.0, color: colors[randomNumber + 1]),
                    GraphBarSection(-500.0, color: colors[randomNumber + 2]),
                    GraphBarSection(-500.0, color: colors[randomNumber + 3]),
                  ],
                ),
              ],
              Colors.white,
            ),
            yLabelConfiguration: YLabelConfiguration(
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
              interval: 500,
              labelCount: 5,
              labelMapper: (num value) {
                return NumberFormat.compactCurrency(
                        locale: "en", decimalDigits: 0, symbol: "\$")
                    .format(value);
              },
            ),
            xLabelConfiguration: XLabelConfiguration(
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
              labelMapper: (DateTime date) {
                return DateFormat("MMM yyyy").format(date);
              },
            ),
            netLine: NetLine(
              showLine: true,
              lineColor: Colors.blue,
              pointBorderColor: Colors.black,
              coreColor: Colors.white,
            ),
            graphType: GraphType.StackedRounded,
            onBarTapped: (GraphBar bar) {
              print(bar.month);
              setState(() {});
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("Stack Value 1"),
                leading: Icon(Icons.account_balance_rounded),
                trailing: Icon(
                  Icons.circle,
                  color: colors[randomNumber + 1],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("Stack Value 2"),
                leading: Icon(Icons.account_balance_rounded),
                trailing: Icon(
                  Icons.circle,
                  color: colors[randomNumber],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("Stack Value 3"),
                leading: Icon(Icons.account_balance_rounded),
                trailing: Icon(
                  Icons.circle,
                  color: colors[randomNumber + 2],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text("Stack Value 4"),
                leading: Icon(Icons.account_balance_rounded),
                trailing: Icon(
                  Icons.circle,
                  color: colors[randomNumber + 3],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
  StackedBarGraph({Key key}) : super(key: key);

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
            data: GraphData(
              backgroundColor: Colors.white,
              name: "ThePension",
              bars: [
                GraphBar(
                  month: DateTime(2020, 01),
                  sections: [
                    GraphBarSection(value: 100, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 900, color: colors[randomNumber + 1]),
                    GraphBarSection(value: 0, color: colors[randomNumber + 2]),
                    GraphBarSection(value: 0, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 2),
                  sections: [
                    GraphBarSection(
                        value: 50, color: colors[randomNumber]), //second
                    GraphBarSection(
                        value: 501, color: colors[randomNumber + 1]), //first
                    GraphBarSection(
                        value: -100, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -700, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 3),
                  sections: [
                    GraphBarSection(value: 150, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 800.22, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -150, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -550, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 4),
                  sections: [
                    GraphBarSection(value: 750, color: colors[randomNumber]),
                    GraphBarSection(value: 45, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -50, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -570, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 5),
                  sections: [
                    GraphBarSection(value: 200, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 670, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -400, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -50, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 6),
                  sections: [
                    GraphBarSection(value: 200, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 307, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -309, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -90, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 7),
                  sections: [
                    GraphBarSection(value: 200, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 350, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -170, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -500, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 8),
                  sections: [
                    GraphBarSection(value: 200, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 300, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -300, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -500, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 9),
                  sections: [
                    GraphBarSection(value: 200, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 390, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -1000, color: colors[randomNumber + 2]),
                    GraphBarSection(value: -0, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 10),
                  sections: [
                    GraphBarSection(value: 60, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 700, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -100, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -500, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 11),
                  sections: [
                    GraphBarSection(value: 200, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 470, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -700, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -320, color: colors[randomNumber + 3]),
                  ],
                ),
                GraphBar(
                  month: DateTime(2020, 12),
                  sections: [
                    GraphBarSection(value: 500, color: colors[randomNumber]),
                    GraphBarSection(
                        value: 500.0, color: colors[randomNumber + 1]),
                    GraphBarSection(
                        value: -500.0, color: colors[randomNumber + 2]),
                    GraphBarSection(
                        value: -500.0, color: colors[randomNumber + 3]),
                  ],
                ),
              ],
            ),
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

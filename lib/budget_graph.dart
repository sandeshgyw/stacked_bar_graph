part of stacked_bar_chart;

class BudgetGraph extends StatelessWidget {
  const BudgetGraph({
    Key key,
    @required this.data,
    this.height = 350,
    this.onBarTapped,
    this.barWidth = 30,
  }) : super(key: key);

  final Function(GraphBar) onBarTapped;
  final GraphData data;

  final double height;
  final double barWidth;

  double get paddedBarWidth => barWidth * paddingFactor;
  // Adding some padding on left and right of the bar
  double get paddingFactor => 1.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Row(
          children: [
            Container(
              width: 50,
              child: CustomPaint(
                size: Size(0, height),
                painter: _AxisPainter(data,
                    barWidth: barWidth, paddedBarWidth: paddedBarWidth),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true, //to  make it start from end
                scrollDirection: Axis.horizontal,
                child: GestureDetector(
                  onTapUp: (detail) {
                    int index =
                        ((detail.localPosition.dx) / (paddedBarWidth)).floor();
                    DateTime selectedMonth = data.months[index];

                    GraphBar selectedBar = data.bars.firstWhere(
                      (b) => b.month.compareTo(selectedMonth) == 0,
                      orElse: () => null,
                    );
                    if (selectedBar != null) onBarTapped?.call(selectedBar);
                  },
                  child: CustomPaint(
                    size: Size((data.months.length) * paddedBarWidth, height),
                    painter: _GraphPainter(
                      data,
                      barWidth: barWidth,
                      paddedBarWidth: paddedBarWidth,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

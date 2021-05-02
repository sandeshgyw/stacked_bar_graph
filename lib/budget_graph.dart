part of stacked_bar_chart;

class BudgetGraph extends StatelessWidget {
  const BudgetGraph({
    Key key,
    @required this.data,
    this.xLabelMapper,
    this.xLabelStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 11,
    ),
    this.yLabelMapper,
    this.yLabelStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 11,
    ),
    this.height = 350,
    this.onBarTapped,
    this.barWidth = 30,
  }) : super(key: key);

  /// This parameter returns String as
  final String Function(DateTime) xLabelMapper;
  final String Function(num) yLabelMapper;
  final Function(GraphBar) onBarTapped;
  final GraphData data;
  final TextStyle xLabelStyle;
  final TextStyle yLabelStyle;

  final double height;
  final double barWidth;

  double get paddedBarWidth => barWidth * paddingFactor;
  // Adding some padding on left and right of the bar
  double get paddingFactor => 1.5;

  double getWidth() {
    double high = data.cumulativeHigh > data.cumulativeLow
        ? data.cumulativeHigh
        : data.cumulativeLow;
    String label = yLabelMapper?.call(high) ?? high.toStringAsFixed(2);

    final textSpan = TextSpan(
      text: label,
      style: yLabelStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: paddedBarWidth,
    );

    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          CustomPaint(
            size: Size(getWidth(), height),
            painter: _AxisPainter(
              data,
              yLabelMapper: yLabelMapper,
              yLabelStyle: yLabelStyle,
              barWidth: barWidth,
              paddedBarWidth: paddedBarWidth,
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
                    xLabelMapper: xLabelMapper,
                    xLabelStyle: xLabelStyle,
                    barWidth: barWidth,
                    paddedBarWidth: paddedBarWidth,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

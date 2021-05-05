part of stacked_bar_chart;

class BudgetGraph extends StatelessWidget {
  const BudgetGraph({
    Key key,
    @required this.data,
    this.xLabelConfiguration,
    this.yLabelConfiguration,
    this.graphType,
    this.netLine,
    this.scrollController,
    this.height = 350,
    this.onBarTapped,
    this.barWidth = 30,
  }) : super(key: key);

  ///To configure the values in X-axis(labels).
  final XLabelConfiguration xLabelConfiguration;

  ///Provides callback whenever the bar plotted is tapped
  final Function(GraphBar) onBarTapped;

  ///Provides data to be plotted.
  final GraphData data;

  ///Style th labels in X-axis.
  // final TextStyle xLabelStyle;

  final ScrollController scrollController;

  ///To control the plotting of NetLine
  final NetLine netLine;

  ///Height of the the canvas where the graph is plotted
  final double height;

  //width of the bar that has been plotted
  final double barWidth;

  ///Type of Graph to be plotted.
  final GraphType graphType;

  ///To configure the values in Y-axis(labels).
  final YLabelConfiguration yLabelConfiguration;

  double get paddedBarWidth => barWidth * paddingFactor;
  // Adding some padding on left and right of the bar
  double get paddingFactor => 1.5;

  double get getWidth {
    double high = data.cumulativeHigh > -data.cumulativeLow
        ? data.cumulativeHigh
        : -data.cumulativeLow;

    String label = yLabelConfiguration?.yLabelMapper?.call(high) ??
        high.toStringAsFixed(2);

    final textSpan = TextSpan(
      text: label,
      style: yLabelConfiguration?.yLabelStyle?.color == null
          ? TextStyle(color: Colors.grey)
          : yLabelConfiguration.yLabelStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: paddedBarWidth,
    );

    return (label.length == 7 || label.length == 5)
        ? textPainter.width + 10
        : textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          CustomPaint(
            size: Size(getWidth, height),
            painter: _AxisPainter(
              data,
              yLabelConfiguration: yLabelConfiguration,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                reverse: true, //to  make it start from end
                controller: scrollController,
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
                    size: Size(((data.months.length) * paddedBarWidth), height),
                    painter: _GraphPainter(
                      data,
                      xLabelConfiguration: xLabelConfiguration,
                      netLine: netLine,
                      barWidth: barWidth,
                      paddedBarWidth: paddedBarWidth,
                      graphType: graphType,
                    ),
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

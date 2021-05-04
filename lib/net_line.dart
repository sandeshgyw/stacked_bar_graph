part of stacked_bar_chart;

class NetLine {
  ///whether to display the net line or not.
  final bool showLine;

  ///to display only the netpoints
  final bool showPointOnly;

  ///give color to the net line
  final Color lineColor;

  ///give width of the net line drawn
  final double strokeWidth;

  ///give color to the core(inner circle) of the net point
  final Color coreColor;

  ///give color to the outer circle of the net Point
  final Color pointBorderColor;

  NetLine({
    this.lineColor = Colors.yellow,
    this.strokeWidth = 2,
    this.coreColor = Colors.white,
    this.showLine = false,
    this.showPointOnly = false,
    this.pointBorderColor = Colors.yellow,
  });
}

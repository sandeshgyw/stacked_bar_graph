part of stacked_bar_chart;

class NetLine {
  final bool showLine;
  final bool showPointOnly;
  final Color lineColor;
  final double strokeWidth;
  final Color coreColor;
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

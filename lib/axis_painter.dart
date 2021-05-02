part of stacked_bar_chart;

class _AxisPainter extends CustomPainter {
  GraphData data;
  _AxisPainter(this.data, {this.barWidth = 50, this.paddedBarWidth});

  double section = 500; //y axis ka labels difference
  double barWidth;
  double paddedBarWidth;

  Point startPoint = Point();
  Point endPoint = Point();

  final textStyleY = TextStyle(
    color: Color(0xff4c4c4c),
  );

  double get adjustedHigh {
    return (data.cumulativeHigh / section)
            .ceil() * //revert simplly replace cumu with high,low
        section; //500 ko range wala highest value in  y axisi.e if highest 480 then y axis label highest 500
  }

  double get adjustedLow {
    return (data.cumulativeLow / section).floor() * section;
  }

  double get adjustedRange {
    return adjustedHigh - adjustedLow;
  }

  double getHeightOfSection(double value) {
    return (value / adjustedRange) *
        graphDisplayHeight /
        2; //viewport mapping of graph to actual screen of height graphDisplayHeight
  }

  double get graphDisplayHeight {
    return size.height - 20;
  }

  Size size;
  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    startPoint.x = paddedBarWidth / 2;
    _plotYAxis(size, canvas, data);
  }

  _plotYAxis(Size size, Canvas canvas, GraphData data) {
    _plotPositiveLabels(canvas);
    _plotNegativeLabels(canvas);
  }

  _plotPositiveLabels(Canvas canvas) {
    for (int i = 0; i < data.cumulativeHigh + section; i = i + section.ceil()) {
      // canvas.drawLine(
      //     Offset(0, graphDisplayHeight / 2 - getHeightOfSection(i.toDouble())),
      //     Offset(5, graphDisplayHeight / 2 - getHeightOfSection(i.toDouble())),
      //     Paint()
      //       ..color = i == 0 ? Colors.blue : Colors.grey
      //       ..strokeWidth = 2);for tick
      final textSpan = TextSpan(
        text: "Є" + "${NumberFormat.compact().format(i)}",
        style: textStyleY,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: paddedBarWidth,
      );
      Offset offset = Offset(
          0, graphDisplayHeight / 2 - getHeightOfSection(i.toDouble()) - 9);

      textPainter.paint(canvas, offset);
    }
  }

  _plotNegativeLabels(Canvas canvas) {
    for (int i = 0; i < -data.cumulativeLow + section; i = i + section.ceil()) {
      final textSpan = TextSpan(
        text: "-" + "Є" + "${NumberFormat.compact().format(i)}",
        style: textStyleY,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: paddedBarWidth,
      );
      Offset offset = Offset(
          0, graphDisplayHeight / 2 + getHeightOfSection(i.toDouble()) - 9);
      if (i != 0) textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

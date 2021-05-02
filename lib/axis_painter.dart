part of stacked_bar_chart;

class _AxisPainter extends CustomPainter {
  GraphData data;
  _AxisPainter(this.data, {this.barWidth = 50, this.paddedBarWidth});

  double sectionRange = 250; //y axis ka labels difference
  double barWidth;
  double paddedBarWidth;

  Point startPoint = Point();
  Point endPoint = Point();

  double get fontFactor => 0.8;

  double get section {
    if (data.cumulativeHigh > data.cumulativeLow * -1) {
      return (data.cumulativeHigh / (2 * sectionRange)).ceil() * sectionRange;
    } else if (data.cumulativeHigh < data.cumulativeLow * -1) {
      return (-data.cumulativeLow / (2 * sectionRange)).ceil() * sectionRange;
    } else {
      return (data.cumulativeHigh / (2 * sectionRange)).ceil() * sectionRange;
    }
  }

  final textStyleY = TextStyle(
    color: Color(0xff4c4c4c),
    fontSize: 14 * 0.8,
  );
  double get maxLableRange {
    if (data.cumulativeHigh > data.cumulativeLow * -1) {
      return adjustedHigh;
    } else if (data.cumulativeHigh < data.cumulativeLow * -1) {
      return -adjustedLow;
    } else {
      return adjustedHigh;
    }
  }

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
    for (int i = 0; i < maxLableRange + section; i = i + section.ceil()) {
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
          0 - textPainter.width / 2,
          graphDisplayHeight / 2 -
              getHeightOfSection(i.toDouble()) -
              textPainter.height / 2);

      textPainter.paint(canvas, offset);
    }
  }

  _plotNegativeLabels(Canvas canvas) {
    for (int i = 0; i < maxLableRange + section; i = i + section.ceil()) {
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
          0 - textPainter.width / 2,
          graphDisplayHeight / 2 +
              getHeightOfSection(i.toDouble()) -
              textPainter.height / 2);
      if (i != 0) textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

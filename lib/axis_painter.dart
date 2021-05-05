part of stacked_bar_chart;

class _AxisPainter extends CustomPainter {
  GraphData data;
  _AxisPainter(
    this.data, {
    this.yLabelConfiguration,
  });

  final YLabelConfiguration yLabelConfiguration;

  Point startPoint = Point();
  Point endPoint = Point();

  double get fontFactor => 0.8;
  double graphPlotOffset =
      100.0; //must be above 100 this gives the space for the net point plot on top of the bar

  int get labelCount {
    if (yLabelConfiguration.labelCount == 2) return 3;
    return yLabelConfiguration?.labelCount ?? 3;
  }

  double get interval {
    return yLabelConfiguration?.interval ?? 500;
  }

  double get section {
    if (labelCount == 1) return 1;
    if (data.cumulativeHigh > data.cumulativeLow * -1) {
      return (data.cumulativeHigh / (((labelCount - 1) * 0.5) * interval / 2))
              .ceil() *
          interval /
          2;
    } else if (data.cumulativeHigh < data.cumulativeLow * -1) {
      return (-data.cumulativeLow / (((labelCount - 1) * 0.5) * interval / 2))
              .ceil() *
          interval /
          2;
    } else {
      return (data.cumulativeHigh / (((labelCount - 1) * 0.5) * interval / 2))
              .ceil() *
          interval /
          2;
    }
  }

  double get maxLableRange {
    if (labelCount == 1) return 0;
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

  double getHeightOfSection(double value) {
    return (value / (maxLableRange + graphPlotOffset)) *
        graphDisplayHeight /
        2; //viewport mapping of graph to actual screen of height graphDisplayHeight
  }

  double get graphDisplayHeight {
    return size.height - graphPlotOffset / 2;
  }

  Size size;
  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    _plotYAxis(size, canvas, data);
  }

  _plotYAxis(Size size, Canvas canvas, GraphData data) {
    _plotPositiveLabels(canvas);
    _plotNegativeLabels(canvas);
  }

  _plotPositiveLabels(Canvas canvas) {
    for (int i = 0; i < maxLableRange + section; i = i + section.ceil()) {
      TextSpan textSpan = TextSpan(
        text:
            yLabelConfiguration?.yLabelMapper?.call(i) ?? i.toStringAsFixed(2),
        style: yLabelConfiguration?.yLabelStyle?.color == null
            ? TextStyle(
                color: Colors.grey,
                fontSize: 11,
              )
            : yLabelConfiguration.yLabelStyle,
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      Offset offset = Offset(
          0,
          graphDisplayHeight / 2 -
              getHeightOfSection(i.toDouble()) -
              textPainter.height / 2);

      textPainter.paint(canvas, offset);
    }
  }

  _plotNegativeLabels(Canvas canvas) {
    for (int i = 0; i < maxLableRange + section; i = i + section.ceil()) {
      final textSpan = TextSpan(
        text:
            yLabelConfiguration?.yLabelMapper?.call(i) ?? i.toStringAsFixed(2),
        style: yLabelConfiguration?.yLabelStyle?.color == null
            ? TextStyle(
                color: Colors.grey,
                fontSize: 11,
              )
            : yLabelConfiguration.yLabelStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
      );
      Offset offset = Offset(
        0,
        graphDisplayHeight / 2 +
            getHeightOfSection(i.toDouble()) -
            textPainter.height / 2,
      );
      if (i != 0) textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

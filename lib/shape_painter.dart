part of stacked_bar_chart;

class _GraphPainter extends CustomPainter {
  GraphData data;
  final XLabelConfiguration xLabelConfiguration;
  NetLine netLine;
  GraphType graphType;
  _GraphPainter(
    this.data, {
    this.barWidth = 50,
    this.paddedBarWidth,
    this.xLabelConfiguration,
    this.netLine,
    this.graphType = GraphType.StackedRect,
  });
  Point startPoint = Point();
  double sectionRange = 250; //y axis ka labels difference
  double barWidth;
  double paddedBarWidth;
  double tickHeight = 3;
  double netPointRadius = 6;
  double netPointThickness = 2;
  double graphPlotOffset = 100.0;
  double get clipWidth {
    return (paddedBarWidth - barWidth) / 2;
  }

  Color get clipColor => data.backgroundColor;

  double get section {
    if (data.cumulativeHigh > -data.cumulativeLow) {
      return (data.cumulativeHigh / (2 * sectionRange)).ceil() * sectionRange;
    } else if (data.cumulativeHigh < -data.cumulativeLow) {
      return (-data.cumulativeLow / (2 * sectionRange)).ceil() * sectionRange;
    } else {
      return (data.cumulativeHigh / (2 * sectionRange)).ceil() * sectionRange;
    }
  }

  double previousStart = 0;

  Point endPoint = Point();

  double get adjustedHigh {
    return (data.cumulativeHigh / section)
            .ceil() * //revert simplly replace cumu with high,low
        section; //500 ko range wala highest value in  y axisi.e if highest 480 then y axis label highest 500
  }

  double get adjustedLow {
    return (data.cumulativeLow / section).floor() * section;
  }

  double get maxLableRange {
    if (data.cumulativeHigh > data.cumulativeLow * -1) {
      return adjustedHigh;
    } else if (data.cumulativeHigh < data.cumulativeLow * -1) {
      return -adjustedLow;
    } else {
      return adjustedHigh;
    }
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
    startPoint.x = paddedBarWidth / 2;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = data.backgroundColor,
    );

    data.months.forEach((m) {
      GraphBar barData = data.bars.firstWhere(
        (e) => e.month.compareTo(m) == 0,
        orElse: () => null,
      );
      if (barData != null) {
        if (graphType != GraphType.LineGraph) _plotBar(canvas, barData);
        if (graphType == GraphType.StackedRounded) _clipBar(canvas, barData);
        if ((netLine?.showPointOnly ?? false) == true ||
            (netLine?.showLine ?? false) == true) {
          _plotNetPoint(barData, canvas);
        }
        startPoint.y =
            graphDisplayHeight / 2 - getHeightOfSection(barData.average);
        if ((netLine?.showLine ?? false) == true &&
            (netLine?.showPointOnly ?? false) != true) {
          _plotNetLine(canvas, startPoint, endPoint, barData);
        }
      }
      if (barData == null) {
        endPoint.x = endPoint.x - paddedBarWidth;
      }
      _plotXAxisLabels(
        canvas,
        size,
        xLabelConfiguration?.labelMapper?.call(m) ??
            DateFormat("MMM").format(m),
      );
      canvas.translate(paddedBarWidth, 0);
    });
  }

  _plotXAxisLabels(Canvas canvas, Size size, String month) {
    final textSpan = TextSpan(
      text: month,
      style: xLabelConfiguration?.labelStyle?.color == null
          ? TextStyle(
              color: Colors.grey,
              fontSize: 11,
            )
          : xLabelConfiguration?.labelStyle,
    );
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
        textAlign: TextAlign.center);

    textPainter.layout(
      minWidth: 0,
      maxWidth: paddedBarWidth,
    );

    textPainter.paint(
      canvas,
      Offset(
        ((paddedBarWidth / 2) - textPainter.width / 2),
        size.height / 2 - getHeightOfSection(-maxLableRange),
      ),
    );
  }

  _plotBar(Canvas canvas, GraphBar graphBar) {
    _plotBarTop(canvas, graphBar);
    _plotBarBottom(canvas, graphBar);
  }

  _clipBar(Canvas canvas, GraphBar barData) {
    RRect rRect1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          ((paddedBarWidth - barWidth) / 2),
          graphDisplayHeight / 2 - getHeightOfSection(barData.high),
          barWidth,
          getHeightOfSection(barData.range)),
      Radius.circular(100),
    );
    RRect rRect2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          ((paddedBarWidth - barWidth) / 2) - 1,
          graphDisplayHeight / 2 - getHeightOfSection(barData.high) - 1,
          barWidth + 2,
          getHeightOfSection(barData.range) + 2),
      Radius.circular(0),
    );
    canvas.drawDRRect(
        rRect2,
        rRect1,
        Paint()
          ..color = clipColor
          ..style = PaintingStyle.fill);
  }

  _plotNetPoint(GraphBar graphBar, Canvas canvas) {
    canvas.drawCircle(
        Offset(paddedBarWidth / 2,
            graphDisplayHeight / 2 - getHeightOfSection(graphBar.average)),
        netPointRadius,
        Paint()..color = (netLine?.pointBorderColor ?? Colors.yellow));
    canvas.drawCircle(
        Offset(paddedBarWidth / 2,
            graphDisplayHeight / 2 - getHeightOfSection(graphBar.average)),
        netPointRadius - netPointThickness,
        Paint()..color = (netLine?.coreColor ?? Colors.white));
  }

  _plotNetLine(
      Canvas canvas, Point startPoint, Point endPoint, GraphBar barData) {
    if (barData.month != data.bars.first.month) {
      canvas.drawLine(
        Offset(startPoint.x - netPointRadius, startPoint.y),
        Offset(endPoint.x + netPointRadius, endPoint.y),
        Paint()
          ..color = (netLine?.lineColor ?? Colors.yellow)
          ..strokeWidth = (netLine?.strokeWidth ?? 2),
      );
    }

    endPoint.x = startPoint.x - paddedBarWidth;
    endPoint.y = startPoint.y;
  }

  _plotBarTop(Canvas canvas, GraphBar graphBar) {
    previousStart = graphDisplayHeight / 2;
    graphBar.sections.forEach((s) {
      if (s.value > 0) _plotSection(canvas, s);
    });
  }

  _plotBarBottom(Canvas canvas, GraphBar graphBar) {
    previousStart = graphDisplayHeight / 2;
    graphBar.sections.forEach((s) {
      if (s.value < 0) _plotSection(canvas, s);
    });
  }

  _plotSection(Canvas canvas, GraphBarSection section) {
    canvas.drawRect(
      Rect.fromLTWH(
        (paddedBarWidth - barWidth) / 2, //mathematically solved
        previousStart,
        barWidth,
        -getHeightOfSection(section.value), //if + draws beloow the origin
      ),
      Paint()..color = section.color,
    );
    previousStart = previousStart - getHeightOfSection(section.value);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

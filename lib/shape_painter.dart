part of stacked_bar_chart;

class _GraphPainter extends CustomPainter {
  GraphData data;
  _GraphPainter(this.data,
      {this.barWidth = 50, this.paddedBarWidth, this.clipColor});

  double section = 500; //y axis ka labels difference
  double barWidth;
  double paddedBarWidth;
  double tickHeight = 3;
  double netPointRadius = 6;
  double netPointThickness = 2;
  double get clipWidth {
    return (paddedBarWidth - barWidth) / 2;
  }

  Color clipColor; //TODO:this must be exact same as the background color

  double previousStart = 0;

  Offset startPoint;
  Offset endPoint;

  final textStyle = TextStyle(
    color: Color(0xff4c4c4c),
    fontSize: 20,
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
    return (adjustedHigh - adjustedLow);
  }

  double getHeightOfSection(double value) {
    return (value / adjustedRange) *
        graphDisplayHeight /
        2; //viewport mapping of graph to actual screen of height graphDisplayHeight
  }

  // double get initialHeight {
  //   return graphDisplayHeight / 2 - getHeightOfSection(data.initialHeight);
  // }

  double get graphDisplayHeight {
    return size.height - 20;
  }

  Size size;
  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    startPoint = Offset(paddedBarWidth / 2, startPoint.dy);

    data.months.forEach((m) {
      GraphBar barData = data.bars.firstWhere(
        (e) => e.month.compareTo(m) == 0,
        orElse: () => null,
      );
      if (barData != null) {
        _plotBar(canvas, barData);

        _clipBar(canvas, barData);
        _plotNetPoint(barData, canvas);
        startPoint = Offset(startPoint.dx,
            graphDisplayHeight / 2 - getHeightOfSection(barData.average));

        _plotNetLine(canvas, startPoint, endPoint, barData);
      }
      if (barData == null) {
        endPoint = Offset(endPoint.dx - paddedBarWidth, endPoint.dy);
      }
      _plotXAxisLabels(canvas, size, m);
      canvas.translate(paddedBarWidth, 0);
    });
  }

  _plotXAxis(Size size, Canvas canvas) {
    canvas.drawLine(
        Offset(5, size.height / 2 - getHeightOfSection(data.cumulativeLow)),
        Offset(size.width,
            size.height / 2 - getHeightOfSection(data.cumulativeLow)),
        Paint()..color = Colors.black);
  }

  _plotXAxisLabels(Canvas canvas, Size size, DateTime month) {
    String nextMonthStr = DateFormat.MMM().format(month);
    Offset offset = Offset(paddedBarWidth,
        size.height / 2 - getHeightOfSection(data.cumulativeLow));

    final textSpan = TextSpan(
      text: nextMonthStr,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: paddedBarWidth,
    );
    print(textPainter.width);
    print(textPainter.width);
    textPainter.paint(
      canvas,
      Offset(
        ((paddedBarWidth / 2) - textPainter.width / 2),
        size.height / 2 - getHeightOfSection(data.cumulativeLow),
      ),
    );

    // canvas.drawLine(
    //     Offset((((paddedBarWidth / 2))),
    //         size.height / 2 - getHeightOfSection(data.cumulativeLow)),
    //     Offset((paddedBarWidth / 2),
    //         size.height / 2 - getHeightOfSection(data.cumulativeLow) - 200),
    //     Paint()
    //       ..color = Colors.grey
    //       ..strokeWidth = 1);
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
          ((paddedBarWidth - barWidth) / 2),
          graphDisplayHeight / 2 - getHeightOfSection(barData.high),
          barWidth,
          getHeightOfSection(barData.range)),
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
        Offset(
          startPoint.dx,
          graphDisplayHeight / 2 - getHeightOfSection(graphBar.average),
        ),
        netPointRadius,
        Paint()..color = Colors.amber);
    canvas.drawCircle(
        Offset(
          startPoint.dx,
          graphDisplayHeight / 2 - getHeightOfSection(graphBar.average),
        ),
        netPointRadius - netPointThickness,
        Paint()..color = Colors.white);
  }

  _plotNetLine(
      Canvas canvas, Offset startPoint, Offset endPoint, GraphBar barData) {
    // if (startPoint.y != initialHeight) {
    if (barData.month != data.bars.first.month) {
      canvas.drawLine(
          Offset(startPoint.dx - netPointRadius, startPoint.dy),
          Offset(endPoint.dx + netPointRadius, endPoint.dy),
          Paint()
            ..color = Colors.amber
            ..strokeWidth = 2);
    }
    endPoint = Offset(startPoint.dx - paddedBarWidth, startPoint.dy);
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
    // if (section.value > 0) {

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
    return false;
  }
}

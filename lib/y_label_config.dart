part of stacked_bar_chart;

class YLabelConfiguration {
  ///The number of labels drawin in Y-axis
  final int labelCount;

  ///The interval of the labels to be drawn
  final double interval;

  ///Add styling to the Y-axis labels
  final TextStyle? labelStyle;

  ///This parameter maps the values as Y-Axis labels
  final String Function(num)? labelMapper;

  YLabelConfiguration({
    this.labelCount = 5,
    this.interval = 500,
    this.labelStyle,
    this.labelMapper,
  });
}

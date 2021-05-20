part of stacked_bar_chart;

class XLabelConfiguration {
  ///Add styling to the X-axis labels
  final TextStyle? labelStyle;

  ///This parameter maps the values as X-Axis labels
  final String Function(DateTime p1)? labelMapper;

  XLabelConfiguration({
    this.labelStyle,
    this.labelMapper,
  });
}

part of stacked_bar_chart;

class YLabelConfiguration {
  ///The number of labels drawin in Y-axis
  final int labelCount;
  //The interval of the labels to be drawn
  final double interval;

  YLabelConfiguration({
    this.labelCount = 5,
    this.interval = 500,
  });
}

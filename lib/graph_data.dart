part of stacked_bar_chart;

class GraphData {
  final Color backgroundColor;
  final String name;
  final List<GraphBar> bars;

  double get initialHeight {
    return bars.first.average;
  }

  double get high {
    List<double> allHigh = bars.map((e) => e.high).toList();
    allHigh.sort((a, b) => (a - b).round());
    return allHigh.first;
  }

  double get low {
    List<double> allLow = bars.map((e) => e.low).toList();
    allLow.sort((a, b) => (a - b).round());
    return allLow.first;
  }

  double get cumulativeHigh {
    List<double> allHigh = bars.map((e) {
      double tot = 0;
      e.sections.forEach((element) {
        if (element.value > 0) tot = tot + element.value;
      });
      return tot;
    }).toList();
    allHigh.sort((a, b) => (a - b).round());
    return allHigh.last;
  }

  double get cumulativeLow {
    List<double> allLow = bars.map((e) {
      double tot = 0;
      e.sections.forEach((element) {
        if (element.value < 0) tot = tot + element.value;
      });
      return tot;
    }).toList();
    allLow.sort((a, b) => (a - b).round());
    return allLow.first;
  }

  double get range {
    return high - low;
  }

  DateTime get maxMonth {
    List<DateTime> allMonths = bars.map((e) => e.month).toList();

    allMonths.sort((m1, m2) => m1.compareTo(m2));
    return allMonths.last;
  }

  DateTime get minMonth {
    List<DateTime> allMonths = bars.map((e) => e.month).toList();
    allMonths.sort((m1, m2) => m1.compareTo(m2));
    return allMonths.first;
  }

  List<DateTime> get months {
    List<DateTime> months = [];
    DateTime currentMonth = minMonth;
    do {
      months.add(currentMonth);
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    } while (maxMonth.compareTo(currentMonth) >= 0);
    return months;
  }

  double get digitLength {
    int len = cumulativeHigh.toInt().toString().length;
    return len / len - 1;
  }

  GraphData({
    @required this.name,
    @required this.bars,
    @required this.backgroundColor,
  });

  toMap() {
    return {
      "name": name,
      "backgroundColor": backgroundColor.value,
      "bars": bars.map((GraphBar e) => e.toMap()).toList(),
    };
  }

  static GraphData fromMap(Map<String, dynamic> data) {
    return GraphData(
      backgroundColor: Color(data["backgroundColor"]),
      name: data["name"],
      bars: data["bars"].map<GraphBar>((e) => GraphBar.fromMap(e)).toList(),
    );
  }
}

class GraphBar {
  DateTime month;
  List<GraphBarSection> sections;
  GraphBar({this.month, this.sections}) : assert(sections.length > 0);

  double get average {
    return sections
        .map((e) => e.value)
        .reduce((value, element) => value + element);
  }

  double get range {
    return high - low;
  }

  double get high {
    return sections
        .map((e) {
          return e.value;
        })
        .where((e) => e > 0 || e == 0)
        .reduce((value, element) => value + element);
  }

  double get low {
    return sections
        .map((e) => e.value)
        .where((e) => e < 0 || e == 0)
        .reduce((value, element) => value + element);
  }

  toMap() {
    return {
      "month": month.toIso8601String(),
      "sections": sections.map((e) => e.toMap()).toList(),
    };
  }

  static GraphBar fromMap(Map<String, dynamic> data) {
    return GraphBar(
        month: DateTime.parse(data["month"]),
        sections: data["sections"]
            .map<GraphBarSection>((e) => GraphBarSection.fromMap(e))
            .toList());
  }
}

class GraphBarSection {
  final double value;
  final Color color;

  GraphBarSection({
    @required this.value,
    this.color = Colors.red,
  });
  toMap() {
    return {
      "value": value.toDouble(),
      "color": color.value,
    };
  }

  static GraphBarSection fromMap(Map<String, dynamic> data) {
    return GraphBarSection(
      value: data["value"].toDouble(),
      color: Color(data["color"]),
    );
  }
}

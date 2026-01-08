import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartStatus extends StatelessWidget {
  final void Function(FlTouchEvent, PieTouchResponse?)? touchCallback;
  final List<PieChartSectionData>? sections;
  const PieChartStatus({super.key, this.touchCallback, this.sections});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: touchCallback,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: sections,
        ),
      ),
    );
  }
}

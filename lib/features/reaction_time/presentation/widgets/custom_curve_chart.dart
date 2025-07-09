import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:optikick/features/reaction_time/data/models/graph_data_model.dart';

import '../../data/models/graph_statstics_model.dart';

class CustomCurveChart extends StatelessWidget {
  final GraphDataModel graphDataModel;

  const CustomCurveChart({super.key, required this.graphDataModel});

  @override
  Widget build(BuildContext context) {
    final List<GraphStasticsModel> graphData = graphDataModel.graphData ?? [];

    final List<double> values = graphData
        .map((e) => (e.value is num) ? (e.value as num).toDouble() : 0.0)
        .toList();

    final List<String> days = graphData
        .map((e) => e.date != null ? e.date!.substring(0, 3) : '')
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 4, 21, 10),
            Color.fromARGB(255, 40, 59, 52),
            Color(0xff5D6E68),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _generateYAxisLabels(values),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: ChartGridPainter(),
                      ),
                      LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      index < days.length ? days[index] : '',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                reservedSize: 24,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: (values.length - 1).toDouble(),
                          minY: values.isNotEmpty
                              ? values.reduce((a, b) => a < b ? a : b) - 5
                              : 0,
                          maxY: values.isNotEmpty
                              ? values.reduce((a, b) => a > b ? a : b) + 5
                              : 100,
                          lineBarsData: [
                            LineChartBarData(
                              spots: values.asMap().entries.map((entry) {
                                return FlSpot(
                                    entry.key.toDouble(), entry.value);
                              }).toList(),
                              curveSmoothness: 0.3,
                              color: const Color.fromARGB(255, 229, 194, 132),
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateYAxisLabels(List<double> values) {
    if (values.isEmpty) return [];
    final double min = values.reduce((a, b) => a < b ? a : b);
    final double max = values.reduce((a, b) => a > b ? a : b);
    final step = ((max - min) / 4).clamp(1, double.infinity);
    return List.generate(5, (i) {
      final val = (max - (step * i)).toStringAsFixed(0);
      return Text(
        val,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      );
    });
  }
}

class ChartGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withAlpha(50)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final yStep = size.height / 4;
    for (var i = 0; i <= 4; i++) {
      final y = i * yStep;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
